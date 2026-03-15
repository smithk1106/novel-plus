package com.ideaflow.noveldownload.novel.parse;

import static com.ideaflow.noveldownload.constans.CommonConst.NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.web.client.HttpClientErrorException;

import com.ideaflow.noveldownload.config.WebSocketContext;
import com.ideaflow.noveldownload.novel.context.BookContext;
import com.ideaflow.noveldownload.novel.context.HttpClientContext;
import com.ideaflow.noveldownload.novel.convert.ChapterConverter;
import com.ideaflow.noveldownload.novel.convert.ChineseConverter;
import com.ideaflow.noveldownload.novel.core.ChapterFilter;
import com.ideaflow.noveldownload.novel.core.Source;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;
import com.ideaflow.noveldownload.novel.model.ContentType;
import com.ideaflow.noveldownload.novel.model.Rule;
import com.ideaflow.noveldownload.novel.util.CrawlUtils;
import com.ideaflow.noveldownload.novel.util.JsoupUtils;
import com.ideaflow.noveldownload.websocket.websocketcore.sender.WebSocketMessageSender;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.lang.Console;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Response;

@Slf4j
public class ChapterParser extends Source {

    private final ChapterConverter chapterConverter;

    public ChapterParser(AppConfig config) {
        super(config);
        this.chapterConverter = new ChapterConverter(config);
    }

    // 用于测试
    @SneakyThrows
    public Chapter testParse(Chapter chapter) {
        Rule.Chapter r = this.rule.getChapter();
        OkHttpClient client = HttpClientContext.get();
        String html = CrawlUtils.requestHtml(client, chapter.getUrl(), r.getTimeout());
        Document document = Jsoup.parse(html, r.getBaseUri());

        chapter.setTitle(JsoupUtils.selectAndInvokeJs(document, r.getTitle()));
        String content = fetchContent(chapter.getUrl(), RandomUtil.randomInt(100, 200));
        chapter.setContent(content);
        String filteredContent = new ChapterFilter(config).filter(chapter);
        chapter.setCleanContent(filteredContent);  // 设置过滤后的内容
        chapter.setWordCount(chapter.getCleanContent().length());

        return chapter;
    }

    public Chapter parse(Chapter chapter) {
        try {
            long interval = CrawlUtils.randomInterval(config);
            if (config.getShowDownloadLog() == 1) {
               Console.log("[D]正在下载:{}【{}】{}. 间隔: {}ms", chapter.getOrder(), chapter.getTitle(), chapter.getUrl(), interval);
            }

            String content = fetchContent(chapter.getUrl(), interval);
            Assert.notEmpty(content, "正文内容为空");
            chapter.setContent(content);

            return chapterConverter.convert(chapter);
            // if (StrUtil.isNotBlank(this.rule.getLanguage()) && this.rule.getLanguage().toLowerCase().contains("zh")) {
            //     // 确保简繁互转最后调用
            //     return ChineseConverter.convert(chapterConverter.convert(chapter), this.rule.getLanguage(), config.getLanguage());
            // } else {
            //     return chapterConverter.convert(chapter);
            // }
        } catch (HttpClientErrorException e) {
            log.error(String.format("[E]Bad response: %d %s", e.getStatusCode().value(), e.getMessage()));
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            Chapter retryChapter = retry(chapter, e.getMessage());
            return retryChapter;
            //return retryChapter == null ? null : ChineseConverter.convert(retryChapter, this.rule.getLanguage(), config.getLanguage());
        }
    }

    private Chapter retry(Chapter chapter, String errMsg) {
        WebSocketMessageSender webSocketMessageSender = WebSocketContext.getSender();
        String sessionId = WebSocketContext.getSessionId();
        for (int attempt = 1; attempt <= config.getMaxRetryAttempts(); attempt++) {
            try {
                long interval = CrawlUtils.randomInterval(config, true);

                webSocketMessageSender.send(sessionId, NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]【%s】下载失败，正在重试。重试次数: %d/%d 重试间隔: %d ms 原因: %s", chapter.getTitle(), attempt, config.getMaxRetryAttempts(), interval, errMsg)));
                String content = fetchContent(chapter.getUrl(), interval);
                Assert.notEmpty(content, "正文内容为空");
                chapter.setContent(content);

                webSocketMessageSender.send(sessionId, NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]重试成功: 【%s】", chapter.getTitle())));
                return chapterConverter.convert(chapter);

            } catch (Exception e) {
                webSocketMessageSender.send(sessionId, NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]第 %d 次重试失败: 【%s】 原因: %s", attempt, chapter.getTitle(), e.getMessage())));
                if (attempt == config.getMaxRetryAttempts()) {
                    // 最终失败时记录日志
                    saveDownloadErrorLog(chapter, e.getMessage());
                }
            }
        }

        return null;
    }

    private void saveDownloadErrorLog(Chapter chapter, String errMsg) {
        Book book = BookContext.get();
        String line = StrUtil.format("[E]《{}》({})下载失败章节: {}【{}】({}). 原因: {}", book.getBookName(), book.getAuthorName(), chapter.getOrder(), chapter.getTitle(), chapter.getUrl(), errMsg);
        log.error(line);
    }

    /**
     * 爬取正文内容
     *
     * @param url      章节 url
     * @param interval 爬取间隔（毫秒）
     */
    @SneakyThrows
    public String fetchContent(String url, long interval) {
        Rule.Chapter r = rule.getChapter();
        return r.isPagination()
                ? fetchPaginatedContent(url, interval, r)
                : fetchSinglePageContent(url, interval, r);
    }

    @SneakyThrows
    private String fetchSinglePageContent(String url, long interval, Rule.Chapter r) {
        OkHttpClient client = HttpClientContext.get();
        String html = CrawlUtils.requestHtml(client, url, r.getTimeout());

        if (StrUtil.isNotBlank(html)) {
            //cn.hutool.core.lang.Console.log("[D]Html: {}", html);
            Document doc = Jsoup.parse(html, r.getBaseUri());

            Elements contentEls = JsoupUtils.select(doc, r.getContent());
            JsoupUtils.clearAllAttributes(contentEls);

            Thread.sleep(interval);

            return JsoupUtils.invokeJs(r.getContent(), contentEls.html());
        }
        return "";
    }

    @SneakyThrows
    private String fetchPaginatedContent(String startUrl, long interval, Rule.Chapter r) {
        String nextUrl = startUrl;
        StringBuilder contentBuilder = new StringBuilder();
        OkHttpClient client = HttpClientContext.get();

        while (true) {
            String html = CrawlUtils.requestHtml(client, nextUrl, r.getTimeout());
            Document doc = Jsoup.parse(html, r.getBaseUri());

            String content = JsoupUtils.selectAndInvokeJs(doc, r.getContent(), ContentType.HTML);
            // String ==> Elements
            //Elements contentEls = Jsoup.parse(content).children();
            //JsoupUtils.clearAllAttributes(contentEls);
            contentBuilder.append(content);

            // 获取下一页按钮元素
            Elements nextEls = JsoupUtils.select(doc, r.getNextPage());
            String candidateNext = resolveNextUrl(doc, nextEls, r);
            if (isLastPage(candidateNext, nextEls, r)) {
                break;
            }

            nextUrl = candidateNext;
            Thread.sleep(interval);
        }

        return contentBuilder.toString();
    }

    private String resolveNextUrl(Document doc, Elements nextEls, Rule.Chapter r) {
        // 从 JS 获取下一页链接
        if (r.getNextPageInJs() != null) {
            return JsoupUtils.selectAndInvokeJs(doc, r.getNextPageInJs(), ContentType.HTML);
        }
        // FIXME nextEls NPE https://github.com/freeok/so-novel/issues/148#issuecomment-2826226097
        if (nextEls.isEmpty()) {
            Console.error("分页章节正文获取为空，可能被限流！\n出错链接：{}\n链接内容：{}", doc.baseUri(), doc.body().text());
            return null;
        }
        // 从按钮获取下一页链接
        return nextEls.first().absUrl("href");
    }

    private boolean isLastPage(String nextUrl, Elements nextEls, Rule.Chapter r) {
        if (nextUrl == null) {
            return true;
        }

        // 正则判断是否为章节最后一页
        boolean endByChapterRule = r.getNextChapterLink() != null && nextUrl.matches(r.getNextChapterLink());
        // 通用规则，大多数分页的 url 以 "_个位数字.html" 结尾。&& 部分网站会用“下一章”代替“下一页”
        boolean genericEnd = !nextUrl.matches(".*[-_]\\d\\.html") && nextEls.text().matches(".*(下一章|没有了|>>|书末页).*");

        return endByChapterRule || genericEnd;
    }

}
package com.ideaflow.noveldownload.novel.parse;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import static org.fusesource.jansi.AnsiRenderer.render;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.util.StringUtils;

import com.ideaflow.noveldownload.config.WebSocketContext;
import static com.ideaflow.noveldownload.constans.CommonConst.NOVEL_NAME_SEARCH_CONSOLE_MESSAGE_LISTENER;
import com.ideaflow.noveldownload.novel.context.HttpClientContext;
import com.ideaflow.noveldownload.novel.convert.ChineseConverter;
import com.ideaflow.noveldownload.novel.core.Source;
import com.ideaflow.noveldownload.novel.handle.SearchResultsHandler;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.ContentType;
import com.ideaflow.noveldownload.novel.model.Rule;
import com.ideaflow.noveldownload.novel.model.SearchResult;
import com.ideaflow.noveldownload.novel.util.CrawlUtils;
import com.ideaflow.noveldownload.novel.util.JsoupUtils;
import com.ideaflow.noveldownload.websocket.websocketcore.sender.WebSocketMessageSender;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Console;
import cn.hutool.core.lang.ConsoleTable;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ReUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.URLUtil;
import cn.hutool.json.JSONUtil;
import lombok.SneakyThrows;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
/**
 * 搜索解析器，负责处理搜索请求和结果解析
 * <p>
 * 1. 支持分页搜索
 * 2. 支持多种查询方式（CSS/XPath）
 * 3. 支持 JS 脚本执行
 */
public class SearchParser extends Source {

    public static final int TEXT_LIMIT_LENGTH = 30;
    public final OkHttpClient client = HttpClientContext.get();

    public SearchParser(AppConfig config) {
        super(config);
    }

    public List<SearchResult> parse(String keyword, boolean isSort) {
        return isSort ? SearchResultsHandler.sort(parse(keyword)) : parse(keyword);
    }

    @SneakyThrows
    public List<SearchResult> parse(String keyword) {
        Rule.Search r = this.rule.getSearch();
        WebSocketMessageSender webSocketMessageSender = WebSocketContext.getSender();
        String sessionId = WebSocketContext.getSessionId();
        if (r == null) {
            webSocketMessageSender.send(sessionId, NOVEL_NAME_SEARCH_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]书源 %s 不支持搜索", config.getSourceId())));
            return Collections.emptyList();
        }
        if (this.rule.isDisabled()) {
            Console.error(render("[!]书源 {} 已禁用", "yellow"), this.rule.getId());
            return Collections.emptyList();
        }

        String searchUrl = r.getUrl().formatted(keyword);
        String html = "";
        Document document;
        try {
            Request.Builder builder = new Request.Builder().url(searchUrl);

            if (r.getHeaders() != null && r.getHeaders().size() > 0) {
                r.getHeaders().forEach((k, v) -> {
                    builder.addHeader(k, v);
                });
            }
            if ("post".equalsIgnoreCase(r.getMethod())) {
                builder.post(CrawlUtils.buildData(r.getData(), keyword));
            }

            html = CrawlUtils.requestHtml(client, builder, r.getTimeout());
            document = Jsoup.parse(html, r.getBaseUri());
        } catch (Exception e) {
            String errorMsg = e.getMessage();
            if (errorMsg != null && (errorMsg.toLowerCase().contains("timeout") || errorMsg.toLowerCase().contains("timed out"))) {
                errorMsg += "，建议更换网络环境后重试";
            }
            webSocketMessageSender.send(sessionId, NOVEL_NAME_SEARCH_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]书源 %s  (%s ) 搜索解析出错: %s ", this.rule.getId(), this.rule.getName(), errorMsg)));
            return Collections.emptyList();
        }

        List<SearchResult> firstPageResults = getSearchResults(searchUrl, html);
        if (firstPageResults.size() == 0) {
            cn.hutool.core.lang.Console.log("[!]搜索结果为空。Html: {}", html);
        }

        // 搜索结果无分页
        if (!r.isPagination()) {
            return firstPageResults;
        }

        // 注意，css 或 xpath 的查询结果必须为多个 a 元素
        Elements nextPageUrls = JsoupUtils.select(document, r.getNextPage());
        // 只有一页时，底部可能没有分页菜单
        if (nextPageUrls.isEmpty()) {
            return firstPageResults;
        }
        // 分页搜索结果的 URL，不含首页
        Set<String> urls = new LinkedHashSet<>();
        // 一次性获取分页 URL，不考虑逐个点击下一页的情况
        for (Element e : nextPageUrls) {
            String href = e.absUrl("href");
            // 中文解码，针对69書吧
            urls.add(URLUtil.decode(href));
        }
        // 使用并行流处理分页 URL
        List<SearchResult> additionalResults = urls.parallelStream()
                .flatMap(url -> getSearchResults(url, null).stream())
                .toList();
        // 合并，不去重（去重用 union）
        List<SearchResult> searchResults = CollUtil.unionAll(firstPageResults, additionalResults);
        // TODO 优化，需要几条获取几条，而不是一次性获取然后截取
        return CollUtil.sub(searchResults, 0, config.getSearchLimit());
    }

    private List<SearchResult> getSearchResults(String url, String html) {
        Rule.Search r = this.rule.getSearch();
        List<SearchResult> list = new ArrayList<>();
        try {
            // 搜索结果页 DOM
            Document document;
            if (html == null) {
                html = CrawlUtils.requestHtml(client, url, r.getTimeout());
                document = Jsoup.parse(html, r.getBaseUri());
                // try (Response resp2 = CrawlUtils.request(client, url, r.getTimeout())) {
                //     // peekBody 不会关闭原body流，可以拿一份副本出来
                //     document = Jsoup.parse(resp2.peekBody(Long.MAX_VALUE).string(), r.getBaseUri());
                // }
            } else {
                document = Jsoup.parse(html, r.getBaseUri());
            }

            Elements resultEls = document.select(r.getResult());
            cn.hutool.core.lang.Console.log("[D]Search result: {}", resultEls.html());

            // 部分书源完全匹配时会直接跳转到详情页（搜索结果为空 && 书名不为空），故需要构造搜索结果
            if (resultEls.isEmpty() && !document.select(this.rule.getBook().getBookName()).isEmpty()) {
                String bookUrl = url;
                BookParser bookParser = new BookParser(config);
                Book book = bookParser.parse(bookUrl);
                cn.hutool.core.lang.Console.log("[D][{}]Found book {}({})", this.rule.getName(), book.getBookName(), book.getAuthorName());

                if (StrUtil.isBlank(book.getBookName())) {
                    return Collections.emptyList();
                }

                SearchResult sr = SearchResult.builder()
                        .sourceId(this.rule.getId())
                        .url(bookUrl)
                        .bookName(book.getBookName())
                        .author(book.getAuthorName())
                        .latestChapter(book.getLastChapterName())
                        .lastUpdateTime(DateUtil.format(book.getLastUpdateTime(), "yyyy-MM-dd HH:mm:ss"))
                        .build();
                list.add(sr);
                //list.add(ChineseConverter.convert(sr, this.rule.getLanguage(), config.getLanguage()));
                Thread.sleep(CrawlUtils.randomInterval(config));

                return list;
            }

            // 只获取前 N 条搜索记录
            List<Element> limitResultEls = resultEls.stream()
                    .filter(e -> StrUtil.isNotEmpty(JsoupUtils.selectAndInvokeJs(e, r.getBookName())))
                    .limit(config.getSearchLimit())
                    .toList();

            for (Element el : limitResultEls) {
                // jsoup 不支持一次性获取属性的值
                String href = "";
                if (StringUtils.hasText(r.getBookUrl())) {
                    if (r.getBookUrl().startsWith("http")) {
                        href = r.getBookUrl();
                    } else {
                        href = JsoupUtils.selectAndInvokeJs(el, r.getBookUrl());
                    }
                } else {
                    href = JsoupUtils.selectAndInvokeJs(el, r.getBookName(), ContentType.ATTR_HREF);
                }
                String bookName = JsoupUtils.selectAndInvokeJs(el, r.getBookName());
                // 以下为非必须属性
                String author = JsoupUtils.selectAndInvokeJs(el, r.getAuthor());
                String category = JsoupUtils.selectAndInvokeJs(el, r.getCategory());
                String latestChapter = JsoupUtils.selectAndInvokeJs(el, r.getLatestChapter());
                String lastUpdateTime = JsoupUtils.selectAndInvokeJs(el, r.getLastUpdateTime());
                String status = JsoupUtils.selectAndInvokeJs(el, r.getStatus());
                String wordCount = JsoupUtils.selectAndInvokeJs(el, r.getWordCount());
                cn.hutool.core.lang.Console.log("[D][{}]Found {}({})", this.rule.getName(), bookName, author);

                if (bookName.isEmpty()) continue;

                SearchResult sr = SearchResult.builder()
                        .sourceId(this.rule.getId())
                        .url(href)
                        .bookName(bookName)
                        .author(author)
                        .category(category)
                        .latestChapter(latestChapter)
                        .lastUpdateTime(lastUpdateTime)
                        .status(status)
                        .wordCount(wordCount)
                        .build();

                list.add(sr);
                //list.add(ChineseConverter.convert(sr, this.rule.getLanguage(), config.getLanguage()));
            }
        } catch (Exception e) {
            Console.error(e);
            return Collections.emptyList();
        }

        return list;
    }

    public void printSearchResult(List<SearchResult> results) {
        Rule.Search r = this.rule.getSearch();
        if (r == null || CollUtil.isEmpty(results)) {
            return;
        }

        ConsoleTable consoleTable = ConsoleTable.create();
        for (int i = 1; i <= results.size(); i++) {
            SearchResult sr = results.get(i - 1);
            List<String> cols = ListUtil.toList(String.valueOf(i), sr.getBookName());
            boolean existsAuthor = addColumnIfNotEmpty(cols, r.getAuthor(), sr.getAuthor());
            boolean existsCategory = addColumnIfNotEmpty(cols, r.getCategory(), sr.getCategory());
            boolean existsLatestChapter = addColumnIfNotEmpty(cols, r.getLatestChapter(), StrUtil.subPre(sr.getLatestChapter(), TEXT_LIMIT_LENGTH));
            boolean existsLastUpdateTime = addColumnIfNotEmpty(cols, r.getLastUpdateTime(), ReUtil.replaceAll(sr.getLastUpdateTime(), "\\d{2}:\\d{2}(:\\d{2})?", ""));
            boolean existsStatus = addColumnIfNotEmpty(cols, r.getStatus(), sr.getStatus());
            boolean existsWordCount = addColumnIfNotEmpty(cols, r.getWordCount(), sr.getWordCount());
            // 构造表头
            if (i == 1) {
                // 必定存在的列
                List<String> titles = ListUtil.toList("序号", "书名");
                if (existsAuthor) titles.add("作者");
                if (existsCategory) titles.add("类别");
                if (existsLatestChapter) titles.add("最新章节");
                if (existsLastUpdateTime) titles.add("更新时间");
                if (existsStatus) titles.add("状态");
                if (existsWordCount) titles.add("总字数");
                consoleTable.addHeader(ArrayUtil.toArray(titles, String.class));
            }
            consoleTable.addBody(ArrayUtil.toArray(cols, String.class));
        }

        Console.table(consoleTable);
    }

    // 辅助方法：只有非空的情况下才添加列
    private boolean addColumnIfNotEmpty(List<String> list, String rule, String value) {
        if (StrUtil.isNotEmpty(rule)) {
            list.add(StrUtil.isNotEmpty(value) ? value : "");
            return true;
        }
        return false;
    }

    public static void printAggregateSearchResult(List<SearchResult> results) {
        ConsoleTable consoleTable = ConsoleTable.create().addHeader("序号", "书名", "作者", "最新章节", "最后更新时间", "书源");
        for (int i = 1; i <= results.size(); i++) {
            SearchResult sr = results.get(i - 1);

            if (sr.getLatestChapter() == null) {
                sr.setLatestChapter("/");
            } else {
                sr.setLatestChapter(StrUtil.subPre(sr.getLatestChapter(), TEXT_LIMIT_LENGTH));
            }
            if (sr.getLastUpdateTime() == null) {
                sr.setLastUpdateTime("/");
            }

            consoleTable.addBody(
                    String.valueOf(i),
                    sr.getBookName(),
                    sr.getAuthor(),
                    sr.getLatestChapter(),
                    ReUtil.replaceAll(sr.getLastUpdateTime(), "\\d{2}:\\d{2}(:\\d{2})?", ""),
                    String.valueOf(sr.getSourceId())
            );
        }
        Console.table(consoleTable);
    }

}
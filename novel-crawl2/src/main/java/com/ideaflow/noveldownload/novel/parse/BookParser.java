package com.ideaflow.noveldownload.novel.parse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import com.ideaflow.noveldownload.constans.EnumBookCategory;
import com.ideaflow.noveldownload.novel.context.HttpClientContext;
import com.ideaflow.noveldownload.novel.convert.ChineseConverter;
import com.ideaflow.noveldownload.novel.core.CoverUpdater;
import com.ideaflow.noveldownload.novel.core.Source;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.ContentType;
import com.ideaflow.noveldownload.novel.model.Rule;
import com.ideaflow.noveldownload.novel.util.CrawlUtils;
import com.ideaflow.noveldownload.novel.util.FormatUtils;
import com.ideaflow.noveldownload.novel.util.JsoupUtils;

import cn.hutool.core.util.StrUtil;
import lombok.SneakyThrows;
import okhttp3.OkHttpClient;


public class BookParser extends Source {

    public final OkHttpClient client = HttpClientContext.get();

    public BookParser(AppConfig config) {
        super(config);
    }

    @SneakyThrows
    public Book parse(String url) {
        Rule.Book r = this.rule.getBook();

        String html = CrawlUtils.requestHtml(client, url, r.getTimeout());
        Document document = Jsoup.parse(html, r.getBaseUri());

        String bookName = JsoupUtils.selectAndInvokeJs(document, r.getBookName());
        String author = JsoupUtils.selectAndInvokeJs(document, r.getAuthor());
        String intro = CrawlUtils.replaceIntroTags(JsoupUtils.selectAndInvokeJs(document, r.getIntro(), JsoupUtils.getContentType(r.getIntro(), ContentType.HTML)));
        if (intro.length() > 2000) {
            intro = intro.substring(0, 1995) + "...";
        }
        String coverUrl = JsoupUtils.selectAndInvokeJs(document, r.getCoverUrl(), JsoupUtils.getContentType(r.getCoverUrl(), ContentType.ATTR_SRC));
        if (StrUtil.isNotBlank(coverUrl) && coverUrl.startsWith("//")) {
            coverUrl = url.substring(0, url.indexOf(':') + 1) + coverUrl;
        }
        // 以下为非必须属性
        String categoryStr = JsoupUtils.selectAndInvokeJs(document, r.getCategory());
        String latestChapter = JsoupUtils.selectAndInvokeJs(document, r.getLatestChapter());
        String lastUpdateTime = JsoupUtils.selectAndInvokeJs(document, r.getLastUpdateTime());
        String status = JsoupUtils.selectAndInvokeJs(document, r.getStatus());
        String wordCount = JsoupUtils.selectAndInvokeJs(document, r.getWordCount());
        EnumBookCategory category = guessCategory(categoryStr);
        if (category == EnumBookCategory.UNKNOWN) {
            category = guessCategory(bookName);
        }

        Book book = new Book();
        book.setUrl(url);
        book.setBookName(bookName);
        book.setAuthorName(author);
        book.setBookDesc(intro);
        book.setPicUrl(CoverUpdater.fetchCover(book, coverUrl));
        book.setCatId(category.getCode());
        book.setCatName(category.getDescription());
        book.setLastChapterName(latestChapter);
        book.setLastUpdateTime(FormatUtils.parseDate(lastUpdateTime, null));
        book.setBookStatus(status != null && (status.contains("完结") || status.contains("全本")) ? (byte)1 : (byte)0);
        book.setWordCount(FormatUtils.parseInt(wordCount, 0));
        book.setSaveType(config.getExtName());

        return book;
        //return ChineseConverter.convert(book, this.rule.getLanguage(), config.getLanguage());
    }

    /**
     * 猜测分类
     * 
     * @param categoryString 分类字符串
     * @return 猜测的分类
     */
    public EnumBookCategory guessCategory(String categoryString) {
        EnumBookCategory bookCategory = EnumBookCategory.UNKNOWN;
        
        if (categoryString == null || categoryString.isEmpty()) {
            return bookCategory;
        }
        // 遍历所有枚举值，匹配包含的分类
        for (EnumBookCategory cat : EnumBookCategory.values()) {
            String[] categories = cat.getDescription().split(",");
            for (String catDesc : categories) {
                if (categoryString.contains(catDesc)) {
                    bookCategory = cat;
                    break;
                }
            }
            if (bookCategory != EnumBookCategory.UNKNOWN) {
                break;
            }
        }

        return bookCategory;
    }
}
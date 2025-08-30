package com.ideaflow.noveldownload.novel.handle;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;
import com.ideaflow.noveldownload.novel.util.FormatUtils;
import com.ideaflow.noveldownload.service.BookService;

import cn.hutool.core.io.file.FileWriter;
import cn.hutool.extra.template.Template;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.TemplateUtil;

public class HtmlTocHandler implements PostProcessingHandler {

    private final TemplateEngine engine = TemplateUtil.createEngine(new TemplateConfig("templates", TemplateConfig.ResourceMode.CLASSPATH));

    private AppConfig config;

    private BookService bookService;

    HtmlTocHandler(AppConfig config, BookService bookService) {
        this.config = config;
        this.bookService = bookService;
    }

    @Override
    public void handle(Book book, File saveDir) {
        List<Chapter> chapters = bookService.getChapters(book.getId(), 0, 0);
        Template template = engine.getTemplate("book_html.flt");
        Map<String, String> map = new HashMap<>();
        map.put("bookName", book.getBookName());
        map.put("author", book.getAuthorName());
        map.put("category", book.getCatName());
        map.put("intro", book.getBookDesc());
        map.put("status", book.getBookStatus() == 1 ? "已完结" : "连载中");
        map.put("coverUrl", book.getPicUrl().startsWith("http") ? book.getPicUrl() : (book.getPicUrl().startsWith("/") ? book.getPicUrl() : "/" + book.getPicUrl()));
        map.put("lastUpdate", FormatUtils.formatDate(book.getLastUpdateTime(), null));

        List<String> chapterList = new ArrayList<String>();
        for (Chapter chapter : chapters) {
            chapterList.add(String.format("<a href=\"%05d\">%s</a>", chapter.getOrder(), chapter.getTitle()));
        }
        map.put("chapters", String.join("\n", chapterList));

        String bookDetail = template.render(map);
        FileWriter fw = FileWriter.create(new File(saveDir, "index.html"), StandardCharsets.UTF_8);
        fw.write(bookDetail);
    }

}
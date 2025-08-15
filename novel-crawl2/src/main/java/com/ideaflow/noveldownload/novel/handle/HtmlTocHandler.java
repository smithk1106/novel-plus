package com.ideaflow.noveldownload.novel.handle;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.ideaflow.noveldownload.config.AppProperties;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.util.FileUtils;

import cn.hutool.core.io.file.FileReader;
import cn.hutool.core.io.file.FileWriter;
import cn.hutool.core.util.ReUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.template.Template;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.TemplateUtil;


public class HtmlTocHandler implements PostProcessingHandler {

    private final TemplateEngine engine = TemplateUtil.createEngine(new TemplateConfig("templates", TemplateConfig.ResourceMode.CLASSPATH));

    @Override
    public void handle(Book book, File saveDir) {
        String regex = "<title>(.*?)</title>";
        List<String> chapterList = new ArrayList<String>();
        List<File> files = FileUtils.sortFilesByName(saveDir);
        for (File file : files) {
            if (file.getName().endsWith(".html") && !file.getName().endsWith("index.html")) {
                FileReader reader = FileReader.create(file, StandardCharsets.UTF_8);
                // 获取 <title> 内容
                String title = ReUtil.getGroup1(regex, reader.readString());
                String chapterLink = StrUtil.format("<a href=\"{}\">{}</a>", file.getName(), title);
                chapterList.add(chapterLink);
            }
        }

        Template template = engine.getTemplate("book_html.flt");
        Map<String, String> map = new HashMap<>();
        map.put("bookName", book.getBookName());
        map.put("author", book.getAuthor());
        map.put("category", book.getCategory());
        map.put("intro", book.getIntro());
        map.put("status", book.getStatus());
        map.put("coverUrl", book.getCoverUrl().startsWith("http") ? book.getCoverUrl() : (book.getCoverUrl().startsWith("/") ? book.getCoverUrl() : "/" + book.getCoverUrl()));
        map.put("lastUpdate", book.getLastUpdateTime());
        map.put("chapters", String.join("\n", chapterList));

        String bookDetail = template.render(map);
        FileWriter fw = FileWriter.create(new File(saveDir, "index.html"), StandardCharsets.UTF_8);
        fw.write(bookDetail);
    }

}
package com.ideaflow.noveldownload.novel.convert;

import java.util.HashMap;
import java.util.Map;

import com.ideaflow.noveldownload.novel.core.ChapterFilter;
import com.ideaflow.noveldownload.novel.core.ChapterFormatter;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Chapter;

import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.template.Template;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.TemplateUtil;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public class ChapterConverter {

    private final AppConfig config;
    private final TemplateEngine engine = TemplateUtil.createEngine(new TemplateConfig("templates", TemplateConfig.ResourceMode.CLASSPATH));

    public Chapter convert(Chapter chapter) {
        String extName = config.getExtName();
        String filteredContent = new ChapterFilter(config).filter(chapter);
        chapter.setCleanContent(filteredContent);  // 设置过滤后的内容
        chapter.setWordCount(chapter.getCleanContent().length());

        if (extName.matches("(?i)^(txt|epub|html|pdf)$")) {
            String content = filteredContent;
            if ("txt".equals(extName)) {
                // 全角空格，用于首行缩进
                String ident = "\u3000".repeat(2);
                StringBuilder result = new StringBuilder();

                for (String line : filteredContent.split("\n")) {
                    if (!line.isBlank()) {
                        result.append(ident).append(line).append("\n");
                    }
                }
                content = chapter.getTitle() + "\n".repeat(2) + result;
            } else {
                content = new ChapterFormatter(config).format(filteredContent);
                chapter.setContent(content);
                content = templateRender(chapter, extName);
            }
            chapter.setContent(content);
        } else {
            chapter.setContent(filteredContent);
        }

        return chapter;
    }

    /**
     * 根据扩展名渲染对应模板
     */
    private String templateRender(Chapter chapter, String extName) {
        // epub 或 html 模板
        Template template = engine.getTemplate(StrUtil.format("chapter_{}.flt", extName));
        Map<String, String> map = new HashMap<>();
        map.put("title", chapter.getTitle());
        map.put("content", chapter.getContent());

        return template.render(map);
    }

}
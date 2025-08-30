package com.ideaflow.noveldownload.novel.core;


import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Rule;

import cn.hutool.core.util.StrUtil;
import lombok.AllArgsConstructor;


@AllArgsConstructor
public class ChapterFormatter {

    private final AppConfig config;

    /**
     * 格式化正文排版
     */
    public String format(String content) {
        Rule.Chapter r = new Source(config).rule.getChapter();
        StringBuilder contentBuilder = new StringBuilder();
        String paragrapTag = StrUtil.isBlank(r.getParagraphTag()) ? "p" : r.getParagraphTag();

        for (String line : content.split("\n")) {
            if (!line.isBlank()) {
                if ("br".equalsIgnoreCase(paragrapTag)) {
                    contentBuilder.append(line).append("<br>");
                } else {
                    contentBuilder.append("<p>").append(line).append("</p>");
                }
            }
        }

        return contentBuilder.toString();
    }

}
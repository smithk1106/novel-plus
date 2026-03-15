package com.ideaflow.noveldownload.novel.model;

import lombok.AllArgsConstructor;
import lombok.Getter;


@Getter
@AllArgsConstructor
public enum ContentType {

    TEXT("text"),
    HTML("html"),
    ATTR_SRC("src"),
    ATTR_HREF("href"),
    ATTR_CONTENT("content"),
    ATTR_VALUE("value"),
    ATTR_ANY("any"),
    ;

    private final String value;

}
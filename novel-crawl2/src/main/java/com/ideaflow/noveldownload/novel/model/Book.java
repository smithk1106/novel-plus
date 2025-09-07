package com.ideaflow.noveldownload.novel.model;

import java.util.Date;

import lombok.Data;


@Data
public class Book {
    private Long id;
    private String url;
    private String bookName;
    private String bookNameAlias = "";
    private String authorName;
    private String bookDesc;
    private int catId = 0;
    private String catName;
    private String picUrl;
    private String lastChapterName;
    private Long lastChapterId = 0L;
    private Date lastUpdateTime;
    private Byte bookStatus = 0;
    private Integer wordCount = 0;
    private Integer crawlSourceId;

    private String saveType;
    private String downloadUrl;
}
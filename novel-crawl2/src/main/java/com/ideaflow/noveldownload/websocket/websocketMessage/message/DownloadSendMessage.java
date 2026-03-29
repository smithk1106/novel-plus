package com.ideaflow.noveldownload.websocket.websocketMessage.message;

import lombok.Data;


@Data
public class DownloadSendMessage {
    /**
     * 请求的处理（start: 开始下载, stop: 停止下载）
     */
    private String action;
    /**
     * 小说URL
     */
    private String bookUrl;
    /**
     * 书源id
     */
    private Integer sourceId;
    /**
     * 検索结果id
     */    
    private String searchResultId;
    /**
     * 下载类型：默认下载全部，1-下载指定范围章节，2-下载最新章节
     */
    private Integer downloadType;
    /**
     * 开始章节号
     */
    private Integer startChapter;
    /**
     * 结束章节号
     */
    private Integer endChapter;
    /**
     * 最新章节数
     */
    private Integer latestChapterCount;
    /**
     * 单章ID
     * 例： URL(https://www.dxmwx.org/read/55178_48021105.html) -> ID(55178_48021105)
     */
    private String chapterId;
    /**
     * 更新目标章节号
     */
    private Integer toChapter;
    /**
     * 更新章节数
     */
    private Integer chapterCount;
    /**
     * 是否覆盖现存章节
     */
    private Boolean allowOverwrite = false;
}

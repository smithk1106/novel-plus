package com.ideaflow.noveldownload.websocket.websocketMessage;


import static com.ideaflow.noveldownload.constans.CommonConst.NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.WebSocketSession;

import com.ideaflow.noveldownload.config.WebSocketContext;
import com.ideaflow.noveldownload.entity.SearchResultEntity;
import com.ideaflow.noveldownload.mapper.SearchResultMapper;
import com.ideaflow.noveldownload.novel.context.HttpClientContext;
import com.ideaflow.noveldownload.novel.core.Crawler;
import com.ideaflow.noveldownload.novel.core.OkHttpClientFactory;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;
import com.ideaflow.noveldownload.novel.model.SearchResult;
import com.ideaflow.noveldownload.novel.parse.TocParser;
import com.ideaflow.noveldownload.novel.util.CrawlUtils;
import com.ideaflow.noveldownload.service.AppConfigService;
import com.ideaflow.noveldownload.service.BookService;
import com.ideaflow.noveldownload.websocket.config.WebSocketThreadLocal;
import com.ideaflow.noveldownload.websocket.websocketMessage.message.DownloadSendMessage;
import com.ideaflow.noveldownload.websocket.websocketcore.listener.WebSocketMessageListener;
import com.ideaflow.noveldownload.websocket.websocketcore.sender.WebSocketMessageSender;

import cn.hutool.core.date.StopWatch;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.json.JSONUtil;
import jakarta.annotation.Resource;


/**
 * WebSocket 示例：单发消息
 *
 * @author ideaflow
 */
@Component
public class NovelDownloadMessageListener implements WebSocketMessageListener<DownloadSendMessage> {

    @Resource
    private WebSocketMessageSender webSocketMessageSender;

    @Resource
    private AppConfigService appConfigService;

    @Resource
    private SearchResultMapper searchResultMapper;

    @Resource
    private BookService bookService;

    private ExecutorService executor = Executors.newFixedThreadPool(10);

    @Override
    public void onMessage(WebSocketSession session, DownloadSendMessage message) {
        // 收到停止请求
        if ("stop".equalsIgnoreCase(message.getAction())) {
            cn.hutool.core.lang.Console.log("[D]Stop download for book '{}'.", message.getBookUrl());
            WebSocketContext.stop(message.getBookUrl());
            return;
        }

        // 创建线程池
        executor.execute(() -> {
            try {
                // 载入配置
                AppConfig config = appConfigService.load();
                SearchResultEntity searchResultEntity = searchResultMapper.selectById(message.getSearchResultId());
                //WebSocketThreadLocal.setThreadLocalValue(session.getId());
                if (Objects.isNull(searchResultEntity)) {
                    webSocketMessageSender.send(session.getId(), "NovelDownloadConsoleMessageListener", JSONUtil.toJsonStr("[E]数据为空,请重新尝试搜索:id:"+message.getSearchResultId()));
                    return;
                }
                config.setSourceId(searchResultEntity.getSourceId());
                HttpClientContext.set(OkHttpClientFactory.create(config, true));
    
                // 获取章节目录
                webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr("[i]正在获取章节目录 ..."));
                SearchResult searchResult = JSONUtil.toBean(searchResultEntity.getContent(), SearchResult.class);
                TocParser catalogParser = new TocParser(config);
                List<Chapter> catalogs = catalogParser.parse(searchResult.getUrl(), 1, Integer.MAX_VALUE);
                // 准备下载参数
                List<Chapter> downloadCatalogs = new ArrayList<>();
                if (message.getDownloadType() == null || message.getDownloadType() == 0) {
                    // 默认下载全部
                    downloadCatalogs.addAll(catalogs);
                } else if (message.getDownloadType() == 1) {
                    int start = message.getStartChapter() != null ? message.getStartChapter() : 1;
                    int end = message.getEndChapter() != null ? message.getEndChapter() : catalogs.size();
                    start = Math.min(start, catalogs.size());
                    end = Math.min(catalogs.size(), end);
                    if (start > end) {
                        webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr("[E]章节范围参数不合法，请检查后重试。"));
                        return;
                    }
                    if (start > 0) {
                        start = Math.max(1, start);
                        downloadCatalogs.addAll(catalogs.subList(start - 1, end));
                    } else {
                        // 清空下载章节列表
                        // downloadCatalogs.clear();
                    }
                } else if (message.getDownloadType() == 2) {
                    // 下载最新章节
                    int count = message.getLatestChapterCount() != null ? message.getLatestChapterCount() : 1;
                    count = Math.min(count, catalogs.size());
                    if (count < 0 ) {
                        webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr("[E]最新章节数量参数不合法，请检查后重试。"));
                        return;
                    }
                    if (count > 0) {
                        downloadCatalogs.addAll(catalogs.subList(catalogs.size() - count, catalogs.size()));
                    } else {
                        // 清空下载章节列表
                        // downloadCatalogs.clear();
                    }
                } else if (message.getDownloadType() == 3) {
                    // 指定章节ID下载
                    int startChapter = -1;
                    int toChapter = message.getToChapter() != null ? message.getToChapter() : 0;
                    int count = message.getChapterCount() != null ? message.getChapterCount() : 1;
                    if (StringUtils.hasText(message.getChapterId())) {
                        String chapterId = message.getChapterId().trim();
                        for (int i = 0; i < catalogs.size(); i++) {
                            if (catalogs.get(i).getUrl().contains(chapterId)) {
                                startChapter = i;
                                break;
                            }
                        }
                    }
                    if (startChapter < 0 || toChapter <= 0) {
                        webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr("[E]章节下载参数不合法，请检查后重试。"));
                        return;
                    }
                    if (catalogs.size() <= startChapter + count) {
                        count = catalogs.size() - startChapter;
                    }
                    for (int n = 0; n < count; n++) {
                        downloadCatalogs.add(catalogs.get(startChapter + n));
                        downloadCatalogs.getLast().setOrder(toChapter + n);
                    }
                }
    
                String r1 =  String.format("[i]你选择了《%s》(%s)，共计 %s 章 数据源:%s %s,开始下载全本,请稍后",searchResult.getBookName(),searchResult.getAuthor(),catalogs.size(),config.getSourceId(),searchResult.getUrl());
                webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(r1));
                
                // 为防止被屏蔽，取得章节后稍等一下
                long interval = CrawlUtils.randomInterval(config);
                long waitTime = 0;
                while (waitTime < interval) {
                    Thread.sleep(1000);
                    if (WebSocketContext.isNeedStop(searchResult.getUrl())) {
                        webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]下载中止！")));
                        return;
                    }
                    waitTime += 1000;
                }
    
                StopWatch stopWatch = new StopWatch();
                stopWatch.start();

                WebSocketContext.setSender(webSocketMessageSender);
                WebSocketContext.setSessionId(session.getId());
    
                Book book = new Crawler(config, bookService).crawl(searchResult.getUrl(), downloadCatalogs, String.valueOf(catalogs.size()).length(), !message.getAllowOverwrite());
    
                stopWatch.stop();
    
                double totalTimeSeconds = stopWatch.getTotalTimeSeconds();
                if (book != null) {
                    webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]完成！总耗时 %s秒,请到我的书库查看: %s", NumberUtil.round(totalTimeSeconds, 2), book.getBookName())));
                } else {
                    webSocketMessageSender.send(session.getId(), NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]下载中止！总耗时 %s秒", NumberUtil.round(totalTimeSeconds, 2))));
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            } finally {
                WebSocketContext.clearSessionId();
                WebSocketContext.clearSender();
                WebSocketContext.clearStopFlag();
            }
        });
    }

    @Override
    public String getType() {
        return "NovelDownloadMessageListener";
    }
}

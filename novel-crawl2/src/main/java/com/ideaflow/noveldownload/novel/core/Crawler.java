package com.ideaflow.noveldownload.novel.core;

import static com.ideaflow.noveldownload.constans.CommonConst.NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER;
import static com.ideaflow.noveldownload.constans.CommonConst.NOVEL_NAME_SEARCH_CONSOLE_MESSAGE_LISTENER;
import static org.fusesource.jansi.AnsiRenderer.render;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.util.DigestUtils;

import com.ideaflow.noveldownload.config.WebSocketContext;
import com.ideaflow.noveldownload.constans.CommonConst;
import com.ideaflow.noveldownload.novel.context.BookContext;
import com.ideaflow.noveldownload.novel.handle.CrawlerPostHandler;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;
import com.ideaflow.noveldownload.novel.model.SearchResult;
import com.ideaflow.noveldownload.novel.parse.BookParser;
import com.ideaflow.noveldownload.novel.parse.ChapterParser;
import com.ideaflow.noveldownload.novel.parse.SearchParser;
import com.ideaflow.noveldownload.novel.util.FileUtils;
import com.ideaflow.noveldownload.novel.util.FormatUtils;
import com.ideaflow.noveldownload.service.BookService;
import com.ideaflow.noveldownload.websocket.websocketcore.sender.WebSocketMessageSender;

import cn.hutool.core.date.StopWatch;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.lang.Console;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.RuntimeUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONUtil;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class Crawler {

    private final AppConfig config;
    private String bookDir;
    private int digitCount;
    private boolean canSaveChapter = true;

    private BookService novelService;

    public Crawler(AppConfig config, BookService novelService) {
        this.config = config;
        this.novelService = novelService;
    }

    /**
     * 搜索小说
     *
     * @param keyword 关键字
     * @return 匹配的小说列表
     */
    public List<SearchResult> search(String keyword) {
        WebSocketMessageSender webSocketMessageSender = WebSocketContext.getSender();
        String sessionId = WebSocketContext.getSessionId();

        webSocketMessageSender.send(sessionId, NOVEL_NAME_SEARCH_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]正在搜索 %s...",keyword)));
        StopWatch stopWatch = new StopWatch();
        stopWatch.start();

        SearchParser searchResultParser = new SearchParser(config);
        List<SearchResult> searchResults = searchResultParser.parse(keyword);

        stopWatch.stop();
        webSocketMessageSender.send(sessionId, NOVEL_NAME_SEARCH_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]搜索到 %s 条记录，耗时 %s s", searchResults.size(), NumberUtil.round(stopWatch.getTotalTimeSeconds(), 2))));

        return searchResults;
    }


    /**
     * 爬取小说
     *
     * @param bookUrl 详情页链接
     * @param toc     章节目录
     */
    @SneakyThrows
    public Book crawl(String bookUrl, List<Chapter> toc, int digitCount) {
        Book book = new BookParser(config).parse(bookUrl);
        BookContext.set(book);
        WebSocketMessageSender webSocketMessageSender = WebSocketContext.getSender();
        String sessionId = WebSocketContext.getSessionId();
        File saveDir = null;

        this.digitCount = digitCount;
        book.setSaveType(config.getExtName().toLowerCase());

        // 下载封面(优先下载封面是为了防止自动下载重复图片)
        String coverUrl = downloadCover(book, config.getDownloadPath());
        if (!coverUrl.isEmpty()) {
            webSocketMessageSender.send(sessionId, NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]已下载封面：%s -> %s", book.getPicUrl(), coverUrl)));
            book.setPicUrl(coverUrl);
        }

        // 保存小说信息
        if (novelService.saveBook(book) == 0L) {
            webSocketMessageSender.send(sessionId, NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]无法保存小说:%s",book.getBookName())));
            return null;
        }

        if (CommonConst.SAVE_TYPE_DB.equalsIgnoreCase(config.getExtName()) == false) {
            // 临时下载目录名
            if (CommonConst.SAVE_TYPE_HTML.equalsIgnoreCase(config.getExtName())) {
                // HTML 格式：书的ID
                bookDir = String.format("%s%s%d", CommonConst.BOOK_DIR_PREFIX, File.separator, book.getId());
            } else {
                // 其他格式：书名(作者)_EXT
                bookDir = FileUtils.sanitizeFileName(String.format("%s/%s(%s)_%s", CommonConst.BOOK_DIR_PREFIX, book.getBookName(), book.getAuthorName(), config.getExtName().toUpperCase()))
                    .replace("/", File.separator);
            }
            // 必须 new File()，否则无法使用 . 和 ..
            saveDir = FileUtil.mkdir(new File(config.getDownloadPath() + File.separator + bookDir));
            if (!saveDir.exists()) {
                webSocketMessageSender.send(sessionId, NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, JSONUtil.toJsonStr(String.format("[i]创建下载目录失败:%s,请检查是否有创建文件的权限",saveDir.getPath())));
                return null;
            }

            if (CommonConst.SAVE_TYPE_HTML.equalsIgnoreCase(config.getExtName())) {
                // 导出HTML模板相关资源
                exportResourceFile("/templates/css/style.css", new File(config.getDownloadPath() + File.separator + "css" + File.separator + "style.css"));
                exportResourceFile("/templates/js/chapter.js", new File(config.getDownloadPath() + File.separator + "js" + File.separator + "chapter.js"));
            }
        } else {
            bookDir = "";
        }

        int autoThreads = config.getThreads() == -1 ? RuntimeUtil.getProcessorCount() * 2 : config.getThreads();
        // 创建线程池
        ExecutorService executor = Executors.newFixedThreadPool(autoThreads);
        // 阻塞主线程，用于计时
        CountDownLatch latch = new CountDownLatch(toc.size());

        webSocketMessageSender.send(
            sessionId,
            NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER,
            JSONUtil.toJsonStr(String.format("[i]开始下载《%s》（%s） 共计 %s 章 | 线程数：%s",book.getBookName(), book.getAuthorName(), toc.size(), autoThreads))
        );

        if (config.getShowDownloadLog() == 0) {
            webSocketMessageSender.send(sessionId,NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER, "[i]下载日志已关闭，请耐心等待...");
        }

        StopWatch stopWatch = new StopWatch();
        stopWatch.start();
        ChapterParser chapterParser = new ChapterParser(config);

        // 爬取&下载章节
        int cacheLimit = config.getThreads() * 10;
        List<Chapter> cachedChapters = new ArrayList<Chapter>();
        toc.forEach(item -> executor.execute(() -> {
            try {
                WebSocketContext.setSender(webSocketMessageSender);
                WebSocketContext.set(sessionId);
                Chapter chapter = chapterParser.parse(item, latch);
                chapter.setBookId(book.getId());
                cachedChapters.add(chapter);
                if (canSaveChapter && cachedChapters.size() % cacheLimit == 0) {
                    canSaveChapter = false;
                    // 保存章节信息
                    if (novelService.saveChapters(cachedChapters, cacheLimit) > 0) {
                        for (int i = cacheLimit - 1; i >= 0; i--) {
                            cachedChapters.remove(i);
                        }
                        book.setWordCount(novelService.sumBookWordCount(book.getId()));
                        // 中途保存小说字数
                        novelService.saveBook(book);
                    }
                    canSaveChapter = true;
                }
                // 生成章节文件
                if (CommonConst.SAVE_TYPE_DB.equalsIgnoreCase(config.getExtName()) == false) {
                    createChapterFile(chapter);
                }
                if (config.getShowDownloadLog() == 1) {
                    webSocketMessageSender.send(
                        sessionId,
                        NOVEL_DOWNLOAD_CONSOLE_MESSAGE_LISTENER,
                        JSONUtil.toJsonStr(String.format("[i][%d/%d]已下载: %s, %s", toc.size() - latch.getCount(), toc.size(), item.getTitle(), item.getUrl()))
                    );
                }
            } finally {
                WebSocketContext.clearSessionId();
                WebSocketContext.clearSerder();
            }
        }));

        // 阻塞主线程，等待全部章节下载完毕
        latch.await();

        // 保存剩余章节
        if (cachedChapters.size() > 0) {
            if (novelService.saveChapters(cachedChapters, 0) > 0) {
                book.setWordCount(novelService.sumBookWordCount(book.getId()));
                // 保存小说信息
                novelService.saveBook(book);
            }
            cachedChapters.clear();
        }

        // 保存到文件时的处理
        if (CommonConst.SAVE_TYPE_DB.equalsIgnoreCase(config.getExtName()) == false) {
            new CrawlerPostHandler(config, novelService).handle(saveDir);
        }

        stopWatch.stop();
        executor.shutdown();
        BookContext.clear();

        return book;
    }

    /**
     * 保存章节
     */
    private void createChapterFile(Chapter chapter) {
        if (chapter == null) return;

        try (OutputStream fos = new BufferedOutputStream(new FileOutputStream(generateChapterPath(chapter)))) {
            fos.write(chapter.getContent().getBytes(StandardCharsets.UTF_8));
        } catch (Exception e) {
            Console.error(e);
        }
    }

    private String generateChapterPath(Chapter chapter) {
        String parentPath = config.getDownloadPath() + File.separator + bookDir + File.separator;
        // 文件名下划线前的数字前补零
        String order = digitCount >= String.valueOf(chapter.getOrder()).length()
                ? StrUtil.padPre(chapter.getOrder() + "", digitCount, '0') // 全本下载
                : String.valueOf(chapter.getOrder()); // 非全本下载

        return parentPath + order + switch (config.getExtName()) {
            // 下划线用于兼容，不要删除，见 com/pcdd/sonovel/handle/HtmlTocHandler.java:28
            case CommonConst.SAVE_TYPE_HTML -> "_.html";
            case CommonConst.SAVE_TYPE_TEXT -> "_" + FileUtils.sanitizeFileName(chapter.getTitle()) + ".txt";
            // 转换前的格式为 html
            case CommonConst.SAVE_TYPE_EPUB, CommonConst.SAVE_TYPE_PDF -> "_" + FileUtils.sanitizeFileName(chapter.getTitle()) + ".html";
            default -> throw new IllegalStateException("暂不支持的下载格式: " + config.getExtName());
        };
    }

    private boolean exportResourceFile(String resourcePath, File targetPath) {
        try (InputStream input = getClass().getResourceAsStream(resourcePath)) {
            if (input == null) {
                Console.error("[E]资源文件不存在: {}", resourcePath);
                return false;
            }
            if (!targetPath.getParentFile().exists()) {
                targetPath.getParentFile().mkdirs();
            }
            FileOutputStream output = new FileOutputStream(targetPath);
            output.write(input.readAllBytes());
            output.close();
            Console.error("[D]已导出资源文件: {}", targetPath);
            return true;
        } catch (IOException e) {
            Console.error("[E]导出资源文件失败: {}", e.getMessage());
            return false;
        }
    }

    /**
     * 下载封面失败会导致生成中断，必须捕获异常
     */
    private String downloadCover(Book book, String baseDir) {
        try {
            Console.log("[i]正在下载封面：{}", book.getPicUrl());
            String lastPath = FormatUtils.formatDate(null, "yyyyMMdd");
            File imgDir = new File(String.format("%s/%s/%s", baseDir, config.getCoverPath(), lastPath).replace("/", File.separator));
            if (!imgDir.exists()) imgDir.mkdirs();
            File coverFile = HttpUtil.downloadFileFromUrl(book.getPicUrl(), imgDir.getAbsolutePath());
            File newCoverFile = FileUtil.rename(coverFile, StrUtil.format("cover_{}.{}", DigestUtils.md5DigestAsHex((book.getBookName() + book.getAuthorName()).getBytes()), FileUtil.getType(coverFile)), true);
            Console.log("[i]已下载封面：{}", newCoverFile.getAbsolutePath());
            return String.format("%s/%s/%s", config.getCoverUrlPrefix(), lastPath, newCoverFile.getName());
        } catch (Exception e) {
            Console.error(render("[E]封面下载失败：{}", "red"), e.getMessage());
            return "";
        }
    }
}
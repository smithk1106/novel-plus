package com.ideaflow.noveldownload.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;

public interface BookService {
    Long saveBook(Book book);
    boolean deleteBookById(Long id);
    Book getBookById(Long id);
    List<Book> getBookByName(String bookName, String authorName);
    Page<Book> getBookList(AppConfig config, String keyword, Integer pageNo, Integer pageSize);

    boolean isChapterExists(Chapter chapter);
    int saveChapters(List<Chapter> chapters, int count);
    Long saveChapter(Chapter chapter);
    Chapter getChapterById(Long id);
    Chapter getChapterByBookIdAndTitle(Long bookId, String title);
    List<Chapter> getChapters(Long bookId, int start, int count);

    int sumBookWordCount(Long bookId);

    // Test
    boolean AdjustChapterContents(Long bookId);
}

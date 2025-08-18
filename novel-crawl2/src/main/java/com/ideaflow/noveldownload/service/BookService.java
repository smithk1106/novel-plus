package com.ideaflow.noveldownload.service;

import java.awt.Adjustable;
import java.util.List;

import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;

public interface BookService {
    Long saveBook(Book book);
    Book getBookById(Long id);
    Book getBookByName(String bookName);

    int saveChapters(List<Chapter> chapters, int count);
    Long saveChapter(Chapter chapter);
    Chapter getChapterById(Long id);
    Chapter getChapterByBookIdAndTitle(Long bookId, String title);
    List<Chapter> getChapters(Long bookId, int start, int count);

    int sumWordCount(Long bookId);

    // Test
    boolean AdjustChapterContents(Long bookId);
}

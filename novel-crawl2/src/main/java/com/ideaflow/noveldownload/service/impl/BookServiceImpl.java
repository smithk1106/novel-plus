package com.ideaflow.noveldownload.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ideaflow.noveldownload.config.DynamicTableHelper;
import com.ideaflow.noveldownload.constans.CommonConst;
import com.ideaflow.noveldownload.entity.BookCategoryEntity;
import com.ideaflow.noveldownload.entity.BookContentEntity;
import com.ideaflow.noveldownload.entity.BookEntity;
import com.ideaflow.noveldownload.entity.BookIndexEntity;
import com.ideaflow.noveldownload.mapper.BookCategoryMapper;
import com.ideaflow.noveldownload.mapper.BookContentMapper;
import com.ideaflow.noveldownload.mapper.BookIndexMapper;
import com.ideaflow.noveldownload.mapper.BookMapper;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;
import com.ideaflow.noveldownload.service.BookService;

import cn.hutool.core.util.StrUtil;
import jakarta.annotation.Resource;

@Service
public class BookServiceImpl implements BookService {

    @Resource
    private BookMapper novelMapper;

    @Resource
    private BookIndexMapper bookIndexMapper;

    @Resource
    private BookContentMapper bookContentMapper;

    @Resource
    private BookCategoryMapper bookCategoryMapper;

    @Override
    public Long saveBook(Book book) {
        // 书名不能为空
        if (!StringUtils.hasText(book.getBookName())) {
            return 0L;
        }

        BookEntity bookEntity = null;
        // 从ID取得书的信息
        if (book.getId() != null && book.getId() > 0) {
            bookEntity = novelMapper.selectById(book.getId());
        }
        // 从书名和作者取得书的信息
        if (bookEntity == null) {
            LambdaQueryWrapper<BookEntity> queryWrapper = new LambdaQueryWrapper<>();
            if (StringUtils.hasText(book.getAuthorName())) {
                queryWrapper.eq(BookEntity::getAuthorName, book.getAuthorName());
                queryWrapper.and(wrapper -> {
                    wrapper.eq(BookEntity::getBookName, book.getBookName()).or().like(BookEntity::getBookNameAlias, "|" + book.getBookName() + "|");
                });
            } else {
                queryWrapper.eq(BookEntity::getBookName, book.getBookName()).or().like(BookEntity::getBookNameAlias, "|" + book.getBookName() + "|");
            }
            List<BookEntity> bookEntityList = novelMapper.selectList(queryWrapper);
            if (bookEntityList.size() > 0) {
                bookEntity = bookEntityList.get(0);
            }
        }
        // 追加或更新数据
        if (bookEntity == null) {
            // 追加数据
            bookEntity = mergeBookToEntity(book, null);
            if (novelMapper.insert(bookEntity) > 0){
                book.setId(bookEntity.getId());
            } else {
                book.setId(0L);
            }
        } else {
            // 更新最后章节
            LambdaQueryWrapper<BookIndexEntity> chapterQueryWrapper = new LambdaQueryWrapper<>();
            chapterQueryWrapper.eq(BookIndexEntity::getBookId, book.getId());
            chapterQueryWrapper.orderByDesc(BookIndexEntity::getIndexNum);
            chapterQueryWrapper.last("limit 1");
            BookIndexEntity bookIndexEntity = bookIndexMapper.selectOne(chapterQueryWrapper);
            if (bookIndexEntity != null) {
                book.setLastChapterName(bookIndexEntity.getIndexName());
                book.setLastChapterId(bookIndexEntity.getId());
            }
            // 合并并更新数据
            bookEntity = mergeBookToEntity(book, bookEntity);
            book.setId(bookEntity.getId());
            book.setPicUrl(bookEntity.getPicUrl());
            novelMapper.updateById(bookEntity);
        }

        return book.getId();
    }

    @Override
    public boolean deleteBookById(Long id) {
        LambdaQueryWrapper<BookIndexEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookIndexEntity::getBookId, id);
        List<BookIndexEntity> bookIndexList = bookIndexMapper.selectList(queryWrapper);
        LambdaQueryWrapper<BookContentEntity> queryWrapperContent = new LambdaQueryWrapper<>();
        for (BookIndexEntity bookIndexEntity: bookIndexList) {
            DynamicTableHelper.setRequestData(Map.of("index_id", bookIndexEntity.getId()));
            queryWrapperContent.clear();
            queryWrapperContent.eq(BookContentEntity::getIndexId, bookIndexEntity.getId());
            bookContentMapper.delete(queryWrapperContent);
            DynamicTableHelper.removeRequestData();
        }
        if (bookIndexMapper.delete(queryWrapper) > 0) {
            // 删除小说信息
            if (novelMapper.deleteById(id) == 0) {
                return false;
            }
        } else {
            return false;
        }
        return true;
    }

    @Override
    public Book getBookById(Long id) {
        if (id < 1) return null;
        BookEntity bookEntity = novelMapper.selectById(id);
        if (bookEntity == null) {
            return null;
        }
        return getBookFromEntity(bookEntity);
    }

    @Override
    public List<Book> getBookByName(String bookName, String authorName) {
        LambdaQueryWrapper<BookEntity> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(authorName)) {
            queryWrapper.eq(BookEntity::getAuthorName, authorName);
            queryWrapper.and(wrapper -> {
                wrapper.eq(BookEntity::getBookName, bookName).or().like(BookEntity::getBookNameAlias, "|" + bookName + "|");
            });
        } else {
            queryWrapper.eq(BookEntity::getBookName, bookName).or().like(BookEntity::getBookNameAlias, "|" + bookName + "|");
        }
        List<BookEntity> bookEntityList = novelMapper.selectList(queryWrapper);
        List<Book> bookList = new ArrayList<Book>();
        for (BookEntity bookEntity : bookEntityList) {
            bookList.add(getBookFromEntity(bookEntity));
        }

        return bookList;
    }

    @Override
    public Page<Book> getBookList(AppConfig config, String keyword, Integer pageNo, Integer pageSize) {
        // 创建分页对象，传入当前页和每页显示的条数
        Page<BookEntity> page = new Page<>(pageNo, pageSize);
        
        // 创建条件构造器
        LambdaQueryWrapper<BookEntity> queryWrapper = new LambdaQueryWrapper<>();
        
        // 如果name不为空，添加name的模糊查询条件
        if (StringUtils.hasText(keyword)) {
            queryWrapper.like(BookEntity::getBookName, keyword);
        }
        queryWrapper.orderByDesc(BookEntity::getId);
        // 执行分页查询
        IPage<BookEntity> bookPageResult = novelMapper.selectPage(page, queryWrapper);
        List<Book> bookList = new ArrayList<Book>();
        bookPageResult.getRecords().forEach(bookEntity -> {
            Book book = getBookFromEntity(bookEntity);
            // 调整下载地址
            if (CommonConst.SAVE_TYPE_HTML.equalsIgnoreCase(book.getSaveType())) {
                book.setDownloadUrl(String.format("%s/%s/%s/", config.getContentBase(), CommonConst.BOOK_DIR_PREFIX, book.getId()));
            } else if (CommonConst.SAVE_TYPE_DB.equalsIgnoreCase(book.getSaveType())) {
                book.setDownloadUrl(String.format("%s%s/%s.html", config.getContentBase(), config.getBookUrlPrefix(), book.getId()));
            } else {
                book.setDownloadUrl(String.format("/%s/%s/%s(%s).%s", config.getDownloadPath(), CommonConst.BOOK_DIR_PREFIX, book.getBookName(), book.getAuthorName(), config.getExtName()));
            }

            // 调整封面地址
            if (StringUtils.hasText(book.getPicUrl()) && !book.getPicUrl().startsWith("http")) {
                book.setPicUrl(config.getContentBase() + book.getPicUrl());
            }
            bookList.add(book);
        });

        Page<Book> pageResult = new Page<Book>(bookPageResult.getCurrent(), bookPageResult.getSize());
        pageResult.setRecords(bookList);
        pageResult.setTotal(bookPageResult.getTotal());

        return pageResult;
    }

    @Override
    public Long saveChapter(Chapter chapter) {
        LambdaQueryWrapper<BookIndexEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.allEq(Map.of(
            BookIndexEntity::getBookId, chapter.getBookId(),
            BookIndexEntity::getIndexNum, chapter.getOrder()
        ));
        Boolean isOK = true;
        BookIndexEntity entity = bookIndexMapper.selectOne(queryWrapper);
        if (entity == null) {
            BookIndexEntity bookIndexEntity = mergeChapterToEntity(chapter, null);
            if (bookIndexMapper.insert(bookIndexEntity) > 0) {
                chapter.setId(bookIndexEntity.getId());
            } else {
                chapter.setId(0L);
                isOK = false;
            }
        } else {
            BookIndexEntity bookIndexEntity = mergeChapterToEntity(chapter, entity);
            chapter.setId(bookIndexEntity.getId());
            bookIndexMapper.updateById(bookIndexEntity);
        }

        // 保存章节内容
        if (isOK && StringUtils.hasText(chapter.getContent())) {
            DynamicTableHelper.setRequestData(Map.of("index_id", chapter.getId()));
            BookContentEntity bookContentEntity = new BookContentEntity();
            bookContentEntity.setIndexId(chapter.getId());
            bookContentEntity.setContent(chapter.getCleanContent());

            LambdaQueryWrapper<BookContentEntity> contentWrapper = new LambdaQueryWrapper<>();
            contentWrapper.eq(BookContentEntity::getIndexId, chapter.getId());
            List<BookContentEntity> bookContentList = bookContentMapper.selectList(contentWrapper);
            if (bookContentList.isEmpty()) {
                // 如果章节内容不存在，则插入新的内容
                isOK = (bookContentMapper.insert(bookContentEntity) > 0);
            } else {
                // 如果章节内容已存在，则更新内容
                bookContentEntity.setId(bookContentList.get(0).getId());
                isOK = (bookContentMapper.updateById(bookContentEntity) > 0);
            }
            DynamicTableHelper.removeRequestData();
            cn.hutool.core.lang.Console.log("[D]保存章节【{}: {}】的内容到'book_content{}': {}.", chapter.getOrder(), chapter.getTitle(), chapter.getId() % 10, (isOK ? "成功" : "失败"));
        }

        return chapter.getId();
    }

    @Override
    public int saveChapters(List<Chapter> chapters, int count) {
        int saveCount = 0;

        if (count < 1 || count > chapters.size()) count = chapters.size();
        chapters.sort(Comparator.comparing(Chapter::getOrder));
        for (int i = 0; i < count; i++) {
            if (saveChapter(chapters.get(i)) > 0) {
                saveCount++;
            }
        }

        return saveCount;
    }

    @Override
    public Chapter getChapterById(Long id) {
        BookIndexEntity bookIndexEntity = bookIndexMapper.selectById(id);
        if (bookIndexEntity == null) {
            return null;
        }

        // 获取章节内容
        DynamicTableHelper.setRequestData(Map.of("index_id", id));
        LambdaQueryWrapper<BookContentEntity> contentWrapper = new LambdaQueryWrapper<>();
        contentWrapper.eq(BookContentEntity::getIndexId, id);
        List<BookContentEntity> bookContentList = bookContentMapper.selectList(contentWrapper);
        DynamicTableHelper.removeRequestData();
        if (bookContentList.isEmpty()) {
            return getChapterFromEntity(bookIndexEntity, null);
        }

        return getChapterFromEntity(bookIndexEntity, bookContentList);
    }

    @Override
    public Chapter getChapterByBookIdAndTitle(Long bookId, String title) {
        LambdaQueryWrapper<BookIndexEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.allEq(Map.of(
            BookIndexEntity::getBookId, bookId,
            BookIndexEntity::getIndexName, title
        ));
        BookIndexEntity bookIndexEntity = bookIndexMapper.selectOne(queryWrapper);
        if (bookIndexEntity == null) {
            return null;
        }

        // 获取章节内容
        DynamicTableHelper.setRequestData(Map.of("index_id", bookIndexEntity.getId()));
        LambdaQueryWrapper<BookContentEntity> contentWrapper = new LambdaQueryWrapper<>();
        contentWrapper.eq(BookContentEntity::getIndexId, bookIndexEntity.getId());
        List<BookContentEntity> bookContentList = bookContentMapper.selectList(contentWrapper);
        DynamicTableHelper.removeRequestData();
        if (bookContentList.isEmpty()) {
            return getChapterFromEntity(bookIndexEntity, null);
        }

        return getChapterFromEntity(bookIndexEntity, bookContentList);
    }

    @Override
    public List<Chapter> getChapters(Long bookId, int start, int count) {
        List<Chapter> list = new ArrayList<Chapter>();

        // 创建条件构造器
        LambdaQueryWrapper<BookIndexEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookIndexEntity::getBookId, bookId);
        queryWrapper.orderByAsc(BookIndexEntity::getIndexNum);
        // 获取章节列表
        List<BookIndexEntity> bookIndexList = bookIndexMapper.selectList(queryWrapper);
        if (bookIndexList.isEmpty()) {
            return list;
        }

        // 获取章节内容
        LambdaQueryWrapper<BookContentEntity> contentWrapper = new LambdaQueryWrapper<>();
        for(BookIndexEntity bookIndexEntity : bookIndexList) {
            DynamicTableHelper.setRequestData(Map.of("index_id", bookIndexEntity.getId()));
            contentWrapper.clear();
            contentWrapper.eq(BookContentEntity::getIndexId, bookIndexEntity.getId());
            List<BookContentEntity> bookContentList = bookContentMapper.selectList(contentWrapper);
            if (bookContentList.isEmpty()) {
                list.add(getChapterFromEntity(bookIndexEntity, null));
            } else {
                list.add(getChapterFromEntity(bookIndexEntity, bookContentList));
            }
            DynamicTableHelper.removeRequestData();
        }

        return list;
    }

    @Override
    public int sumBookWordCount(Long bookId) {
        // 创建条件构造器
        QueryWrapper<BookIndexEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("sum(word_count) as book_word_count"); 
        queryWrapper.eq("book_id", bookId);

        // 获取章节列表
        List<Map<String, Object>> mapList = bookIndexMapper.selectMaps(queryWrapper);
        if (mapList.isEmpty()) {
            return 0;
        }

        return ((BigDecimal)mapList.get(0).get("book_word_count")).intValue();
    }

    // Test
    @Override
    public boolean AdjustChapterContents(Long bookId) {
        // 获取章节列表
        LambdaQueryWrapper<BookIndexEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookIndexEntity::getBookId, bookId);
        queryWrapper.orderByAsc(BookIndexEntity::getIndexNum);
        List<BookIndexEntity> bookIndexList = bookIndexMapper.selectList(queryWrapper);
        if (bookIndexList.isEmpty()) {
            return false;
        }

        // 获取章节内容
        List<BookContentEntity> allContentList = new ArrayList<BookContentEntity>();
        LambdaQueryWrapper<BookContentEntity> contentWrapper = new LambdaQueryWrapper<>();
        for(BookIndexEntity bookIndexEntity : bookIndexList) {
            DynamicTableHelper.removeRequestData();
            contentWrapper.clear();
            contentWrapper.eq(BookContentEntity::getIndexId, bookIndexEntity.getId());
            List<BookContentEntity> bookContentList = bookContentMapper.selectList(contentWrapper);
            if (!bookContentList.isEmpty()) {
                String content = "";
                for (BookContentEntity bookContent : bookContentList) {
                    content += bookContent.getContent() + "\n"; // 合并所有内容
                }
                BookContentEntity bookContentEntity = bookContentList.get(0);
                bookContentEntity.setContent(content.trim());
                bookContentEntity.setId(null);
                allContentList.add(bookContentEntity);
            }
        }

        // 重新保存章节内容
        for(BookContentEntity bookContent : allContentList) {
            DynamicTableHelper.setRequestData(Map.of("index_id", bookContent.getIndexId()));
            boolean isOK = (bookContentMapper.insert(bookContent) > 0);
            DynamicTableHelper.removeRequestData();
            cn.hutool.core.lang.Console.log("[D]保存章节【{}】的内容到'book_content{}': {}.", bookContent.getIndexId(), bookContent.getIndexId() % 10, (isOK ? "成功" : "失败"));
        }

        return true;
    }


    private Book getBookFromEntity(BookEntity bookEntity) {
        Book book = new Book();

        book.setId(bookEntity.getId());
        book.setBookName(bookEntity.getBookName());
        book.setBookNameAlias(bookEntity.getBookNameAlias());
        book.setPicUrl(bookEntity.getPicUrl());
        book.setAuthorName(bookEntity.getAuthorName());
        book.setBookDesc(bookEntity.getBookDesc());
        book.setCatId(bookEntity.getCatId());
        book.setCatName(bookEntity.getCatName());
        book.setLastChapterName(bookEntity.getLastIndexName());
        book.setLastUpdateTime(bookEntity.getLastIndexUpdateTime());
        book.setBookStatus(bookEntity.getBookStatus());
        book.setWordCount(bookEntity.getWordCount());
        book.setCrawlSourceId(bookEntity.getCrawlSourceId());
        book.setUrl(bookEntity.getCrawlBookUrl());

        book.setSaveType(bookEntity.getSaveType());
        book.setDownloadUrl(bookEntity.getDownloadUrl());

        return book;
    }

    private BookEntity mergeBookToEntity(Book book, BookEntity bookEntity) {
        if (bookEntity == null) {
            bookEntity = new BookEntity();
            bookEntity.setCreateTime(Calendar.getInstance().getTime());
            bookEntity.setLastIndexName(book.getLastChapterName());
            bookEntity.setLastIndexId(book.getLastChapterId());
        }
        if (StrUtil.isNotBlank(book.getBookName())) {
            bookEntity.setBookName(book.getBookName());
        }
        if (StrUtil.isNotBlank(book.getBookNameAlias())) {
            bookEntity.setBookNameAlias(book.getBookNameAlias());
        }
        if (StrUtil.isNotBlank(book.getPicUrl()) && book.getPicUrl().startsWith("http") == false) {
            bookEntity.setPicUrl(book.getPicUrl());
        }
        if (StrUtil.isNotBlank(book.getAuthorName())) {
            bookEntity.setAuthorName(book.getAuthorName());
        }
        if (StrUtil.isNotBlank(book.getBookDesc())) {
            bookEntity.setBookDesc(book.getBookDesc());
        }
        if (StrUtil.isNotBlank(book.getLastChapterName())) {
            bookEntity.setLastIndexName(book.getLastChapterName());
        }
        if (book.getLastChapterId() > 0) {
            bookEntity.setLastIndexId(book.getLastChapterId());
        }
        if (book.getLastUpdateTime() == null) {
            bookEntity.setLastIndexUpdateTime(Calendar.getInstance().getTime());
        } else {
            bookEntity.setLastIndexUpdateTime(book.getLastUpdateTime());
        }
        bookEntity.setBookStatus(book.getBookStatus());
        bookEntity.setWordCount(book.getWordCount());
        bookEntity.setUpdateTime(Calendar.getInstance().getTime());
        if (bookEntity.getCatId() == null || bookEntity.getCatId() != book.getCatId()) {
            // 取得分类名
            BookCategoryEntity bookCategoryEntity = bookCategoryMapper.selectById(book.getCatId());
            if (bookCategoryEntity != null) {
                bookEntity.setCatName(bookCategoryEntity.getName());
                bookEntity.setWorkDirection(bookCategoryEntity.getWorkDirection());
                book.setCatName(bookEntity.getCatName());
            } else {
                bookEntity.setCatName(book.getCatName());
                bookEntity.setWorkDirection((byte)0);
            }
            bookEntity.setCatId(book.getCatId());
        }
        bookEntity.setCrawlSourceId(book.getCrawlSourceId());
        bookEntity.setCrawlBookUrl(book.getUrl());

        // 额外字段
        bookEntity.setSaveType(book.getSaveType());
        bookEntity.setDownloadUrl(book.getDownloadUrl());

        return bookEntity;
    }

    private BookIndexEntity mergeChapterToEntity(Chapter chapter, BookIndexEntity bookIndexEntity) {
        if (bookIndexEntity == null) {
            bookIndexEntity = new BookIndexEntity();
            //bookIndexEntity.setId(chapter.getId());
            bookIndexEntity.setCreateTime(Calendar.getInstance().getTime());
            bookIndexEntity.setBookPrice(0);
            bookIndexEntity.setStorageType("db");
            bookIndexEntity.setIsVip((byte)0);
        }
        bookIndexEntity.setBookId(chapter.getBookId());
        bookIndexEntity.setIndexName(chapter.getTitle());
        bookIndexEntity.setIndexNum(chapter.getOrder());
        bookIndexEntity.setWordCount(chapter.getCleanContent().length());
        bookIndexEntity.setUpdateTime(Calendar.getInstance().getTime());

        return bookIndexEntity;
    }

    private Chapter getChapterFromEntity(BookIndexEntity bookIndexEntity, List<BookContentEntity> bookContentList) {
        Chapter chapter = Chapter.builder()
            .id(bookIndexEntity.getId())
            .bookId(bookIndexEntity.getBookId())
            .title(bookIndexEntity.getIndexName())
            .order(bookIndexEntity.getIndexNum())
            .wordCount(bookIndexEntity.getWordCount())
            .build();
        
        // 如果有内容，则设置内容
        String content = "";
        for (BookContentEntity bookContentEntity : bookContentList) {
            content += bookContentEntity.getContent() + "\n"; // 合并所有内容
        }
        if (content.isBlank()) {
            // 如果没有内容，则设置为空字符串
            chapter.setContent("");
            chapter.setCleanContent("");
        } else {
            chapter.setContent(content);
            chapter.setCleanContent(content);
        }
    
        return chapter;
    }
}

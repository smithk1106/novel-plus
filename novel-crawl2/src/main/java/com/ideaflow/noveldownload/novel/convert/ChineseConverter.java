package com.ideaflow.noveldownload.novel.convert;

import com.hankcs.hanlp.HanLP;

import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.novel.model.Chapter;
import com.ideaflow.noveldownload.novel.model.SearchResult;
import com.ideaflow.noveldownload.novel.util.LangType;
import lombok.experimental.UtilityClass;

import java.util.function.Function;


@UtilityClass
public class ChineseConverter {

    public <T> T convert(T obj, String sourceLang, String targetLang) {
        if (obj == null || targetLang.equals(sourceLang)) {
            return obj;
        }

        Function<String, String> convertFunc = getConversionFunction(sourceLang, targetLang);
        if (convertFunc == null) {
            return obj;
        }

        return applyConversion(obj, convertFunc);
    }

    private Function<String, String> getConversionFunction(String sourceLang, String targetLang) {
        return switch (sourceLang + ">" + targetLang) {
            case LangType.ZH_HANT + ">" + LangType.ZH_CN -> HanLP::t2s;
            case LangType.ZH_CN + ">" + LangType.ZH_HANT -> HanLP::s2t;
            case LangType.ZH_CN + ">" + LangType.ZH_TW -> HanLP::s2tw;
            case LangType.ZH_HANT + ">" + LangType.ZH_TW -> HanLP::t2tw;
            default -> null;
        };
    }

    private <T> T applyConversion(T obj, Function<String, String> convertFunc) {
        if (obj instanceof Book book) {
            book.setBookName(convertIfNotNull(book.getBookName(), convertFunc));
            book.setAuthorName(convertIfNotNull(book.getAuthorName(), convertFunc));
            book.setBookDesc(convertIfNotNull(book.getBookDesc(), convertFunc));
            book.setCatName(convertIfNotNull(book.getCatName(), convertFunc));
            book.setLastChapterName(convertIfNotNull(book.getLastChapterName(), convertFunc));
            //book.setLastUpdateTime(book.getLastUpdateTime());
            //book.setBookStatus(convertIfNotNull(book.getBookStatus(), convertFunc));
            return (T) book;
        }

        if (obj instanceof Chapter chapter) {
            chapter.setTitle(convertIfNotNull(chapter.getTitle(), convertFunc));
            chapter.setContent(convertIfNotNull(chapter.getContent(), convertFunc));
            return (T) chapter;
        }

        if (obj instanceof SearchResult sr) {
            sr.setBookName(convertIfNotNull(sr.getBookName(), convertFunc));
            sr.setAuthor(convertIfNotNull(sr.getAuthor(), convertFunc));
            sr.setIntro(convertIfNotNull(sr.getIntro(), convertFunc));
            sr.setCategory(convertIfNotNull(sr.getCategory(), convertFunc));
            sr.setLatestChapter(convertIfNotNull(sr.getLatestChapter(), convertFunc));
            sr.setLastUpdateTime(convertIfNotNull(sr.getLastUpdateTime(), convertFunc));
            sr.setWordCount(convertIfNotNull(sr.getWordCount(), convertFunc));
            sr.setStatus(convertIfNotNull(sr.getStatus(), convertFunc));
            return (T) sr;
        }

        return obj;
    }

    private String convertIfNotNull(String value, Function<String, String> convertFunc) {
        return value != null ? convertFunc.apply(value) : null;
    }

}
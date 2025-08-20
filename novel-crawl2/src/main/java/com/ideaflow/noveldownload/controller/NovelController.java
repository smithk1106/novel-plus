package com.ideaflow.noveldownload.controller;

import java.io.File;
import java.util.List;

import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.novel.model.Book;
import com.ideaflow.noveldownload.pojo.CommonResult;
import com.ideaflow.noveldownload.pojo.NovelWebSearch;
import com.ideaflow.noveldownload.service.AppConfigService;
import com.ideaflow.noveldownload.service.BookService;

import jakarta.annotation.Resource;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/novel")
public class NovelController {

    @Resource
    private BookService bookService;

    @Resource
    private AppConfigService appConfigService;

    private AppConfig config;

    @PostMapping("/list")
    public CommonResult<List<Book>> list(@Valid @RequestBody NovelWebSearch novelWebSearch) {
        if (config == null) {
            config = appConfigService.load();
        }

        List<Book> pageResult = bookService.getBookList(config, novelWebSearch.getName(), novelWebSearch.getPageNo(), novelWebSearch.getPageSize());

        return CommonResult.success(pageResult);
    }

    @PostMapping("/delete/{id}")
    public CommonResult<String> delete(@PathVariable String id) {
        Long book_id = Long.getLong(id, 0);
        Book book = bookService.getBookById(book_id);
        if (book == null || !StringUtils.hasText(book.getDownloadUrl())) {
            return CommonResult.error("小说不存在");
        }
        // 设置文件路径
        String filePath =  System.getProperty("user.dir") + File.separator + book.getDownloadUrl();
        File file = new File(filePath);

        // 如果文件存在则删除
        if (file.exists()) {
            if (!file.delete()) {
                return CommonResult.error("删除文件失败");
            }
        }
        
        // 删除
        if (!bookService.deleteBookById(book_id)) {
            return CommonResult.error("删除小说信息失败");
        }
        
        return CommonResult.success("删除成功");
    }

}

package com.ideaflow.noveldownload.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ideaflow.noveldownload.config.AppProperties;
import com.ideaflow.noveldownload.constans.CommonConst;
import com.ideaflow.noveldownload.entity.BookEntity;
import com.ideaflow.noveldownload.mapper.BookIndexMapper;
import com.ideaflow.noveldownload.mapper.BookMapper;
import com.ideaflow.noveldownload.pojo.CommonResult;
import com.ideaflow.noveldownload.pojo.NovelWebSearch;

import jakarta.annotation.Resource;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/novel")
public class NovelController {

    @Resource
    private BookMapper novelMapper;

    @jakarta.annotation.Resource
    private BookIndexMapper bookIndexMapper;

    @Autowired
    private AppProperties appProperties;

    @PostMapping("/list")
    public CommonResult<IPage<BookEntity>> list(@Valid @RequestBody NovelWebSearch novelWebSearch) {
        // 创建分页对象，传入当前页和每页显示的条数
        Page<BookEntity> page = new Page<>(novelWebSearch.getPageNo(), novelWebSearch.getPageSize());
        
        // 创建条件构造器
        LambdaQueryWrapper<BookEntity> queryWrapper = new LambdaQueryWrapper<>();
        
        // 如果name不为空，添加name的模糊查询条件
        if (StringUtils.hasText(novelWebSearch.getName())) {
            queryWrapper.like(BookEntity::getBookName, novelWebSearch.getName());
        }
        queryWrapper.orderByDesc(BookEntity::getId);
        // 执行分页查询
        IPage<BookEntity> pageResult = novelMapper.selectPage(page, queryWrapper);
        pageResult.getRecords().forEach(novelEntity -> {
            // 调整下载地址
            if (CommonConst.SAVE_TYPE_HTML.equalsIgnoreCase(novelEntity.getSaveType()) && StringUtils.hasText(novelEntity.getDownloadUrl())) {
                if (!novelEntity.getDownloadUrl().startsWith("http")) {
                    novelEntity.setDownloadUrl(appProperties.getContentBase() + "book/" + novelEntity.getId());
                }
            }
            // 调整封面地址
            if (StringUtils.hasText(novelEntity.getPicUrl()) && !novelEntity.getPicUrl().startsWith("http")) {
                novelEntity.setPicUrl(appProperties.getContentBase() + novelEntity.getPicUrl());
            }
        });
        
        return CommonResult.success(pageResult);
    }

    @PostMapping("/delete/{id}")
    public CommonResult<String> delete(@PathVariable String id) {
        BookEntity novelEntity = novelMapper.selectById(id);
        if (Objects.isNull(novelEntity)|| !StringUtils.hasText(novelEntity.getDownloadUrl())) {
            return CommonResult.error("小说不存在");
        }
        // 设置文件路径
        String filePath =  System.getProperty("user.dir") + File.separator+novelEntity.getDownloadUrl();
        File file = new File(filePath);

        // 如果文件存在则删除
        if (file.exists()) {
            if (!file.delete()) {
                return CommonResult.error("删除文件失败");
            }
        }
        
        // 删除章节信息
        if (bookIndexMapper.deleteByMap(Map.of("book_id", id)) > 0) {
            // 删除小说信息
            if (novelMapper.deleteById(id) == 0) {
                return CommonResult.error("删除小说信息失败");
            }
        } else {
            return CommonResult.error("删除章节信息失败");
        }
        
        return CommonResult.success("删除成功");
    }

}

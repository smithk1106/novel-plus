package com.ideaflow.noveldownload.service.impl;

import com.ideaflow.noveldownload.novel.model.AppConfig;
import com.ideaflow.noveldownload.service.AppConfigService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ideaflow.noveldownload.mapper.AppConfigMapper;
import com.ideaflow.noveldownload.entity.AppConfigEntity;
import com.ideaflow.noveldownload.config.AppProperties;

import cn.hutool.json.JSONUtil;
import jakarta.annotation.Resource;

@Service
public class AppConfigServiceImpl implements AppConfigService {

    @Resource
    private AppConfigMapper appConfigMapper;

    @Autowired
    private AppProperties appProperties;

    /**
     * 载入配置
     */
    @Override
    public AppConfig load() {
        AppConfigEntity appConfigEntity = appConfigMapper.selectById(1);
        AppConfig config = JSONUtil.toBean(appConfigEntity.getConfigValue(), AppConfig.class);
        config.setContentBase(appProperties.getContentBase());
        config.setCoverPath(appProperties.getCoverPath());
        config.setCoverUrlPrefix(appProperties.getCoverUrlPrefix());
        config.setBookUrlPrefix(appProperties.getBookUrlPrefix());
        return config;
    }
    
}

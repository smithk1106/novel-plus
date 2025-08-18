package com.ideaflow.noveldownload.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.DynamicTableNameInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan({"com.ideaflow.noveldownload.mapper"})
public class MybatisPlusConfig {

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        // 添加分页插件
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));

        // 动态表名
        DynamicTableNameInnerInterceptor dynamicTableNameInnerInterceptor = new DynamicTableNameInnerInterceptor();
        dynamicTableNameInnerInterceptor.setTableNameHandler((sql, tableName) -> {
            String newTableName;
            if (tableName.equalsIgnoreCase("book_content")) {
                Long indexId = DynamicTableHelper.getRequestData("index_id");
                if (indexId != null) {
                    newTableName = tableName + String.valueOf(indexId % 10);
                } else {
                    newTableName = tableName;
                }
            } else {
                newTableName = tableName;
            }
            //cn.hutool.core.lang.Console.log("[D][setTableNameHandler]{} -> {}", tableName, newTableName);
            return newTableName;
        });
        interceptor.addInnerInterceptor(dynamicTableNameInnerInterceptor);

        return interceptor;
    }
} 
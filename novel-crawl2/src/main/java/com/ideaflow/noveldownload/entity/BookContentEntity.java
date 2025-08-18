package com.ideaflow.noveldownload.entity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;

@Data
@TableName("book_content")
public class BookContentEntity {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long indexId;
    private String content;
}
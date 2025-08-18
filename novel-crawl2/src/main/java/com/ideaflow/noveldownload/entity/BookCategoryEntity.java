package com.ideaflow.noveldownload.entity;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;

@Data
@TableName("book_category")
public class BookCategoryEntity {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Byte workDirection;
    private String name;
    private Byte sort;
    private Long createUserId;
    private Date createTime;
    private Long updateUserId;
    private Date updateTime;
}
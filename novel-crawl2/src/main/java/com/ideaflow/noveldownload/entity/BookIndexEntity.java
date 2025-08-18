package com.ideaflow.noveldownload.entity;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;

@Data
@TableName("book_index")
public class BookIndexEntity {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private Integer indexNum;
    private String indexName;
    private Integer wordCount;
    private Byte isVip;
    private Integer bookPrice;
    private String storageType;
    private Date createTime;
    private Date updateTime;
}
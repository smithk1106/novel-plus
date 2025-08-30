package com.ideaflow.noveldownload.entity;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ideaflow.noveldownload.constans.CommonConst;

import lombok.Data;

@Data
@TableName("book")
public class BookEntity implements Serializable{
    @TableId(type = IdType.AUTO)
    private Long id;
    private Byte workDirection = 0;
    private Integer catId;
    private String catName;
    private String picUrl;
    private String bookName;
    private String bookNameAlias = "";
    private Long authorId;
    private String authorName;
    private String bookDesc;
    private Float score = 0F;
    private Byte bookStatus;
    private Long visitCount = 0L;
    private Integer wordCount = 0;
    private Integer commentCount = 0;
    private Integer yesterdayBuy = 0;
    private Long lastIndexId = 0L;
    private String lastIndexName = "";
    private Date lastIndexUpdateTime;
    private Byte isVip;
    private Byte status;
    private Date updateTime = Calendar.getInstance().getTime();
    private Date createTime;
    private Integer crawlSourceId;
    private String crawlBookId;
    private Date crawlLastTime;
    private Byte crawlIsStop;
    @TableField(exist = false)
    private String downloadUrl = "";
    @TableField(exist = false)
    private String saveType = CommonConst.SAVE_TYPE_DB;
}
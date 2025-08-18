package com.ideaflow.noveldownload.entity;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;

@Data
@TableName("author")
public class AuthorEntity {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String inviteCode;
    private String penName;
    private String telPhone;
    private String chatAccount;
    private String email;
    private Byte workDirection;
    private Byte status;
    private Date createTime;
}
package com.java2nb.novel.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.java2nb.novel.entity.Book;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Administrator
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class BookVO extends Book implements Serializable {

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy/MM/dd")
    private Date lastIndexUpdateTime;


}

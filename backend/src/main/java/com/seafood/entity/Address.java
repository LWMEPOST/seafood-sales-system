package com.seafood.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("sys_address")
public class Address {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String name;
    private String phone;
    private String detail;
    private Integer isDefault; // 1: Default, 0: Not default
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

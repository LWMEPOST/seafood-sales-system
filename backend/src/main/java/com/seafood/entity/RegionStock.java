package com.seafood.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("pms_region_stock")
public class RegionStock {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String regionName;
    
    private Integer stockCount;
}

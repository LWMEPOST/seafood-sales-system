package com.seafood.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("pms_product")
@Schema(description = "商品实体")
public class Product {

    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;

    @Schema(description = "分类ID")
    private Long categoryId;

    @Schema(description = "商品名称")
    private String name;

    @Schema(description = "价格")
    private BigDecimal price;

    @Schema(description = "原价")
    private BigDecimal originalPrice;

    @Schema(description = "库存")
    private Integer stock;

    @Schema(description = "产地")
    private String origin;

    @Schema(description = "捕捞日期")
    @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate catchDate;

    @Schema(description = "养殖方式")
    private String farmingMethod;

    @Schema(description = "描述")
    private String description;

    @Schema(description = "主图")
    private String mainImage;

    @Schema(description = "详情图")
    private String detailImages;

    @Schema(description = "状态: 1上架, 0下架")
    private Integer status;

    @Schema(description = "创建时间")
    @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime createTime;
}

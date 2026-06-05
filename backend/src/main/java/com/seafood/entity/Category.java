package com.seafood.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@TableName("pms_category")
@Schema(description = "商品分类")
public class Category {

    @TableId(type = IdType.AUTO)
    private Long id;

    @Schema(description = "分类名称")
    private String name;

    @Schema(description = "分类图标")
    private String icon;

    @Schema(description = "排序")
    private Integer sort;

    @Schema(description = "状态: 1启用, 0禁用")
    private Integer status;
}

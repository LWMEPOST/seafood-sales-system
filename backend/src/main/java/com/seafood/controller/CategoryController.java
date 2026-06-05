package com.seafood.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.seafood.common.Result;
import com.seafood.entity.Category;
import com.seafood.service.CategoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "分类管理")
@RestController
@RequestMapping("/api/category")
@CrossOrigin
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Operation(summary = "获取所有分类")
    @GetMapping("/list")
    public Result<List<Category>> list() {
        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Category::getStatus, 1)
               .orderByAsc(Category::getSort);
        return Result.success(categoryService.list(wrapper));
    }
}

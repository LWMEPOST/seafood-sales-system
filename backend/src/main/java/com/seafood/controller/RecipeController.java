package com.seafood.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.seafood.common.Result;
import com.seafood.entity.Recipe;
import com.seafood.service.RecipeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Tag(name = "食谱管理")
@RestController
@RequestMapping("/api/recipe")
@CrossOrigin
public class RecipeController {

    @Autowired
    private RecipeService recipeService;

    @Operation(summary = "分页查询食谱")
    @GetMapping("/page")
    public Result<Page<Recipe>> page(@RequestParam(defaultValue = "1") Integer page,
                                     @RequestParam(defaultValue = "10") Integer size,
                                     @RequestParam(required = false) String title) {
        Page<Recipe> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Recipe> wrapper = new LambdaQueryWrapper<>();
        if (title != null && !title.isEmpty()) {
            wrapper.like(Recipe::getTitle, title);
        }
        wrapper.orderByDesc(Recipe::getCreateTime);
        return Result.success(recipeService.page(pageParam, wrapper));
    }

    @Operation(summary = "获取食谱详情")
    @GetMapping("/{id}")
    public Result<Recipe> getById(@PathVariable Long id) {
        return Result.success(recipeService.getById(id));
    }

    @Operation(summary = "新增食谱")
    @PostMapping
    public Result<Boolean> save(@RequestBody Recipe recipe) {
        if (recipe.getCreateTime() == null) {
            recipe.setCreateTime(java.time.LocalDateTime.now());
        }
        return Result.success(recipeService.save(recipe));
    }

    @Operation(summary = "修改食谱")
    @PutMapping
    public Result<Boolean> update(@RequestBody Recipe recipe) {
        return Result.success(recipeService.updateById(recipe));
    }

    @Operation(summary = "删除食谱")
    @DeleteMapping("/{id}")
    public Result<Boolean> remove(@PathVariable Long id) {
        return Result.success(recipeService.removeById(id));
    }
    
    @Operation(summary = "根据商品ID查询食谱")
    @GetMapping("/product/{productId}")
    public Result<Recipe> getByProductId(@PathVariable Long productId) {
        return Result.success(recipeService.getOne(new LambdaQueryWrapper<Recipe>()
                .eq(Recipe::getProductId, productId)
                .orderByDesc(Recipe::getCreateTime)
                .orderByDesc(Recipe::getId)
                .last("LIMIT 1")));
    }
}

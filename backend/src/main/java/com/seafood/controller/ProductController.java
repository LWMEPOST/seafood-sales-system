package com.seafood.controller;

import cn.hutool.core.text.csv.CsvData;
import cn.hutool.core.text.csv.CsvReader;
import cn.hutool.core.text.csv.CsvRow;
import cn.hutool.core.text.csv.CsvUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.seafood.common.Result;
import com.seafood.entity.Product;
import com.seafood.service.ProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Tag(name = "商品管理")
@RestController
@RequestMapping("/api/product")
@CrossOrigin
public class ProductController {

    @Autowired
    private ProductService productService;

    @Operation(summary = "分页查询商品")
    @GetMapping("/page")
    public Result<Page<Product>> page(@RequestParam(defaultValue = "1") Integer page,
                                      @RequestParam(defaultValue = "10") Integer size,
                                      @RequestParam(required = false) Long categoryId,
                                      @RequestParam(required = false) String origin) {
        Page<Product> productPage = new Page<>(page, size);
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        if (categoryId != null) {
            wrapper.eq(Product::getCategoryId, categoryId);
        }
        if (origin != null && !origin.isEmpty()) {
            wrapper.like(Product::getOrigin, origin);
        }
        wrapper.eq(Product::getStatus, 1); // 仅显示上架商品
        return Result.success(productService.page(productPage, wrapper));
    }

    @Operation(summary = "商品详情")
    @GetMapping("/{id}")
    public Result<Product> getById(@PathVariable Long id) {
        return Result.success(productService.getById(id));
    }

    @Operation(summary = "新增商品")
    @PostMapping
    public Result<Boolean> save(@RequestBody Product product) {
        return Result.success(productService.save(product));
    }

    @Operation(summary = "修改商品")
    @PutMapping
    public Result<Boolean> update(@RequestBody Product product) {
        return Result.success(productService.updateById(product));
    }

    @Operation(summary = "删除商品")
    @DeleteMapping("/{id}")
    public Result<Boolean> remove(@PathVariable Long id) {
        return Result.success(productService.removeById(id));
    }

    @Operation(summary = "导入商品")
    @PostMapping("/import")
    public Result<Boolean> importProduct(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return Result.error("文件为空");
        }
        try {
            InputStreamReader reader = new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8);
            CsvReader csvReader = CsvUtil.getReader(reader);
            CsvData data = csvReader.read();
            List<CsvRow> rows = data.getRows();

            List<Product> productList = new ArrayList<>();
            // Skip header (row 0)
            for (int i = 1; i < rows.size(); i++) {
                CsvRow row = rows.get(i);
                // Check if row has enough columns (at least 7)
                if (row.size() < 7) continue;

                Product p = new Product();
                p.setName(row.get(0));
                try {
                    String catStr = row.get(1);
                    // Handle potential BOM or spaces, only keep digits
                    catStr = catStr.replaceAll("[^0-9]", ""); 
                    if (catStr.isEmpty()) {
                         p.setCategoryId(1L);
                    } else {
                         p.setCategoryId(Long.parseLong(catStr));
                    }
                } catch (Exception e) {
                    p.setCategoryId(1L); // Default to 1
                }

                try {
                    String priceStr = row.get(2).trim();
                    p.setPrice(new BigDecimal(priceStr));
                } catch (Exception e) {
                    p.setPrice(BigDecimal.ZERO);
                }

                try {
                    String stockStr = row.get(3).trim();
                    p.setStock(Integer.parseInt(stockStr));
                } catch (Exception e) {
                    p.setStock(0);
                }
                
                p.setOrigin(row.get(4));
                p.setFarmingMethod(row.get(5));
                p.setDescription(row.get(6));

                p.setStatus(1); // Default On Shelf
                p.setCreateTime(LocalDateTime.now());

                productList.add(p);
            }

            if (!productList.isEmpty()) {
                productService.saveBatch(productList);
            }

            return Result.success(true);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("导入失败: " + e.getMessage());
        }
    }
}

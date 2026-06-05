package com.seafood.controller;

import com.seafood.common.Result;
import com.seafood.entity.RegionStock;
import com.seafood.service.RegionStockService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "地区库存管理")
@RestController
@RequestMapping("/api/region-stock")
@CrossOrigin
public class RegionStockController {

    @Autowired
    private RegionStockService regionStockService;

    @Operation(summary = "获取地区库存列表")
    @GetMapping("/list")
    public Result<List<RegionStock>> list() {
        return Result.success(regionStockService.list());
    }
}

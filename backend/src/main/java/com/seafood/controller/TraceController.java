package com.seafood.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.seafood.common.Result;
import com.seafood.entity.TraceRecord;
import com.seafood.service.TraceRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "溯源管理")
@RestController
@RequestMapping("/api/trace")
@CrossOrigin
public class TraceController {

    @Autowired
    private TraceRecordService traceRecordService;

    @Operation(summary = "查询商品溯源记录")
    @GetMapping("/list/{productId}")
    public Result<List<TraceRecord>> list(@PathVariable Long productId) {
        LambdaQueryWrapper<TraceRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TraceRecord::getProductId, productId)
               .orderByAsc(TraceRecord::getNodeTime);
        return Result.success(traceRecordService.list(wrapper));
    }

    @Operation(summary = "新增溯源记录")
    @PostMapping
    public Result<Boolean> save(@RequestBody TraceRecord traceRecord) {
        return Result.success(traceRecordService.save(traceRecord));
    }

    @Operation(summary = "修改溯源记录")
    @PutMapping
    public Result<Boolean> update(@RequestBody TraceRecord traceRecord) {
        return Result.success(traceRecordService.updateById(traceRecord));
    }
}

package com.seafood.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.entity.Product;
import com.seafood.entity.TraceRecord;
import com.seafood.mapper.ProductMapper;
import com.seafood.service.ProductService;
import com.seafood.service.TraceRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {

    @Autowired
    private TraceRecordService traceRecordService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(Product entity) {
        // 1. Save product first
        boolean success = super.save(entity);
        
        if (success && entity.getId() != null) {
            // 2. Auto-create initial trace record (Catch)
            TraceRecord trace = new TraceRecord();
            trace.setProductId(entity.getId());
            trace.setNodeName("捕捞");
            // Use catchDate at 08:00 if available, else now
            if (entity.getCatchDate() != null) {
                trace.setNodeTime(entity.getCatchDate().atTime(LocalTime.of(8, 0)));
            } else {
                trace.setNodeTime(LocalDateTime.now());
            }
            trace.setLocation(entity.getOrigin());
            trace.setDescription("源头捕捞，新鲜直达");
            trace.setOperator("系统自动记录");
            
            traceRecordService.save(trace);
        }
        return success;
    }
}

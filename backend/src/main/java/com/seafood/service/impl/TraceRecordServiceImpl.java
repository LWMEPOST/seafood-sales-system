package com.seafood.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.entity.TraceRecord;
import com.seafood.mapper.TraceRecordMapper;
import com.seafood.service.TraceRecordService;
import org.springframework.stereotype.Service;

@Service
public class TraceRecordServiceImpl extends ServiceImpl<TraceRecordMapper, TraceRecord> implements TraceRecordService {
}

package com.seafood.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.entity.RegionStock;
import com.seafood.mapper.RegionStockMapper;
import com.seafood.service.RegionStockService;
import org.springframework.stereotype.Service;

@Service
public class RegionStockServiceImpl extends ServiceImpl<RegionStockMapper, RegionStock> implements RegionStockService {
}

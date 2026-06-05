package com.seafood.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.seafood.entity.Product;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductMapper extends BaseMapper<Product> {
}

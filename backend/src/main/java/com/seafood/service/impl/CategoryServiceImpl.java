package com.seafood.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.mapper.CategoryMapper;
import com.seafood.entity.Category;
import com.seafood.service.CategoryService;
import org.springframework.stereotype.Service;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {
}

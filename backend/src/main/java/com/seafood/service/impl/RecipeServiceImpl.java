package com.seafood.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.entity.Recipe;
import com.seafood.mapper.RecipeMapper;
import com.seafood.service.RecipeService;
import org.springframework.stereotype.Service;

@Service
public class RecipeServiceImpl extends ServiceImpl<RecipeMapper, Recipe> implements RecipeService {
}

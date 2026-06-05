package com.seafood.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.entity.User;
import com.seafood.mapper.UserMapper;
import com.seafood.service.UserService;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public User login(String username, String password) {
        return this.getOne(new LambdaQueryWrapper<User>()
                .eq(User::getUsername, username)
                .eq(User::getPassword, password)); // In real production, use BCrypt
    }
}

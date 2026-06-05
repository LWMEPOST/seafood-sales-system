package com.seafood.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.seafood.common.Result;
import com.seafood.entity.User;
import com.seafood.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Tag(name = "用户管理")
@RestController
@RequestMapping("/api/user")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @Operation(summary = "用户登录")
    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody User loginUser) {
        if (loginUser == null || loginUser.getUsername() == null || loginUser.getPassword() == null) {
            return Result.error("用户名或密码不能为空");
        }
        User user = userService.login(loginUser.getUsername(), loginUser.getPassword());
        if (user != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("token", "mock-token-" + user.getId());
            data.put("userInfo", user);
            return Result.success(data);
        }
        return Result.error("用户名或密码错误");
    }

    @Operation(summary = "用户注册")
    @PostMapping("/register")
    public Result<User> register(@RequestBody User registerUser) {
        if (registerUser == null || registerUser.getUsername() == null || registerUser.getPassword() == null) {
            return Result.error("用户名或密码不能为空");
        }
        User existing = userService.getOne(new LambdaQueryWrapper<User>()
                .eq(User::getUsername, registerUser.getUsername()));
        if (existing != null) {
            return Result.error("用户名已存在");
        }
        if (registerUser.getRole() == null) {
            registerUser.setRole("CUSTOMER");
        }
        if (registerUser.getNickname() == null) {
            registerUser.setNickname(registerUser.getUsername());
        }
        userService.save(registerUser);
        return Result.success(registerUser);
    }

    @Operation(summary = "获取用户信息")
    @GetMapping("/info")
    public Result<User> info(@RequestParam String token) {
        if (token == null || !token.startsWith("mock-token-")) {
            return Result.error("无效的令牌");
        }
        String idStr = token.replace("mock-token-", "");
        try {
            Long userId = Long.parseLong(idStr);
            return Result.success(userService.getById(userId));
        } catch (NumberFormatException e) {
            return Result.error("无效的令牌");
        }
    }

    @Operation(summary = "分页查询用户")
    @GetMapping("/page")
    public Result<Page<User>> page(@RequestParam(defaultValue = "1") Integer page,
                                   @RequestParam(defaultValue = "10") Integer size,
                                   @RequestParam(required = false) String username) {
        Page<User> userPage = new Page<>(page, size);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        if (username != null && !username.isEmpty()) {
            wrapper.like(User::getUsername, username);
        }
        return Result.success(userService.page(userPage, wrapper));
    }
}

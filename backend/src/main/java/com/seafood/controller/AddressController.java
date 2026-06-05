package com.seafood.controller;

import com.seafood.common.Result;
import com.seafood.entity.Address;
import com.seafood.service.AddressService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Tag(name = "地址管理")
@RestController
@RequestMapping("/api/address")
@CrossOrigin
public class AddressController {

    @Autowired
    private AddressService addressService;

    @Operation(summary = "获取当前用户地址")
    @GetMapping("/current")
    public Result<Address> getCurrentAddress(@RequestParam Long userId) {
        return Result.success(addressService.getByUserId(userId));
    }

    @Operation(summary = "保存/更新地址")
    @PostMapping
    public Result<Boolean> saveAddress(@RequestBody Address address) {
        if (address.getUserId() == null) {
            return Result.error("用户ID不能为空");
        }
        return Result.success(addressService.saveOrUpdateAddress(address));
    }
}

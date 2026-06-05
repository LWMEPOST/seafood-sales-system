package com.seafood.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.entity.Address;
import com.seafood.mapper.AddressMapper;
import com.seafood.service.AddressService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class AddressServiceImpl extends ServiceImpl<AddressMapper, Address> implements AddressService {

    @Override
    public Address getByUserId(Long userId) {
        // Return the most recently updated or created address, or default
        return this.getOne(new LambdaQueryWrapper<Address>()
                .eq(Address::getUserId, userId)
                .orderByDesc(Address::getUpdateTime)
                .last("LIMIT 1"));
    }

    @Override
    public boolean saveOrUpdateAddress(Address address) {
        if (address.getUserId() == null) return false;
        
        Address existing = getByUserId(address.getUserId());
        if (existing != null) {
            address.setId(existing.getId());
            address.setUpdateTime(LocalDateTime.now());
            return this.updateById(address);
        } else {
            address.setCreateTime(LocalDateTime.now());
            address.setUpdateTime(LocalDateTime.now());
            return this.save(address);
        }
    }
}

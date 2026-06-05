package com.seafood.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.seafood.entity.Address;

public interface AddressService extends IService<Address> {
    Address getByUserId(Long userId);
    boolean saveOrUpdateAddress(Address address);
}

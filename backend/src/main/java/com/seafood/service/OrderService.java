package com.seafood.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.seafood.entity.Order;
import com.seafood.entity.OrderItem;
import java.util.List;

public interface OrderService extends IService<Order> {
    Long createOrder(Long userId, List<OrderItem> items, String receiverName, String receiverPhone, String receiverAddress);
    void payOrder(Long orderId);

    void shipOrder(Long orderId);

    void receiveOrder(Long orderId);

    Order getOrderWithItems(Long id);
}

package com.seafood.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.seafood.entity.Order;
import com.seafood.entity.OrderItem;
import com.seafood.mapper.OrderMapper;
import com.seafood.mapper.OrderItemMapper;
import com.seafood.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long createOrder(Long userId, List<OrderItem> items, String receiverName, String receiverPhone, String receiverAddress) {
        BigDecimal total = BigDecimal.ZERO;
        for (OrderItem item : items) {
            total = total.add(item.getProductPrice().multiply(new BigDecimal(item.getQuantity())));
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setOrderSn(IdUtil.getSnowflakeNextIdStr());
        order.setTotalAmount(total);
        order.setStatus(0); // 待支付
        order.setCreateTime(LocalDateTime.now());
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setReceiverAddress(receiverAddress);
        this.save(order);

        for (OrderItem item : items) {
            item.setOrderId(order.getId());
            orderItemMapper.insert(item);
        }
        return order.getId();
    }

    @Override
    public void payOrder(Long orderId) {
        Order order = this.getById(orderId);
        if (order != null && order.getStatus() == 0) {
            order.setStatus(1); // 待发货
            order.setPaymentTime(LocalDateTime.now());
            this.updateById(order);
        }
    }

    @Override
    public void shipOrder(Long orderId) {
        Order order = this.getById(orderId);
        if (order != null && order.getStatus() == 1) {
            order.setStatus(2); // 已发货
            order.setDeliveryTime(LocalDateTime.now());
            this.updateById(order);
        }
    }

    @Override
    public void receiveOrder(Long orderId) {
        Order order = this.getById(orderId);
        if (order != null && order.getStatus() == 2) {
            order.setStatus(3); // 已完成
            order.setReceiveTime(LocalDateTime.now());
            this.updateById(order);
        }
    }

    @Override
    public Order getOrderWithItems(Long id) {
        Order order = this.getById(id);
        if (order != null) {
            List<OrderItem> items = orderItemMapper.selectList(
                new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, id)
            );
            order.setItems(items);
        }
        return order;
    }
}

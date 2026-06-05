package com.seafood.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.seafood.common.Result;
import com.seafood.entity.Order;
import com.seafood.entity.OrderItem;
import com.seafood.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "订单管理")
@RestController
@RequestMapping("/api/order")
@CrossOrigin
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Operation(summary = "创建订单")
    @PostMapping("/create")
    public Result<Long> create(@RequestBody CreateOrderRequest request) {
        if (request == null || request.getUserId() == null || request.getItems() == null || request.getItems().isEmpty()) {
            return Result.error("订单数据不完整");
        }
        if (request.getReceiverName() == null || request.getReceiverPhone() == null || request.getReceiverAddress() == null) {
            return Result.error("收货信息不完整");
        }
        return Result.success(orderService.createOrder(
                request.getUserId(),
                request.getItems(),
                request.getReceiverName(),
                request.getReceiverPhone(),
                request.getReceiverAddress()
        ));
    }

    @Operation(summary = "支付订单 (模拟)")
    @PostMapping("/pay/{id}")
    public Result<Boolean> pay(@PathVariable Long id) {
        orderService.payOrder(id);
        return Result.success(true);
    }

    @Operation(summary = "发货")
    @PostMapping("/ship/{id}")
    public Result<Boolean> ship(@PathVariable Long id) {
        orderService.shipOrder(id);
        return Result.success(true);
    }

    @Operation(summary = "确认收货")
    @PostMapping("/receive/{id}")
    public Result<Boolean> receive(@PathVariable Long id) {
        orderService.receiveOrder(id);
        return Result.success(true);
    }

    @Operation(summary = "获取订单详情")
    @GetMapping("/{id}")
    public Result<Order> getById(@PathVariable Long id) {
        return Result.success(orderService.getOrderWithItems(id));
    }

    @Operation(summary = "订单列表")
    @GetMapping("/list")
    public Result<List<Order>> list(@RequestParam(required = false) Long userId) {
        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<>();
        if (userId != null) {
            wrapper.eq(Order::getUserId, userId);
        }
        wrapper.orderByDesc(Order::getCreateTime);
        return Result.success(orderService.list(wrapper));
    }

    public static class CreateOrderRequest {
        private Long userId;
        private List<OrderItem> items;
        private String receiverName;
        private String receiverPhone;
        private String receiverAddress;

        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }

        public List<OrderItem> getItems() {
            return items;
        }

        public void setItems(List<OrderItem> items) {
            this.items = items;
        }

        public String getReceiverName() {
            return receiverName;
        }

        public void setReceiverName(String receiverName) {
            this.receiverName = receiverName;
        }

        public String getReceiverPhone() {
            return receiverPhone;
        }

        public void setReceiverPhone(String receiverPhone) {
            this.receiverPhone = receiverPhone;
        }

        public String getReceiverAddress() {
            return receiverAddress;
        }

        public void setReceiverAddress(String receiverAddress) {
            this.receiverAddress = receiverAddress;
        }
    }
}

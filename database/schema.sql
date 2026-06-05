-- 创建数据库
CREATE DATABASE IF NOT EXISTS seafood_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE seafood_db;

-- 1. 用户表 (sys_user)
CREATE TABLE IF NOT EXISTS `sys_user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` VARCHAR(50) NOT NULL COMMENT '用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码',
  `nickname` VARCHAR(50) DEFAULT NULL COMMENT '昵称',
  `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像',
  `role` VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER' COMMENT '角色: ADMIN/CUSTOMER',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB COMMENT='系统用户表';

-- 2. 商品分类表 (pms_category)
CREATE TABLE IF NOT EXISTS `pms_category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `icon` VARCHAR(255) DEFAULT NULL COMMENT '图标',
  `sort` INT DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='商品分类表';

-- 3. 商品表 (pms_product)
CREATE TABLE IF NOT EXISTS `pms_product` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_id` BIGINT NOT NULL COMMENT '分类ID',
  `name` VARCHAR(100) NOT NULL COMMENT '商品名称',
  `price` DECIMAL(10,2) NOT NULL COMMENT '销售价格',
  `original_price` DECIMAL(10,2) DEFAULT NULL COMMENT '原价',
  `stock` INT NOT NULL DEFAULT 0 COMMENT '库存',
  `origin` VARCHAR(100) DEFAULT NULL COMMENT '产地',
  `catch_date` DATE DEFAULT NULL COMMENT '捕捞日期',
  `farming_method` VARCHAR(50) DEFAULT NULL COMMENT '养殖方式',
  `description` TEXT DEFAULT NULL COMMENT '商品描述',
  `main_image` VARCHAR(255) DEFAULT NULL COMMENT '主图',
  `detail_images` JSON DEFAULT NULL COMMENT '详情图列表',
  `status` TINYINT DEFAULT 1 COMMENT '状态: 1上架, 0下架',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='商品表';

-- 4. 订单表 (oms_order)
CREATE TABLE IF NOT EXISTS `oms_order` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_sn` VARCHAR(64) NOT NULL COMMENT '订单编号',
  `user_id` BIGINT NOT NULL COMMENT '用户ID',
  `total_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0待支付, 1待发货, 2已发货, 3已完成, 4已关闭',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `payment_time` DATETIME DEFAULT NULL COMMENT '支付时间',
  `delivery_time` DATETIME DEFAULT NULL COMMENT '发货时间',
  `receive_time` DATETIME DEFAULT NULL COMMENT '收货时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_sn` (`order_sn`)
) ENGINE=InnoDB COMMENT='订单表';

-- 5. 订单明细表 (oms_order_item)
CREATE TABLE IF NOT EXISTS `oms_order_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` BIGINT NOT NULL COMMENT '订单ID',
  `product_id` BIGINT NOT NULL COMMENT '商品ID',
  `product_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
  `product_price` DECIMAL(10,2) NOT NULL COMMENT '商品价格',
  `quantity` INT NOT NULL COMMENT '购买数量',
  `product_image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='订单明细表';

-- 6. 溯源记录表 (trace_record)
CREATE TABLE IF NOT EXISTS `trace_record` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` BIGINT NOT NULL COMMENT '商品ID',
  `node_name` VARCHAR(50) NOT NULL COMMENT '节点名称(捕捞/加工/运输/入库)',
  `node_time` DATETIME NOT NULL COMMENT '节点时间',
  `location` VARCHAR(100) DEFAULT NULL COMMENT '地点',
  `operator` VARCHAR(50) DEFAULT NULL COMMENT '操作人',
  `description` VARCHAR(255) DEFAULT NULL COMMENT '描述信息',
  `image` VARCHAR(255) DEFAULT NULL COMMENT '现场图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='溯源记录表';

-- 7. 库存热力数据表 (wms_stock_heatmap) - 用于管理端Dashboard
CREATE TABLE IF NOT EXISTS `wms_stock_heatmap` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_id` BIGINT NOT NULL COMMENT '分类ID',
  `region_code` VARCHAR(20) NOT NULL COMMENT '区域代码',
  `region_name` VARCHAR(50) NOT NULL COMMENT '区域名称',
  `stock_level` INT NOT NULL COMMENT '库存等级(1-5)',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='库存热力数据表';

-- 初始化数据
INSERT INTO `pms_category` (`name`, `sort`) VALUES ('鱼类', 1), ('虾类', 2), ('蟹类', 3), ('贝类', 4);

INSERT INTO `sys_user` (`username`, `password`, `role`, `nickname`) VALUES ('admin', 'root', 'ADMIN', '管理员');
INSERT INTO `sys_user` (`username`, `password`, `role`, `nickname`) VALUES ('user', '123456', 'CUSTOMER', '测试用户');

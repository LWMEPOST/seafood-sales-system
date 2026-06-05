/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80044
Source Host           : localhost:3306
Source Database       : seafood_db

Target Server Type    : MYSQL
Target Server Version : 80044
File Encoding         : 65001

Date: 2026-02-16 12:22:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for oms_order
-- ----------------------------
DROP TABLE IF EXISTS `oms_order`;
CREATE TABLE `oms_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '??ID',
  `order_sn` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '????',
  `user_id` bigint NOT NULL COMMENT '??ID',
  `total_amount` decimal(10,2) NOT NULL COMMENT '?????',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '??: 0???, 1???, 2???, 3???, 4???',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '????',
  `payment_time` datetime DEFAULT NULL COMMENT '????',
  `delivery_time` datetime DEFAULT NULL COMMENT '????',
  `receive_time` datetime DEFAULT NULL COMMENT '????',
  `receiver_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `receiver_phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `receiver_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_sn` (`order_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='???';

-- ----------------------------
-- Records of oms_order
-- ----------------------------
INSERT INTO `oms_order` VALUES ('1', 'ORD17710853827530', '2', '1068.00', '1', '2026-02-15 00:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('2', 'ORD17710853827581', '2', '928.00', '3', '2026-02-14 15:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('3', 'ORD17710853827662', '2', '811.00', '3', '2026-02-14 20:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('4', 'ORD17710853827723', '2', '172.00', '3', '2026-02-14 20:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('5', 'ORD17710853827774', '2', '1615.00', '1', '2026-02-14 13:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('6', 'ORD17710853827805', '2', '447.00', '1', '2026-02-14 22:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('7', 'ORD17710853827846', '2', '938.00', '1', '2026-02-14 16:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('8', 'ORD17710853827887', '2', '1934.00', '2', '2026-02-14 13:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('9', 'ORD17710853827928', '2', '1983.00', '3', '2026-02-14 14:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('10', 'ORD17710853827969', '2', '1594.00', '2', '2026-02-14 15:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('11', 'ORD177108538280010', '2', '1619.00', '2', '2026-02-08 19:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('12', 'ORD177108538280411', '2', '1259.00', '1', '2026-02-09 22:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('13', 'ORD177108538281012', '2', '1694.00', '2', '2026-02-13 14:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('14', 'ORD177108538281413', '2', '1448.00', '2', '2026-02-08 23:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('15', 'ORD177108538281814', '2', '1079.00', '3', '2026-02-10 14:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('16', 'ORD177108538282215', '2', '1276.00', '0', '2026-02-09 18:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('17', 'ORD177108538282616', '2', '587.00', '0', '2026-02-09 00:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('18', 'ORD177108538283017', '2', '242.00', '3', '2026-02-09 20:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('19', 'ORD177108538283418', '2', '951.00', '3', '2026-02-11 19:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('20', 'ORD177108538283819', '2', '522.00', '2', '2026-02-09 16:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('21', 'ORD177108538284220', '2', '2057.00', '1', '2026-02-11 21:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('22', 'ORD177108538284621', '2', '1137.00', '3', '2026-02-11 14:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('23', 'ORD177108538285022', '2', '1330.00', '0', '2026-02-09 19:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('24', 'ORD177108538285423', '2', '1900.00', '1', '2026-02-11 13:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('25', 'ORD177108538285824', '2', '118.00', '3', '2026-02-08 17:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('26', 'ORD177108538286225', '2', '669.00', '0', '2026-02-08 22:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('27', 'ORD177108538286626', '2', '1401.00', '0', '2026-02-13 23:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('28', 'ORD177108538287227', '2', '331.00', '0', '2026-02-13 16:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('29', 'ORD177108538287628', '2', '243.00', '2', '2026-02-10 16:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('30', 'ORD177108538288029', '2', '1407.00', '2', '2026-02-09 14:09:43', null, null, null, '张三', '13800138000', '北京市朝阳区');
INSERT INTO `oms_order` VALUES ('31', '2022708090451345408', '4', '746.00', '3', '2026-02-15 00:22:44', '2026-02-15 00:22:48', '2026-02-15 00:22:58', '2026-02-15 00:23:11', '廖伟力', '18759456287', '仓山万达5号');

-- ----------------------------
-- Table structure for oms_order_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_item`;
CREATE TABLE `oms_order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '??ID',
  `order_id` bigint NOT NULL COMMENT '??ID',
  `product_id` bigint NOT NULL COMMENT '??ID',
  `product_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '????',
  `product_price` decimal(10,2) NOT NULL COMMENT '????',
  `quantity` int NOT NULL COMMENT '????',
  `product_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '????',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='?????';

-- ----------------------------
-- Records of oms_order_item
-- ----------------------------
INSERT INTO `oms_order_item` VALUES ('1', '1', '1', '大黄鱼', '150.00', '1', 'http://localhost:8080/uploads/aced3d6f53e84a8bb7efd68b11692f5a.jpg');
INSERT INTO `oms_order_item` VALUES ('2', '2', '1', '大黄鱼', '150.00', '1', 'http://localhost:8080/uploads/aced3d6f53e84a8bb7efd68b11692f5a.jpg');
INSERT INTO `oms_order_item` VALUES ('3', '3', '1', '大黄鱼', '150.00', '3', 'http://localhost:8080/uploads/aced3d6f53e84a8bb7efd68b11692f5a.jpg');
INSERT INTO `oms_order_item` VALUES ('4', '31', '1', '基围虾', '318.00', '1', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `oms_order_item` VALUES ('5', '31', '30', '带鱼 (特级)', '214.00', '2', 'https://img.yzcdn.cn/vant/apple-2.jpg');

-- ----------------------------
-- Table structure for pms_category
-- ----------------------------
DROP TABLE IF EXISTS `pms_category`;
CREATE TABLE `pms_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '??ID',
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '????',
  `icon` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '??',
  `sort` int DEFAULT '0' COMMENT '??',
  `status` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='?????';

-- ----------------------------
-- Records of pms_category
-- ----------------------------
INSERT INTO `pms_category` VALUES ('1', '鱼类', '/uploads/yulei.jpg', '1', '1');
INSERT INTO `pms_category` VALUES ('2', '虾类', '/uploads/xialei.jpg', '2', '1');
INSERT INTO `pms_category` VALUES ('3', '蟹类', '/uploads/xielei.jpg', '3', '1');
INSERT INTO `pms_category` VALUES ('4', '贝类', '/uploads/belei.jpg', '4', '1');

-- ----------------------------
-- Table structure for pms_product
-- ----------------------------
DROP TABLE IF EXISTS `pms_product`;
CREATE TABLE `pms_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '??ID',
  `category_id` bigint NOT NULL COMMENT '??ID',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '????',
  `price` decimal(10,2) NOT NULL COMMENT '????',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '??',
  `stock` int NOT NULL DEFAULT '0' COMMENT '??',
  `origin` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '??',
  `catch_date` date DEFAULT NULL COMMENT '????',
  `farming_method` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '????',
  `description` text COLLATE utf8mb4_general_ci COMMENT '????',
  `main_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '??',
  `detail_images` json DEFAULT NULL COMMENT '?????',
  `status` tinyint DEFAULT '1' COMMENT '??: 1??, 0??',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '????',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='???';

-- ----------------------------
-- Records of pms_product
-- ----------------------------
INSERT INTO `pms_product` VALUES ('1', '2', '基围虾', '318.00', '349.00', '73', '舟山', '2026-02-12', '深海养殖', '产自舟山的优质基围虾，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('2', '4', '蛤蜊', '408.00', '419.00', '63', '宁波', '2026-01-23', '近海养殖', '产自宁波的优质蛤蜊，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('3', '2', '北极甜虾 (特级)', '509.00', '556.00', '148', '连云港', '2026-01-27', '近海养殖', '产自连云港的优质北极甜虾 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('4', '1', '马鲛鱼', '352.00', '404.00', '61', '宁波', '2026-02-11', '深海养殖', '产自宁波的优质马鲛鱼，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('5', '1', '大黄鱼', '209.00', '245.00', '139', '湛江', '2026-02-14', '深海养殖', '产自湛江的优质大黄鱼，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('6', '3', '帝王蟹 (特级)', '149.00', '187.00', '23', '宁波', '2026-02-02', '深海养殖', '产自宁波的优质帝王蟹 (特级)，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('7', '3', '面包蟹', '153.00', '167.00', '95', '湛江', '2026-02-04', '深海养殖', '产自湛江的优质面包蟹，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('8', '3', '面包蟹', '264.00', '297.00', '72', '舟山', '2026-01-29', '野生捕捞', '产自舟山的优质面包蟹，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('9', '3', '大闸蟹 (特级)', '434.00', '492.00', '90', '宁波', '2026-01-26', '深海养殖', '产自宁波的优质大闸蟹 (特级)，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('10', '1', '海鲈鱼', '386.00', '396.00', '11', '宁波', '2026-01-31', '野生捕捞', '产自宁波的优质海鲈鱼，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('11', '4', '蛤蜊', '522.00', '556.00', '139', '大连', '2026-01-26', '深海养殖', '产自大连的优质蛤蜊，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('12', '3', '面包蟹 (特级)', '496.00', '525.00', '125', '舟山', '2026-01-18', '近海养殖', '产自舟山的优质面包蟹 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('13', '1', '带鱼', '107.00', '145.00', '52', '威海', '2026-02-03', '野生捕捞', '产自威海的优质带鱼，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('14', '4', '鲍鱼', '205.00', '261.00', '99', '大连', '2026-02-04', '深海养殖', '产自大连的优质鲍鱼，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('15', '4', '蛤蜊 (特级)', '509.00', '556.00', '151', '厦门', '2026-02-09', '近海养殖', '产自厦门的优质蛤蜊 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('16', '4', '生蚝', '481.00', '511.00', '153', '舟山', '2026-02-05', '深海养殖', '产自舟山的优质生蚝，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('17', '4', '扇贝', '478.00', '509.00', '134', '大连', '2026-01-29', '近海养殖', '产自大连的优质扇贝，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('18', '2', '波士顿龙虾 (特级)', '143.00', '164.00', '143', '厦门', '2026-01-17', '野生捕捞', '产自厦门的优质波士顿龙虾 (特级)，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('19', '3', '青蟹', '364.00', '390.00', '103', '威海', '2026-02-11', '野生捕捞', '产自威海的优质青蟹，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('20', '3', '青蟹', '104.00', '127.00', '37', '连云港', '2026-02-15', '野生捕捞', '产自连云港的优质青蟹，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('21', '4', '扇贝 (特级)', '488.00', '533.00', '132', '青岛', '2026-01-31', '近海养殖', '产自青岛的优质扇贝 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('22', '2', '对虾', '266.00', '292.00', '98', '大连', '2026-02-04', '深海养殖', '产自大连的优质对虾，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('23', '2', '基围虾', '486.00', '526.00', '89', '湛江', '2026-02-13', '深海养殖', '产自湛江的优质基围虾，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('24', '3', '大闸蟹 (特级)', '460.00', '507.00', '155', '大连', '2026-01-25', '深海养殖', '产自大连的优质大闸蟹 (特级)，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('25', '2', '北极甜虾', '449.00', '490.00', '112', '威海', '2026-01-31', '近海养殖', '产自威海的优质北极甜虾，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('26', '4', '蛤蜊', '325.00', '374.00', '152', '连云港', '2026-02-12', '近海养殖', '产自连云港的优质蛤蜊，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('27', '3', '面包蟹 (特级)', '206.00', '265.00', '126', '湛江', '2026-02-03', '野生捕捞', '产自湛江的优质面包蟹 (特级)，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('28', '1', '海鲈鱼', '241.00', '280.00', '97', '湛江', '2026-01-25', '近海养殖', '产自湛江的优质海鲈鱼，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('29', '1', '石斑鱼', '489.00', '538.00', '133', '连云港', '2026-01-19', '野生捕捞', '产自连云港的优质石斑鱼，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('30', '1', '带鱼 (特级)', '214.00', '232.00', '113', '舟山', '2026-02-08', '近海养殖', '产自舟山的优质带鱼 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('31', '4', '蛤蜊', '130.00', '154.00', '129', '青岛', '2026-02-14', '深海养殖', '产自青岛的优质蛤蜊，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('32', '4', '扇贝', '105.00', '158.00', '10', '连云港', '2026-01-23', '深海养殖', '产自连云港的优质扇贝，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('33', '2', '皮皮虾 (特级)', '399.00', '432.00', '10', '宁波', '2026-01-24', '野生捕捞', '产自宁波的优质皮皮虾 (特级)，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('34', '1', '多宝鱼', '387.00', '426.00', '40', '舟山', '2026-01-18', '深海养殖', '产自舟山的优质多宝鱼，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('35', '4', '鲍鱼', '521.00', '552.00', '154', '厦门', '2026-01-17', '野生捕捞', '产自厦门的优质鲍鱼，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('36', '2', '对虾 (特级)', '387.00', '427.00', '101', '舟山', '2026-02-05', '深海养殖', '产自舟山的优质对虾 (特级)，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('37', '3', '帝王蟹', '162.00', '178.00', '69', '湛江', '2026-02-03', '近海养殖', '产自湛江的优质帝王蟹，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('38', '1', '金枪鱼', '124.00', '144.00', '118', '连云港', '2026-01-27', '近海养殖', '产自连云港的优质金枪鱼，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('39', '1', '大黄鱼 (特级)', '481.00', '536.00', '131', '连云港', '2026-01-23', '野生捕捞', '产自连云港的优质大黄鱼 (特级)，野生捕捞，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('40', '1', '马鲛鱼', '255.00', '265.00', '151', '青岛', '2026-02-08', '深海养殖', '产自青岛的优质马鲛鱼，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('41', '2', '波士顿龙虾', '190.00', '238.00', '92', '青岛', '2026-02-13', '深海养殖', '产自青岛的优质波士顿龙虾，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('42', '4', '蛤蜊 (特级)', '165.00', '183.00', '75', '连云港', '2026-01-27', '近海养殖', '产自连云港的优质蛤蜊 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('43', '4', '生蚝', '431.00', '457.00', '72', '厦门', '2026-02-04', '深海养殖', '产自厦门的优质生蚝，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('44', '3', '帝王蟹', '442.00', '477.00', '95', '威海', '2026-01-30', '近海养殖', '产自威海的优质帝王蟹，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('45', '2', '皮皮虾 (特级)', '197.00', '249.00', '104', '大连', '2026-01-30', '近海养殖', '产自大连的优质皮皮虾 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('46', '1', '石斑鱼', '120.00', '145.00', '106', '宁波', '2026-01-18', '近海养殖', '产自宁波的优质石斑鱼，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('47', '2', '基围虾', '217.00', '247.00', '96', '大连', '2026-01-30', '深海养殖', '产自大连的优质基围虾，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-2.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('48', '4', '鲍鱼 (特级)', '167.00', '203.00', '157', '连云港', '2026-01-21', '近海养殖', '产自连云港的优质鲍鱼 (特级)，近海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('49', '3', '青蟹', '343.00', '374.00', '34', '湛江', '2026-02-06', '深海养殖', '产自湛江的优质青蟹，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('50', '4', '蛤蜊', '531.00', '567.00', '44', '厦门', '2026-02-06', '深海养殖', '产自厦门的优质蛤蜊，深海养殖，新鲜直达。', 'https://img.yzcdn.cn/vant/apple-1.jpg', null, '1');
INSERT INTO `pms_product` VALUES ('51', '1', '深海大黄鱼', '128.00', null, '1000', '浙江舟山', null, '野生捕捞', '肉质鲜美', null, null, '1');

-- ----------------------------
-- Table structure for pms_recipe
-- ----------------------------
DROP TABLE IF EXISTS `pms_recipe`;
CREATE TABLE `pms_recipe` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `content` text,
  `image` varchar(500) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of pms_recipe
-- ----------------------------

-- ----------------------------
-- Table structure for pms_region_stock
-- ----------------------------
DROP TABLE IF EXISTS `pms_region_stock`;
CREATE TABLE `pms_region_stock` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `region_name` varchar(50) NOT NULL,
  `stock_count` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of pms_region_stock
-- ----------------------------
INSERT INTO `pms_region_stock` VALUES ('1', '浙江省', '4275');
INSERT INTO `pms_region_stock` VALUES ('2', '辽宁省', '1987');
INSERT INTO `pms_region_stock` VALUES ('3', '山东省', '4224');
INSERT INTO `pms_region_stock` VALUES ('4', '广东省', '4360');
INSERT INTO `pms_region_stock` VALUES ('5', '福建省', '5019');
INSERT INTO `pms_region_stock` VALUES ('6', '江苏省', '3742');
INSERT INTO `pms_region_stock` VALUES ('7', '河北省', '5106');
INSERT INTO `pms_region_stock` VALUES ('8', '广西壮族自治区', '4142');

-- ----------------------------
-- Table structure for sys_address
-- ----------------------------
DROP TABLE IF EXISTS `sys_address`;
CREATE TABLE `sys_address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `is_default` int DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_address
-- ----------------------------
INSERT INTO `sys_address` VALUES ('1', '4', '廖伟力', '18759456287', '仓山万达5号', '0', '2026-02-15 00:22:17', '2026-02-15 00:22:17');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '??ID',
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '???',
  `password` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '??',
  `nickname` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '??',
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '??',
  `role` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'CUSTOMER' COMMENT '??: ADMIN/CUSTOMER',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='?????';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'root', 'admin', null, 'ADMIN', '2026-02-14 19:25:40');
INSERT INTO `sys_user` VALUES ('2', 'user', '123456', '????', null, 'CUSTOMER', '2026-02-14 19:25:40');
INSERT INTO `sys_user` VALUES ('3', 'test', '123456', 'TestUser', null, 'CUSTOMER', '2026-02-14 20:17:29');

-- ----------------------------
-- Table structure for trace_record
-- ----------------------------
DROP TABLE IF EXISTS `trace_record`;
CREATE TABLE `trace_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '??ID',
  `product_id` bigint NOT NULL COMMENT '??ID',
  `node_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '????(??/??/??/??)',
  `node_time` datetime NOT NULL COMMENT '????',
  `location` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '??',
  `operator` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '???',
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '????',
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '????',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='?????';

-- ----------------------------
-- Records of trace_record
-- ----------------------------
INSERT INTO `trace_record` VALUES ('1', '1', '捕捞/采摘', '2026-02-12 08:00:00', '舟山', '渔船-40', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('2', '1', '加工分拣', '2026-02-13 10:00:00', '舟山加工厂', '工号5', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('3', '1', '质量检测', '2026-02-14 14:00:00', '质检中心', '质检员6', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('4', '1', '入库仓储', '2026-02-15 09:00:00', '冷链仓库', '库管1', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('5', '2', '捕捞/采摘', '2026-01-23 08:00:00', '宁波', '渔船-41', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('6', '2', '加工分拣', '2026-01-24 10:00:00', '宁波加工厂', '工号69', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('7', '2', '质量检测', '2026-01-25 14:00:00', '质检中心', '质检员2', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('8', '2', '入库仓储', '2026-01-26 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('9', '3', '捕捞/采摘', '2026-01-27 08:00:00', '连云港', '渔船-14', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('10', '3', '加工分拣', '2026-01-28 10:00:00', '连云港加工厂', '工号73', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('11', '3', '质量检测', '2026-01-29 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('12', '3', '入库仓储', '2026-01-30 09:00:00', '冷链仓库', '库管1', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('13', '4', '捕捞/采摘', '2026-02-11 08:00:00', '宁波', '渔船-86', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('14', '4', '加工分拣', '2026-02-12 10:00:00', '宁波加工厂', '工号67', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('15', '4', '质量检测', '2026-02-13 14:00:00', '质检中心', '质检员7', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('16', '4', '入库仓储', '2026-02-14 09:00:00', '冷链仓库', '库管17', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('17', '5', '捕捞/采摘', '2026-02-14 08:00:00', '湛江', '渔船-27', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('18', '5', '加工分拣', '2026-02-15 10:00:00', '湛江加工厂', '工号34', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('19', '5', '质量检测', '2026-02-16 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('20', '5', '入库仓储', '2026-02-17 09:00:00', '冷链仓库', '库管3', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('21', '6', '捕捞/采摘', '2026-02-02 08:00:00', '宁波', '渔船-44', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('22', '6', '加工分拣', '2026-02-03 10:00:00', '宁波加工厂', '工号90', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('23', '6', '质量检测', '2026-02-04 14:00:00', '质检中心', '质检员3', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('24', '6', '入库仓储', '2026-02-05 09:00:00', '冷链仓库', '库管18', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('25', '7', '捕捞/采摘', '2026-02-04 08:00:00', '湛江', '渔船-77', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('26', '7', '加工分拣', '2026-02-05 10:00:00', '湛江加工厂', '工号58', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('27', '7', '质量检测', '2026-02-06 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('28', '7', '入库仓储', '2026-02-07 09:00:00', '冷链仓库', '库管14', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('29', '8', '捕捞/采摘', '2026-01-29 08:00:00', '舟山', '渔船-28', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('30', '8', '加工分拣', '2026-01-30 10:00:00', '舟山加工厂', '工号70', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('31', '8', '质量检测', '2026-01-31 14:00:00', '质检中心', '质检员8', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('32', '8', '入库仓储', '2026-02-01 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('33', '9', '捕捞/采摘', '2026-01-26 08:00:00', '宁波', '渔船-3', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('34', '9', '加工分拣', '2026-01-27 10:00:00', '宁波加工厂', '工号32', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('35', '9', '质量检测', '2026-01-28 14:00:00', '质检中心', '质检员7', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('36', '9', '入库仓储', '2026-01-29 09:00:00', '冷链仓库', '库管3', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('37', '10', '捕捞/采摘', '2026-01-31 08:00:00', '宁波', '渔船-40', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('38', '10', '加工分拣', '2026-02-01 10:00:00', '宁波加工厂', '工号7', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('39', '10', '质量检测', '2026-02-02 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('40', '10', '入库仓储', '2026-02-03 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('41', '11', '捕捞/采摘', '2026-01-26 08:00:00', '大连', '渔船-12', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('42', '11', '加工分拣', '2026-01-27 10:00:00', '大连加工厂', '工号72', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('43', '11', '质量检测', '2026-01-28 14:00:00', '质检中心', '质检员7', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('44', '11', '入库仓储', '2026-01-29 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('45', '12', '捕捞/采摘', '2026-01-18 08:00:00', '舟山', '渔船-95', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('46', '12', '加工分拣', '2026-01-19 10:00:00', '舟山加工厂', '工号55', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('47', '12', '质量检测', '2026-01-20 14:00:00', '质检中心', '质检员0', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('48', '12', '入库仓储', '2026-01-21 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('49', '13', '捕捞/采摘', '2026-02-03 08:00:00', '威海', '渔船-86', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('50', '13', '加工分拣', '2026-02-04 10:00:00', '威海加工厂', '工号8', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('51', '13', '质量检测', '2026-02-05 14:00:00', '质检中心', '质检员7', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('52', '13', '入库仓储', '2026-02-06 09:00:00', '冷链仓库', '库管13', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('53', '14', '捕捞/采摘', '2026-02-04 08:00:00', '大连', '渔船-80', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('54', '14', '加工分拣', '2026-02-05 10:00:00', '大连加工厂', '工号77', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('55', '14', '质量检测', '2026-02-06 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('56', '14', '入库仓储', '2026-02-07 09:00:00', '冷链仓库', '库管18', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('57', '15', '捕捞/采摘', '2026-02-09 08:00:00', '厦门', '渔船-209', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('58', '15', '加工分拣', '2026-02-10 10:00:00', '厦门加工厂', '工号69', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('59', '15', '质量检测', '2026-02-11 14:00:00', '质检中心', '质检员3', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('60', '15', '入库仓储', '2026-02-12 09:00:00', '冷链仓库', '库管11', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('61', '16', '捕捞/采摘', '2026-02-05 08:00:00', '舟山', '渔船-36', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('62', '16', '加工分拣', '2026-02-06 10:00:00', '舟山加工厂', '工号98', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('63', '16', '质量检测', '2026-02-07 14:00:00', '质检中心', '质检员7', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('64', '16', '入库仓储', '2026-02-08 09:00:00', '冷链仓库', '库管11', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('65', '17', '捕捞/采摘', '2026-01-29 08:00:00', '大连', '渔船-18', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('66', '17', '加工分拣', '2026-01-30 10:00:00', '大连加工厂', '工号13', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('67', '17', '质量检测', '2026-01-31 14:00:00', '质检中心', '质检员0', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('68', '17', '入库仓储', '2026-02-01 09:00:00', '冷链仓库', '库管17', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('69', '18', '捕捞/采摘', '2026-01-17 08:00:00', '厦门', '渔船-26', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('70', '18', '加工分拣', '2026-01-18 10:00:00', '厦门加工厂', '工号9', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('71', '18', '质量检测', '2026-01-19 14:00:00', '质检中心', '质检员8', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('72', '18', '入库仓储', '2026-01-20 09:00:00', '冷链仓库', '库管8', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('73', '19', '捕捞/采摘', '2026-02-11 08:00:00', '威海', '渔船-65', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('74', '19', '加工分拣', '2026-02-12 10:00:00', '威海加工厂', '工号63', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('75', '19', '质量检测', '2026-02-13 14:00:00', '质检中心', '质检员2', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('76', '19', '入库仓储', '2026-02-14 09:00:00', '冷链仓库', '库管18', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('77', '20', '捕捞/采摘', '2026-02-15 08:00:00', '连云港', '渔船-62', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('78', '20', '加工分拣', '2026-02-16 10:00:00', '连云港加工厂', '工号78', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('79', '20', '质量检测', '2026-02-17 14:00:00', '质检中心', '质检员4', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('80', '20', '入库仓储', '2026-02-18 09:00:00', '冷链仓库', '库管3', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('81', '21', '捕捞/采摘', '2026-01-31 08:00:00', '青岛', '渔船-17', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('82', '21', '加工分拣', '2026-02-01 10:00:00', '青岛加工厂', '工号80', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('83', '21', '质量检测', '2026-02-02 14:00:00', '质检中心', '质检员8', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('84', '21', '入库仓储', '2026-02-03 09:00:00', '冷链仓库', '库管10', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('85', '22', '捕捞/采摘', '2026-02-04 08:00:00', '大连', '渔船-82', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('86', '22', '加工分拣', '2026-02-05 10:00:00', '大连加工厂', '工号10', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('87', '22', '质量检测', '2026-02-06 14:00:00', '质检中心', '质检员7', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('88', '22', '入库仓储', '2026-02-07 09:00:00', '冷链仓库', '库管3', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('89', '23', '捕捞/采摘', '2026-02-13 08:00:00', '湛江', '渔船-27', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('90', '23', '加工分拣', '2026-02-14 10:00:00', '湛江加工厂', '工号2', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('91', '23', '质量检测', '2026-02-15 14:00:00', '质检中心', '质检员4', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('92', '23', '入库仓储', '2026-02-16 09:00:00', '冷链仓库', '库管17', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('93', '24', '捕捞/采摘', '2026-01-25 08:00:00', '大连', '渔船-49', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('94', '24', '加工分拣', '2026-01-26 10:00:00', '大连加工厂', '工号36', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('95', '24', '质量检测', '2026-01-27 14:00:00', '质检中心', '质检员9', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('96', '24', '入库仓储', '2026-01-28 09:00:00', '冷链仓库', '库管0', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('97', '25', '捕捞/采摘', '2026-01-31 08:00:00', '威海', '渔船-10', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('98', '25', '加工分拣', '2026-02-01 10:00:00', '威海加工厂', '工号88', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('99', '25', '质量检测', '2026-02-02 14:00:00', '质检中心', '质检员9', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('100', '25', '入库仓储', '2026-02-03 09:00:00', '冷链仓库', '库管9', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('101', '26', '捕捞/采摘', '2026-02-12 08:00:00', '连云港', '渔船-1', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('102', '26', '加工分拣', '2026-02-13 10:00:00', '连云港加工厂', '工号76', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('103', '26', '质量检测', '2026-02-14 14:00:00', '质检中心', '质检员9', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('104', '26', '入库仓储', '2026-02-15 09:00:00', '冷链仓库', '库管13', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('105', '27', '捕捞/采摘', '2026-02-03 08:00:00', '湛江', '渔船-56', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('106', '27', '加工分拣', '2026-02-04 10:00:00', '湛江加工厂', '工号41', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('107', '27', '质量检测', '2026-02-05 14:00:00', '质检中心', '质检员1', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('108', '27', '入库仓储', '2026-02-06 09:00:00', '冷链仓库', '库管15', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('109', '28', '捕捞/采摘', '2026-01-25 08:00:00', '湛江', '渔船-52', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('110', '28', '加工分拣', '2026-01-26 10:00:00', '湛江加工厂', '工号72', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('111', '28', '质量检测', '2026-01-27 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('112', '28', '入库仓储', '2026-01-28 09:00:00', '冷链仓库', '库管4', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('113', '29', '捕捞/采摘', '2026-01-19 08:00:00', '连云港', '渔船-44', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('114', '29', '加工分拣', '2026-01-20 10:00:00', '连云港加工厂', '工号89', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('115', '29', '质量检测', '2026-01-21 14:00:00', '质检中心', '质检员0', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('116', '29', '入库仓储', '2026-01-22 09:00:00', '冷链仓库', '库管4', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('117', '30', '捕捞/采摘', '2026-02-08 08:00:00', '舟山', '渔船-43', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('118', '30', '加工分拣', '2026-02-09 10:00:00', '舟山加工厂', '工号59', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('119', '30', '质量检测', '2026-02-10 14:00:00', '质检中心', '质检员6', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('120', '30', '入库仓储', '2026-02-11 09:00:00', '冷链仓库', '库管12', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('121', '31', '捕捞/采摘', '2026-02-14 08:00:00', '青岛', '渔船-54', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('122', '31', '加工分拣', '2026-02-15 10:00:00', '青岛加工厂', '工号45', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('123', '31', '质量检测', '2026-02-16 14:00:00', '质检中心', '质检员4', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('124', '31', '入库仓储', '2026-02-17 09:00:00', '冷链仓库', '库管1', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('125', '32', '捕捞/采摘', '2026-01-23 08:00:00', '连云港', '渔船-66', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('126', '32', '加工分拣', '2026-01-24 10:00:00', '连云港加工厂', '工号44', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('127', '32', '质量检测', '2026-01-25 14:00:00', '质检中心', '质检员7', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('128', '32', '入库仓储', '2026-01-26 09:00:00', '冷链仓库', '库管15', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('129', '33', '捕捞/采摘', '2026-01-24 08:00:00', '宁波', '渔船-87', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('130', '33', '加工分拣', '2026-01-25 10:00:00', '宁波加工厂', '工号8', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('131', '33', '质量检测', '2026-01-26 14:00:00', '质检中心', '质检员4', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('132', '33', '入库仓储', '2026-01-27 09:00:00', '冷链仓库', '库管3', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('133', '34', '捕捞/采摘', '2026-01-18 08:00:00', '舟山', '渔船-62', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('134', '34', '加工分拣', '2026-01-19 10:00:00', '舟山加工厂', '工号95', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('135', '34', '质量检测', '2026-01-20 14:00:00', '质检中心', '质检员9', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('136', '34', '入库仓储', '2026-01-21 09:00:00', '冷链仓库', '库管8', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('137', '35', '捕捞/采摘', '2026-01-17 08:00:00', '厦门', '渔船-55', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('138', '35', '加工分拣', '2026-01-18 10:00:00', '厦门加工厂', '工号71', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('139', '35', '质量检测', '2026-01-19 14:00:00', '质检中心', '质检员6', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('140', '35', '入库仓储', '2026-01-20 09:00:00', '冷链仓库', '库管8', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('141', '36', '捕捞/采摘', '2026-02-05 08:00:00', '舟山', '渔船-13', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('142', '36', '加工分拣', '2026-02-06 10:00:00', '舟山加工厂', '工号74', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('143', '36', '质量检测', '2026-02-07 14:00:00', '质检中心', '质检员9', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('144', '36', '入库仓储', '2026-02-08 09:00:00', '冷链仓库', '库管8', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('145', '37', '捕捞/采摘', '2026-02-03 08:00:00', '湛江', '渔船-98', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('146', '37', '加工分拣', '2026-02-04 10:00:00', '湛江加工厂', '工号8', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('147', '37', '质量检测', '2026-02-05 14:00:00', '质检中心', '质检员3', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('148', '37', '入库仓储', '2026-02-06 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('149', '38', '捕捞/采摘', '2026-01-27 08:00:00', '连云港', '渔船-18', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('150', '38', '加工分拣', '2026-01-28 10:00:00', '连云港加工厂', '工号24', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('151', '38', '质量检测', '2026-01-29 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('152', '38', '入库仓储', '2026-01-30 09:00:00', '冷链仓库', '库管18', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('153', '39', '捕捞/采摘', '2026-01-23 08:00:00', '连云港', '渔船-13', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('154', '39', '加工分拣', '2026-01-24 10:00:00', '连云港加工厂', '工号45', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('155', '39', '质量检测', '2026-01-25 14:00:00', '质检中心', '质检员8', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('156', '39', '入库仓储', '2026-01-26 09:00:00', '冷链仓库', '库管12', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('157', '40', '捕捞/采摘', '2026-02-08 08:00:00', '青岛', '渔船-16', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('158', '40', '加工分拣', '2026-02-09 10:00:00', '青岛加工厂', '工号17', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('159', '40', '质量检测', '2026-02-10 14:00:00', '质检中心', '质检员4', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('160', '40', '入库仓储', '2026-02-11 09:00:00', '冷链仓库', '库管14', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('161', '41', '捕捞/采摘', '2026-02-13 08:00:00', '青岛', '渔船-29', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('162', '41', '加工分拣', '2026-02-14 10:00:00', '青岛加工厂', '工号87', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('163', '41', '质量检测', '2026-02-15 14:00:00', '质检中心', '质检员6', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('164', '41', '入库仓储', '2026-02-16 09:00:00', '冷链仓库', '库管15', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('165', '42', '捕捞/采摘', '2026-01-27 08:00:00', '连云港', '渔船-58', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('166', '42', '加工分拣', '2026-01-28 10:00:00', '连云港加工厂', '工号58', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('167', '42', '质量检测', '2026-01-29 14:00:00', '质检中心', '质检员1', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('168', '42', '入库仓储', '2026-01-30 09:00:00', '冷链仓库', '库管8', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('169', '43', '捕捞/采摘', '2026-02-04 08:00:00', '厦门', '渔船-54', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('170', '43', '加工分拣', '2026-02-05 10:00:00', '厦门加工厂', '工号4', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('171', '43', '质量检测', '2026-02-06 14:00:00', '质检中心', '质检员6', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('172', '43', '入库仓储', '2026-02-07 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('173', '44', '捕捞/采摘', '2026-01-30 08:00:00', '威海', '渔船-15', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('174', '44', '加工分拣', '2026-01-31 10:00:00', '威海加工厂', '工号48', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('175', '44', '质量检测', '2026-02-01 14:00:00', '质检中心', '质检员4', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('176', '44', '入库仓储', '2026-02-02 09:00:00', '冷链仓库', '库管19', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('177', '45', '捕捞/采摘', '2026-01-30 08:00:00', '大连', '渔船-75', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('178', '45', '加工分拣', '2026-01-31 10:00:00', '大连加工厂', '工号22', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('179', '45', '质量检测', '2026-02-01 14:00:00', '质检中心', '质检员1', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('180', '45', '入库仓储', '2026-02-02 09:00:00', '冷链仓库', '库管12', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('181', '46', '捕捞/采摘', '2026-01-18 08:00:00', '宁波', '渔船-6', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('182', '46', '加工分拣', '2026-01-19 10:00:00', '宁波加工厂', '工号80', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('183', '46', '质量检测', '2026-01-20 14:00:00', '质检中心', '质检员5', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('184', '46', '入库仓储', '2026-01-21 09:00:00', '冷链仓库', '库管10', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('185', '47', '捕捞/采摘', '2026-01-30 08:00:00', '大连', '渔船-80', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('186', '47', '加工分拣', '2026-01-31 10:00:00', '大连加工厂', '工号36', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('187', '47', '质量检测', '2026-02-01 14:00:00', '质检中心', '质检员8', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('188', '47', '入库仓储', '2026-02-02 09:00:00', '冷链仓库', '库管9', '入库保存', 'https://img.yzcdn.cn/vant/apple-2.jpg');
INSERT INTO `trace_record` VALUES ('189', '48', '捕捞/采摘', '2026-01-21 08:00:00', '连云港', '渔船-36', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('190', '48', '加工分拣', '2026-01-22 10:00:00', '连云港加工厂', '工号55', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('191', '48', '质量检测', '2026-01-23 14:00:00', '质检中心', '质检员2', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('192', '48', '入库仓储', '2026-01-24 09:00:00', '冷链仓库', '库管1', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('193', '49', '捕捞/采摘', '2026-02-06 08:00:00', '湛江', '渔船-90', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('194', '49', '加工分拣', '2026-02-07 10:00:00', '湛江加工厂', '工号79', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('195', '49', '质量检测', '2026-02-08 14:00:00', '质检中心', '质检员4', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('196', '49', '入库仓储', '2026-02-09 09:00:00', '冷链仓库', '库管5', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('197', '50', '捕捞/采摘', '2026-02-06 08:00:00', '厦门', '渔船-92', '完成捕捞作业', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('198', '50', '加工分拣', '2026-02-07 10:00:00', '厦门加工厂', '工号91', '完成清洗分拣', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('199', '50', '质量检测', '2026-02-08 14:00:00', '质检中心', '质检员0', '各项指标合格', 'https://img.yzcdn.cn/vant/apple-1.jpg');
INSERT INTO `trace_record` VALUES ('200', '50', '入库仓储', '2026-02-09 09:00:00', '冷链仓库', '库管12', '入库保存', 'https://img.yzcdn.cn/vant/apple-1.jpg');

-- ----------------------------
-- Table structure for wms_stock_heatmap
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_heatmap`;
CREATE TABLE `wms_stock_heatmap` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '??ID',
  `category_id` bigint NOT NULL COMMENT '??ID',
  `region_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '????',
  `region_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '????',
  `stock_level` int NOT NULL COMMENT '????(1-5)',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '????',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='???????';

-- ----------------------------
-- Records of wms_stock_heatmap
-- ----------------------------

# 水产品销售管理系统

## 项目介绍

本项目是一个水产品销售管理系统，包含后端服务、后台管理端和移动端前端。系统支持水产品分类、商品展示、订单处理、用户管理、销售数据维护和移动端业务操作。

## 技术栈

- Spring Boot 后端
- MySQL
- Maven
- Vue 3
- Vite
- Element Plus
- 移动端前端框架

## 部署要求

- JDK 8/17（以 pom.xml 为准）
- Maven
- MySQL 5.7/8.0
- Node.js 16 或以上
- npm/pnpm

## 运行流程

1. 创建数据库并导入 database 目录下的 SQL。
2. 修改 backend/src/main/resources/application.yml 中的数据库配置。
3. 进入 backend 执行 mvn spring-boot:run 启动后端。
4. 进入 frontend-admin 执行 npm install 和 npm run dev 启动管理端。
5. 进入 frontend-mobile 执行 npm install 和 npm run dev 启动移动端。

## 项目结构

- backend：后端服务
- frontend-admin：管理后台
- frontend-mobile：移动端前端
- database：数据库脚本
- scripts：辅助脚本

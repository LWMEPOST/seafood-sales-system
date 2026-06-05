<template>
  <el-container class="layout-container">
    <el-aside width="200px">
      <div class="logo">水产管理</div>
      <el-menu router :default-active="$route.path" background-color="#001529" text-color="#fff">
        <el-menu-item index="/">
          <el-icon><DataBoard /></el-icon>
          <span>数据总览</span>
        </el-menu-item>
        <el-menu-item index="/product">
          <el-icon><Goods /></el-icon>
          <span>商品管理</span>
        </el-menu-item>
        <el-menu-item index="/order">
          <el-icon><List /></el-icon>
          <span>订单管理</span>
        </el-menu-item>
        <el-menu-item index="/recipe">
          <el-icon><Dish /></el-icon>
          <span>美味食谱</span>
        </el-menu-item>
        <el-menu-item index="/user">
          <el-icon><User /></el-icon>
          <span>用户管理</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-main>
      <router-view />
    </el-main>
  </el-container>
</template>

<style scoped>
.layout-container {
  height: 100vh;
}
.el-aside {
  background-color: #001529;
  color: #fff;
}
.logo {
  height: 60px;
  line-height: 60px;
  text-align: center;
  font-size: 20px;
  font-weight: bold;
  background: #002140;
}
.el-main {
  background-color: #f0f2f5;
  padding: 20px;
}
</style>

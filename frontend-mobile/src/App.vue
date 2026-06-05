<template>
  <div class="app-container">
    <router-view />
    
    <van-tabbar v-if="showTabbar" route>
      <van-tabbar-item replace to="/" icon="home-o">首页</van-tabbar-item>
      <van-tabbar-item replace to="/category" icon="apps-o">分类</van-tabbar-item>
      <van-tabbar-item replace to="/cart" icon="cart-o">购物车</van-tabbar-item>
      <van-tabbar-item replace to="/user" icon="user-o">我的</van-tabbar-item>
    </van-tabbar>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const showTabbar = computed(() => {
  return ['/', '/category', '/cart', '/user'].includes(route.path)
})
</script>

<style>
:root {
  --van-primary-color: #1989fa;
  --van-success-color: #07c160;
  --bg-color: #fafaf5; /* 米白 */
  --text-color-primary: #323233;
  --text-color-secondary: #969799;
  --brand-blue: #1989fa;
  --brand-light-blue: #e8f3ff;
}

body {
  background-color: var(--bg-color);
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Helvetica Neue', Helvetica, Segoe UI, Arial, Roboto, 'PingFang SC', 'miui', 'Hiragino Sans GB', 'Microsoft Yahei', sans-serif;
  color: var(--text-color-primary);
  -webkit-font-smoothing: antialiased;
}

.app-container {
  padding-bottom: 50px;
  max-width: 600px; /* Limit width for larger screens to maintain mobile aspect */
  margin: 0 auto;
  min-height: 100vh;
  background-color: var(--bg-color);
}

/* Vant Overrides for Sea Theme */
.van-nav-bar {
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
}
.van-nav-bar__title {
  font-weight: 600;
  color: #1a2a3a;
}
.van-tabbar-item--active {
  color: var(--brand-blue);
}
</style>

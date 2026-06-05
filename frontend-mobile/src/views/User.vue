<template>
  <div class="user-page">
    <van-nav-bar title="我的" fixed placeholder />
    <div class="profile-card">
      <img class="avatar" :src="displayUser.avatar" />
      <div class="info">
        <div class="name">{{ displayUser.nickname }}</div>
        <div class="sub">会员等级：{{ displayUser.level }}</div>
        <div class="actions" v-if="!userStore.isLoggedIn">
          <van-button size="small" type="primary" @click="router.push('/login')">登录</van-button>
          <van-button size="small" @click="router.push('/register')">注册</van-button>
        </div>
        <div class="actions" v-else>
          <van-button size="small" type="danger" @click="handleLogout">退出登录</van-button>
        </div>
      </div>
    </div>

    <van-cell-group inset>
      <van-cell title="我的订单" is-link @click="handleOrders" />
      <van-cell title="收货地址" is-link @click="router.push('/address')" />
      <van-cell title="联系客服" is-link />
    </van-cell-group>
  </div>
</template>

<script setup>
import { computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()
const displayUser = computed(() => {
  if (userStore.userInfo) {
    return {
      nickname: userStore.userInfo.nickname || userStore.userInfo.username || '海鲜会员',
      level: userStore.userInfo.role === 'ADMIN' ? '管理员' : '普通会员',
      avatar: userStore.userInfo.avatar || 'https://img.yzcdn.cn/vant/cat.jpeg'
    }
  }
  return {
    nickname: '未登录',
    level: '访客',
    avatar: 'https://img.yzcdn.cn/vant/cat.jpeg'
  }
})

onMounted(async () => {
  if (userStore.isLoggedIn && !userStore.userInfo) {
    await userStore.fetchUserInfo()
  }
})

const handleOrders = () => {
  if (!userStore.isLoggedIn) {
    router.push('/login')
    return
  }
  router.push('/orders')
}

const handleLogout = () => {
  userStore.logout()
}
</script>

<style scoped>
.user-page {
  min-height: 100vh;
  background: var(--bg-color);
  padding-bottom: 80px;
}
.profile-card {
  margin: 16px;
  padding: 24px;
  background: #fff;
  border-radius: 16px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 4px 16px rgba(0,0,0,0.04);
}
.avatar {
  width: 72px;
  height: 72px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}
.info {
  flex: 1;
}
.info .name {
  font-size: 20px;
  font-weight: 600;
  color: #1a2a3a;
  margin-bottom: 4px;
}
.info .sub {
  color: #969799;
  font-size: 13px;
}
.actions {
  margin-top: 12px;
  display: flex;
  gap: 8px;
}
</style>

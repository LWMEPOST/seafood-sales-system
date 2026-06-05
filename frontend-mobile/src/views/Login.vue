<template>
  <div class="auth-page">
    <van-nav-bar title="用户登录" left-arrow fixed placeholder @click-left="handleBack" />
    <div class="auth-card">
      <h2>鲜到家</h2>
      <van-form @submit="handleSubmit">
        <van-field v-model="form.username" name="username" label="用户名" placeholder="请输入用户名" />
        <van-field v-model="form.password" name="password" label="密码" type="password" placeholder="请输入密码" />
        <div class="actions">
          <van-button block type="primary" native-type="submit">登录</van-button>
        </div>
      </van-form>
      <div class="link">
        <span>还没有账号？</span>
        <van-button type="primary" size="small" plain @click="router.push('/register')">去注册</van-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import { showToast } from 'vant'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()
const form = reactive({
  username: '',
  password: ''
})

const handleSubmit = async () => {
  if (!form.username || !form.password) {
    showToast('请输入用户名和密码')
    return
  }
  await userStore.loginUser(form)
  showToast('登录成功')
  router.replace('/user')
}

const handleBack = () => {
  if (window.history.length > 1) {
    router.back()
  } else {
    router.replace('/user')
  }
}
</script>

<style scoped>
.auth-page {
  min-height: 100vh;
  background: #f7f8fa;
}
.auth-card {
  margin: 24px;
  padding: 24px;
  background: #fff;
  border-radius: 16px;
  text-align: center;
}
.auth-card h2 {
  margin: 0 0 16px 0;
  font-size: 22px;
  color: #1f2d3d;
}
.actions {
  margin-top: 16px;
}
.link {
  margin-top: 16px;
  display: flex;
  justify-content: center;
  gap: 8px;
  align-items: center;
  color: #909399;
  font-size: 12px;
}
</style>

<template>
  <div class="login-page">
    <div class="login-card">
      <h2>水产管理系统</h2>
      <el-form :model="form" @submit.prevent>
        <el-form-item label="用户名">
          <el-input v-model="form.username" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password" type="password" placeholder="请输入密码" />
        </el-form-item>
        <el-button type="primary" class="login-btn" @click="handleLogin">登录</el-button>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { login } from '@/api/user'

const router = useRouter()
const form = reactive({
  username: '',
  password: ''
})

const handleLogin = async () => {
  if (!form.username || !form.password) {
    ElMessage.warning('请输入用户名和密码')
    return
  }
  const res = await login(form)
  if (res.userInfo && res.userInfo.role !== 'ADMIN') {
    ElMessage.error('非管理员账号')
    return
  }
  localStorage.setItem('token', res.token)
  localStorage.setItem('userInfo', JSON.stringify(res.userInfo || {}))
  ElMessage.success('登录成功')
  router.replace('/')
}
</script>

<style scoped>
.login-page {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
}
.login-card {
  width: 360px;
  padding: 28px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #fff;
}
.login-card h2 {
  margin: 0 0 20px 0;
  text-align: center;
}
.login-btn {
  width: 100%;
}
</style>

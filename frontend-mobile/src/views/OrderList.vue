<template>
  <div class="orders-page">
    <van-nav-bar title="我的订单" left-arrow fixed placeholder @click-left="handleBack" />
    <van-empty v-if="orders.length === 0" description="暂无订单" />

    <div v-else class="order-list">
      <van-card
        v-for="order in orders"
        :key="order.id"
        :title="`订单号：${order.orderSn}`"
        thumb="https://img.yzcdn.cn/vant/apple-1.jpg"
        :price="order.totalAmount"
        :desc="`收货地址：${order.receiverAddress || '-'}`"
        @click="router.push(`/order/${order.id}`)"
      >
        <template #tags>
          <van-tag :type="statusType(order.status)">{{ statusText(order.status) }}</van-tag>
        </template>
      </van-card>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { getOrderList } from '@/api/order'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const orders = ref([])
const userStore = useUserStore()

const statusText = (status) => {
  const map = {
    0: '待支付',
    1: '待发货',
    2: '已发货',
    3: '已完成'
  }
  return map[status] || '未知'
}

const statusType = (status) => {
  if (status === 0) return 'warning'
  if (status === 1) return 'primary'
  if (status === 2) return 'success'
  if (status === 3) return 'default'
  return 'default'
}

const handleBack = () => {
  if (window.history.length > 1) {
    router.back()
  } else {
    router.replace('/user')
  }
}

onMounted(async () => {
  if (!userStore.isLoggedIn) {
    router.replace('/login')
    return
  }
  if (!userStore.userId) {
    await userStore.fetchUserInfo()
  }
  if (!userStore.userId) {
    router.replace('/login')
    return
  }
  const res = await getOrderList(userStore.userId)
  orders.value = res || []
})
</script>

<style scoped>
.orders-page {
  min-height: 100vh;
  background: #f7f8fa;
}
.order-list {
  padding: 10px;
}
</style>

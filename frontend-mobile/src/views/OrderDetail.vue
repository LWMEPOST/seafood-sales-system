<template>
  <div class="order-detail-page">
    <van-nav-bar title="订单详情" left-arrow fixed placeholder @click-left="router.back()" />

    <div v-if="order.id">
      <!-- Status Steps -->
      <div class="status-card">
        <van-steps :active="order.status" active-color="#07c160">
          <van-step>待支付</van-step>
          <van-step>待发货</van-step>
          <van-step>已发货</van-step>
          <van-step>已完成</van-step>
        </van-steps>
        <div class="status-text">{{ statusText(order.status) }}</div>
      </div>

      <!-- Address -->
      <div class="info-card">
        <van-cell title="收货信息" icon="location-o" :label="`${order.receiverName} ${order.receiverPhone}\n${order.receiverAddress}`" />
      </div>

      <!-- Products -->
      <div class="info-card">
        <van-card
          v-for="item in order.items"
          :key="item.id"
          :title="item.productName"
          :thumb="item.productImage || 'https://img.yzcdn.cn/vant/apple-1.jpg'"
          :price="item.productPrice"
          :num="item.quantity"
        />
        <van-cell title="订单总额" :value="`¥${order.totalAmount}`" />
      </div>

      <!-- Order Info -->
      <div class="info-card">
        <van-cell title="订单编号" :value="order.orderSn" />
        <van-cell title="下单时间" :value="formatTime(order.createTime)" />
        <van-cell v-if="order.paymentTime" title="支付时间" :value="formatTime(order.paymentTime)" />
        <van-cell v-if="order.deliveryTime" title="发货时间" :value="formatTime(order.deliveryTime)" />
        <van-cell v-if="order.receiveTime" title="成交时间" :value="formatTime(order.receiveTime)" />
      </div>

      <!-- Actions -->
      <div class="action-bar">
        <van-button v-if="order.status === 0" type="danger" round block @click="handlePay">
          立即支付
        </van-button>
        <van-button v-if="order.status === 2" type="primary" round block @click="handleReceive">
          确认收货
        </van-button>
        <van-button v-if="order.status === 3 || order.status === 4" type="default" round block disabled>
          订单已完成
        </van-button>
      </div>
    </div>
    
    <van-empty v-else description="加载中..." />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { showToast, showDialog } from 'vant'
import { getOrderDetail, payOrder, confirmReceive } from '@/api/order'

const route = useRoute()
const router = useRouter()
const order = ref({})

const statusText = (status) => {
  const map = {
    0: '等待买家付款',
    1: '等待商家发货',
    2: '商家已发货',
    3: '交易完成'
  }
  return map[status] || '未知状态'
}

const formatTime = (timeStr) => {
  if (!timeStr) return '-'
  return timeStr.replace('T', ' ')
}

const loadOrder = async () => {
  const id = route.params.id
  try {
    const res = await getOrderDetail(id)
    if (res) {
      order.value = res
    } else {
      showToast('订单不存在')
      router.back()
    }
  } catch (error) {
    console.error(error)
    showToast('加载失败')
  }
}

const handlePay = async () => {
  try {
    await payOrder(order.value.id)
    showToast('支付成功')
    loadOrder() // Reload to update status
  } catch (error) {
    showToast('支付失败')
  }
}

const handleReceive = async () => {
  showDialog({
    title: '确认收货',
    message: '确认已收到商品且无质量问题？',
    showCancelButton: true
  }).then(async (action) => {
    if (action === 'confirm') {
      try {
        await confirmReceive(order.value.id)
        showToast('已确认收货')
        loadOrder()
      } catch (error) {
        showToast('操作失败')
      }
    }
  })
}

onMounted(() => {
  loadOrder()
})
</script>

<style scoped>
.order-detail-page {
  min-height: 100vh;
  background: #f7f8fa;
  padding-bottom: 80px;
}
.status-card {
  background: #fff;
  padding: 20px 0;
  margin-bottom: 10px;
  text-align: center;
}
.status-text {
  margin-top: 15px;
  font-weight: bold;
  font-size: 18px;
  color: #333;
}
.info-card {
  background: #fff;
  margin-bottom: 10px;
  padding: 10px 0;
}
.action-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: #fff;
  padding: 10px 20px;
  box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
  display: flex;
  gap: 10px;
}
</style>

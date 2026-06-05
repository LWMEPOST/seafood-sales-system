<template>
  <div class="cart-page">
    <van-nav-bar title="购物车" fixed placeholder left-arrow @click-left="handleBack" />

    <van-empty v-if="cartStore.items.length === 0" description="购物车为空" />

    <div class="address-card" v-if="cartStore.items.length > 0">
      <van-cell-group inset>
        <van-cell
          v-if="userStore.hasAddress"
          title="收货信息"
          :label="`${userStore.address.name} ${userStore.address.phone}\n${userStore.address.detail}`"
          is-link
          to="/address"
          center
          icon="location-o"
        />
        <van-cell
          v-else
          title="请填写收货地址"
          is-link
          to="/address"
          icon="location-o"
        />
      </van-cell-group>
    </div>

    <div v-if="cartStore.items.length > 0" class="cart-list">
      <van-card
        v-for="item in cartStore.items"
        :key="item.productId"
        :title="item.productName"
        :thumb="item.productImage || 'https://img.yzcdn.cn/vant/apple-1.jpg'"
        :price="item.productPrice"
      >
        <template #footer>
          <div class="card-footer">
            <van-stepper
              v-model="item.quantity"
              min="1"
              @change="value => updateQuantity(item.productId, value)"
            />
            <van-button type="danger" size="small" @click="removeItem(item.productId)">删除</van-button>
          </div>
        </template>
      </van-card>
    </div>

    <van-submit-bar
      :price="Math.round(totalPrice * 100)"
      button-text="提交订单"
      :disabled="cartStore.items.length === 0"
      @submit="handleSubmit"
    >
      <span>共 {{ totalCount }} 件</span>
    </van-submit-bar>
  </div>
</template>

<script setup>
import { computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { showToast } from 'vant'
import { createOrder, payOrder } from '@/api/order'
import { useCartStore } from '@/stores/cart'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const cartStore = useCartStore()
const userStore = useUserStore()
const totalPrice = computed(() => cartStore.totalPrice)
const totalCount = computed(() => cartStore.totalCount)

onMounted(async () => {
  if (userStore.isLoggedIn && !userStore.hasAddress) {
    await userStore.fetchAddress()
  }
})

const updateQuantity = (productId, value) => {
  cartStore.updateQuantity(productId, value)
}

const removeItem = (productId) => {
  cartStore.removeItem(productId)
}

const handleSubmit = async () => {
  if (cartStore.items.length === 0) {
    showToast('购物车为空')
    return
  }
  if (!userStore.hasAddress) {
    showToast('请先完善收货地址')
    router.push('/address')
    return
  }
  if (!userStore.isLoggedIn) {
    showToast('请先登录')
    router.push('/login')
    return
  }
  if (!userStore.userId) {
    await userStore.fetchUserInfo()
  }
  if (!userStore.userId) {
    showToast('用户信息异常')
    return
  }
  const orderId = await createOrder({
    userId: userStore.userId,
    items: cartStore.items,
    receiverName: userStore.address.name,
    receiverPhone: userStore.address.phone,
    receiverAddress: userStore.address.detail
  })
  if (orderId) {
    cartStore.clear()
    showToast('下单成功，请支付')
    router.replace(`/order/${orderId}`)
  }
}

const handleBack = () => {
  if (window.history.state && window.history.state.back) {
    router.back()
  } else {
    router.replace('/')
  }
}
</script>

<style scoped>
.cart-page {
  min-height: 100vh;
  background: var(--bg-color);
  padding-bottom: 100px;
}
.address-card {
  margin: 12px 16px;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.02);
}
.cart-list {
  margin: 12px 16px;
}
.van-card {
  background: #fff;
  border-radius: 12px;
  margin-bottom: 12px;
  padding: 16px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.02);
}
.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 8px;
}
</style>

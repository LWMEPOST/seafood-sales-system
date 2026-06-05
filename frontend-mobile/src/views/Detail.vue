<template>
  <div class="detail-page">
    <van-nav-bar
      title="商品详情"
      left-arrow
      @click-left="handleBack"
      fixed
      placeholder
      :border="false"
      class="transparent-nav"
    />
    
    <div class="product-header">
      <img :src="product.mainImage || 'https://img.yzcdn.cn/vant/apple-1.jpg'" class="main-img" />
      <div class="info-card">
        <h1 class="title">{{ product.name }}</h1>
        <div class="price-row">
          <span class="price">¥{{ product.price }}</span>
          <span class="stock">库存 {{ product.stock }}</span>
        </div>
        <p class="desc">{{ product.description }}</p>
        
        <div class="tags-row">
          <van-tag color="#e8f3ff" text-color="#1989fa" size="medium">{{ product.farmingMethod }}</van-tag>
          <van-tag color="#f0f9eb" text-color="#07c160" size="medium" v-if="product.origin">{{ product.origin }}</van-tag>
        </div>

        <div class="meta-grid">
          <div class="meta-item">
            <van-icon name="location-o" />
            <span>{{ product.origin }}</span>
          </div>
          <div class="meta-item">
            <van-icon name="clock-o" />
            <span>{{ product.catchDate }}</span>
          </div>
          <div class="meta-item">
            <van-icon name="passed" />
            <span>质检合格</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Traceability Preview -->
    <div class="section-card trace-section">
      <div class="section-title">
        <h3>全程溯源</h3>
        <span class="view-more" @click.stop="openTracePopup">查看详情 <van-icon name="arrow" /></span>
      </div>
      <div v-if="latestTrace" class="trace-preview" @click="openTracePopup">
        <div class="trace-preview-head">
          <div class="trace-preview-node">{{ latestTrace.nodeName }}</div>
          <div class="trace-preview-time">{{ latestTrace.nodeTime || '暂无时间' }}</div>
        </div>
        <div class="trace-preview-line">地点：{{ latestTrace.location || '暂无地点' }}</div>
        <div v-if="latestTrace.description" class="trace-preview-desc">{{ latestTrace.description }}</div>
        <div class="trace-preview-hint">点击查看完整溯源链路</div>
      </div>
      <van-empty v-else description="暂无溯源信息" image="search" />
    </div>

    <!-- Recipe Recommendation (Mock) -->
    <div class="section-card">
      <div class="section-title">
        <h3>美味食谱</h3>
        <span v-if="recipeInfo && recipeInfo.id" class="view-more" @click.stop="openRecipePopup">查看做法 <van-icon name="arrow" /></span>
      </div>
      <div v-if="recipeInfo && recipeInfo.id" class="recipe-card" @click="openRecipePopup">
        <img :src="recipeInfo.image || 'https://img.yzcdn.cn/vant/apple-2.jpg'" class="recipe-img" />
        <div class="recipe-info">
          <h4>{{ recipeInfo.title }}</h4>
          <p>{{ recipeInfo.content }}</p>
        </div>
      </div>
      <van-empty v-else description="暂无食谱推荐" image="search" />
    </div>

    <van-popup
      :show="tracePopupVisible"
      @update:show="tracePopupVisible = $event"
      position="bottom"
      teleport="body"
      round
      closeable
      :style="{ height: '75%' }"
    >
      <div class="trace-popup">
        <div class="trace-popup-title">全程溯源详情</div>
        <div class="trace-popup-content">
          <div v-for="(item, index) in traceList" :key="index" class="trace-detail-card">
            <div class="trace-detail-head">
              <div class="trace-detail-node">{{ item.nodeName }}</div>
              <div class="trace-detail-time">{{ item.nodeTime || '暂无时间' }}</div>
            </div>
            <div class="trace-detail-line">地点：{{ item.location || '暂无地点' }}</div>
            <div class="trace-detail-line">操作人：{{ item.operator || '系统' }}</div>
            <div v-if="item.description" class="trace-detail-desc">{{ item.description }}</div>
            <img
              v-if="item.image"
              :src="item.image"
              class="trace-detail-image"
            />
          </div>
          <van-empty v-if="traceList.length === 0" description="暂无溯源信息" image="search" />
        </div>
      </div>
    </van-popup>

    <van-popup
      :show="recipePopupVisible"
      @update:show="recipePopupVisible = $event"
      position="bottom"
      teleport="body"
      round
      closeable
      :style="{ height: '75%' }"
    >
      <div class="trace-popup">
        <div class="trace-popup-title">食谱详情</div>
        <div class="trace-popup-content" v-if="recipeInfo && recipeInfo.id">
          <img
            :src="recipeInfo.image || 'https://img.yzcdn.cn/vant/apple-2.jpg'"
            class="recipe-detail-image"
          />
          <div class="recipe-detail-title">{{ recipeInfo.title }}</div>
          <div class="recipe-detail-content">{{ recipeInfo.content }}</div>
        </div>
        <van-empty v-else description="暂无食谱推荐" image="search" />
      </div>
    </van-popup>

    <!-- Action Bar -->
    <van-action-bar style="z-index: 100;">
      <van-action-bar-icon icon="chat-o" text="客服" />
      <van-action-bar-icon icon="cart-o" text="购物车" @click="router.push('/cart')" />
      <van-action-bar-button color="#be99ff" type="warning" text="加入购物车" @click="handleAddToCart" />
      <van-action-bar-button color="#7232dd" type="danger" text="立即购买" @click="handleBuy" />
    </van-action-bar>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { showToast } from 'vant'
import { getProductDetail, getTraceRecords, getRecipeByProductId } from '@/api/product'
import { useCartStore } from '@/stores/cart'
import { useUserStore } from '@/stores/user'

const route = useRoute()
const router = useRouter()
const product = ref({})
const traceList = ref([])
const recipeInfo = ref(null)
const tracePopupVisible = ref(false)
const recipePopupVisible = ref(false)
const cartStore = useCartStore()
const userStore = useUserStore()
const latestTrace = computed(() => {
  if (!traceList.value.length) return null
  return traceList.value[traceList.value.length - 1]
})

onMounted(async () => {
  const productId = route.params.id
  try {
    const [resProduct, resTrace, resRecipe] = await Promise.all([
      getProductDetail(productId),
      getTraceRecords(productId),
      getRecipeByProductId(productId)
    ])
    product.value = resProduct || {}
    traceList.value = resTrace || []
    recipeInfo.value = resRecipe || null
  } catch (error) {
    console.error('Failed to load detail', error)
    showToast('商品信息加载失败')
  }
})

const openTracePopup = () => {
  if (!traceList.value.length) {
    showToast('暂无溯源信息')
    return
  }
  tracePopupVisible.value = true
}

const openRecipePopup = () => {
  if (!recipeInfo.value || !recipeInfo.value.id) {
    showToast('暂无食谱推荐')
    return
  }
  recipePopupVisible.value = true
}

const handleBuy = async () => {
  if (!userStore.isLoggedIn) {
    showToast('请先登录')
    router.push('/login')
    return
  }
  // Ensure product loaded
  if (!product.value.id) {
    showToast('商品数据未加载')
    return
  }
  try {
    const orderItem = {
      productId: product.value.id,
      productName: product.value.name,
      productPrice: product.value.price,
      quantity: 1,
      productImage: product.value.mainImage
    }

    cartStore.addItem(orderItem)
    showToast('已加入购物车，请填写收货地址')
    router.push('/cart')
  } catch (error) {
    console.error('Order failed', error)
  }
}

const handleAddToCart = () => {
  if (!userStore.isLoggedIn) {
    showToast('请先登录')
    router.push('/login')
    return
  }
  if (!product.value.id) {
    showToast('商品信息缺失')
    return
  }
  cartStore.addItem({
    productId: product.value.id,
    productName: product.value.name,
    productPrice: Number(product.value.price || 0),
    quantity: 1,
    productImage: product.value.mainImage
  })
  showToast('已加入购物车')
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
.detail-page {
  background: #fafaf5;
  padding-bottom: 80px;
}
.main-img {
  width: 100%;
  height: 400px;
  object-fit: cover;
}
.info-card {
  background: #fff;
  padding: 24px 20px;
  margin-top: -30px;
  border-radius: 24px 24px 0 0;
  position: relative;
  z-index: 1;
  box-shadow: 0 -4px 16px rgba(0,0,0,0.02);
}
.title {
  font-size: 22px;
  margin: 0 0 12px 0;
  color: #1a2a3a;
  font-weight: 600;
}
.price-row {
  display: flex;
  align-items: baseline;
  margin-bottom: 12px;
}
.price {
  color: #323233;
  font-size: 28px;
  font-weight: 600;
}
.stock {
  color: #969799;
  font-size: 13px;
  margin-left: 12px;
}
.desc {
  color: #646566;
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 16px;
}
.tags-row {
  display: flex;
  gap: 8px;
  margin-bottom: 20px;
}
.meta-grid {
  display: flex;
  justify-content: space-between;
  padding-top: 20px;
  border-top: 1px solid #f5f6f7;
}
.meta-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  color: #646566;
  font-size: 12px;
}
.meta-item .van-icon {
  font-size: 20px;
  color: #1989fa;
}

.section-card {
  margin: 12px 16px;
  background: #fff;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.02);
}
.section-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.section-title h3 {
  margin: 0;
  font-size: 18px;
  color: #1a2a3a;
  border-left: 4px solid #1989fa;
  padding-left: 10px;
}
.view-more {
  font-size: 12px;
  color: #969799;
  display: flex;
  align-items: center;
  gap: 2px;
  cursor: pointer;
}
.trace-preview {
  background: #f7f8fa;
  border-radius: 10px;
  padding: 12px;
}
.trace-preview-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}
.trace-preview-node {
  font-size: 14px;
  font-weight: 600;
  color: #323233;
}
.trace-preview-time {
  font-size: 12px;
  color: #969799;
}
.trace-preview-line {
  margin-top: 8px;
  font-size: 12px;
  color: #646566;
}
.trace-preview-desc {
  margin-top: 8px;
  font-size: 12px;
  color: #323233;
  line-height: 1.5;
}
.trace-preview-hint {
  margin-top: 10px;
  font-size: 12px;
  color: #1989fa;
}

.node-title {
  margin: 0;
  font-size: 15px;
  color: #323233;
  font-weight: 500;
}
.node-time {
  margin: 4px 0;
  color: #969799;
  font-size: 12px;
}
.node-loc {
  margin: 0;
  color: #1989fa;
  font-size: 12px;
  display: flex;
  align-items: center;
  gap: 4px;
}
.node-desc {
  margin-top: 4px;
  color: #646566;
  font-size: 12px;
  background: #f7f8fa;
  padding: 8px;
  border-radius: 4px;
}

.recipe-card {
  display: flex;
  gap: 12px;
  background: #f7f8fa;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
}
.recipe-img {
  width: 100px;
  height: 80px;
  object-fit: cover;
}
.recipe-info {
  padding: 8px;
  flex: 1;
}
.recipe-info h4 {
  margin: 0 0 6px 0;
  font-size: 14px;
  color: #323233;
}
.recipe-info p {
  margin: 0;
  font-size: 12px;
  color: #969799;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.recipe-detail-image {
  width: 100%;
  border-radius: 10px;
  object-fit: cover;
  max-height: 220px;
}
.recipe-detail-title {
  margin-top: 12px;
  font-size: 16px;
  font-weight: 600;
  color: #1a2a3a;
}
.recipe-detail-content {
  margin-top: 10px;
  font-size: 14px;
  line-height: 1.8;
  color: #323233;
  white-space: pre-wrap;
}
.trace-popup {
  height: 100%;
  display: flex;
  flex-direction: column;
}
.trace-popup-title {
  font-size: 16px;
  font-weight: 600;
  color: #1a2a3a;
  padding: 18px 16px 10px;
}
.trace-popup-content {
  flex: 1;
  overflow-y: auto;
  padding: 0 16px 16px;
}
.trace-detail-card {
  background: #f7f8fa;
  border-radius: 10px;
  padding: 12px;
  margin-bottom: 10px;
}
.trace-detail-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}
.trace-detail-node {
  font-size: 14px;
  font-weight: 600;
  color: #323233;
}
.trace-detail-time {
  font-size: 12px;
  color: #969799;
}
.trace-detail-line {
  margin-top: 6px;
  font-size: 12px;
  color: #646566;
}
.trace-detail-desc {
  margin-top: 8px;
  font-size: 12px;
  color: #323233;
  line-height: 1.5;
}
.trace-detail-image {
  width: 100%;
  border-radius: 8px;
  margin-top: 8px;
  max-height: 180px;
  object-fit: cover;
}
</style>

<template>
  <div class="category-page">
    <van-nav-bar title="分类" fixed placeholder :border="false" />
    
    <div class="container">
      <!-- Left Sidebar -->
      <div class="sidebar">
        <div 
          v-for="(cat, index) in categories" 
          :key="cat.id" 
          :class="['sidebar-item', { active: activeIndex === index }]"
          @click="handleCategoryClick(index, cat.id)"
        >
          <div class="indicator" v-if="activeIndex === index"></div>
          {{ cat.name }}
        </div>
      </div>

      <!-- Right Content -->
      <div class="content">
        <div class="banner-wrapper" v-if="currentCategory">
          <img :src="currentCategory.icon || 'https://img.yzcdn.cn/vant/apple-1.jpg'" class="cat-banner" />
          <div class="banner-text">
            <h3>{{ currentCategory.name }}专区</h3>
            <p>新鲜直达 · 品质保证</p>
          </div>
        </div>

        <van-list
          v-model:loading="loading"
          :finished="finished"
          finished-text="没有更多了"
          @load="onLoad"
        >
          <div 
            class="product-item" 
            v-for="item in products" 
            :key="item.id"
            @click="router.push(`/detail/${item.id}`)"
          >
            <img :src="item.mainImage || 'https://img.yzcdn.cn/vant/apple-1.jpg'" class="prod-img" />
            <div class="prod-info">
              <h4 class="prod-name">{{ item.name }}</h4>
              <div class="tags">
                <van-tag plain type="primary" size="mini">{{ item.origin }}</van-tag>
                <van-tag plain type="success" size="mini" v-if="item.farmingMethod">{{ item.farmingMethod }}</van-tag>
              </div>
              <div class="prod-bottom">
                <span class="price">¥{{ item.price }}</span>
                <van-icon name="add" color="#1989fa" size="24" @click.stop="addToCart(item)" />
              </div>
            </div>
          </div>
        </van-list>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { showToast } from 'vant'
import { getCategoryList, getProductPage } from '@/api/product' // Need to implement getCategoryList
import { useCartStore } from '@/stores/cart'

const router = useRouter()
const route = useRoute()
const cartStore = useCartStore()

const categories = ref([])
const activeIndex = ref(0)
const currentCategory = ref(null)

const products = ref([])
const loading = ref(false)
const finished = ref(false)
const page = ref(1)

onMounted(async () => {
  await loadCategories()
})

const loadCategories = async () => {
  try {
    const res = await getCategoryList()
    categories.value = res || []
    if (categories.value.length > 0) {
      // Check for query param 'id'
      const queryId = route.query.id ? Number(route.query.id) : null
      if (queryId) {
        const index = categories.value.findIndex(c => c.id === queryId)
        if (index !== -1) {
          activeIndex.value = index
        }
      }
      
      currentCategory.value = categories.value[activeIndex.value]
      // Initial load of products for selected category
      onLoad() 
    }
  } catch (error) {
    console.error('Failed to load categories', error)
  }
}

const handleCategoryClick = (index, id) => {
  if (activeIndex.value === index) return
  activeIndex.value = index
  currentCategory.value = categories.value[index]
  
  // Reset product list
  products.value = []
  page.value = 1
  finished.value = false
  loading.value = true // Set loading to prevent multiple triggers
  onLoad()
}

const onLoad = async () => {
  if (!currentCategory.value) {
    loading.value = false
    return
  }
  
  try {
    const res = await getProductPage({
      page: page.value,
      size: 10,
      categoryId: currentCategory.value.id
    })
    
    if (res && res.records) {
      if (page.value === 1) {
        products.value = res.records
      } else {
        products.value = [...products.value, ...res.records]
      }
      
      // Check if finished
      if (products.value.length >= res.total) {
        finished.value = true
      } else {
        page.value++
      }
    } else {
      finished.value = true
    }
  } catch (error) {
    console.error('Failed to load products', error)
    finished.value = true
  } finally {
    loading.value = false
  }
}

const addToCart = (product) => {
  cartStore.addItem({
    productId: product.id,
    productName: product.name,
    productPrice: Number(product.price),
    quantity: 1,
    productImage: product.mainImage
  })
  showToast('已加入购物车')
}
</script>

<style scoped>
.category-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: #fff;
}
.container {
  flex: 1;
  display: flex;
  overflow: hidden;
  padding-bottom: 50px; /* Tabbar height */
}
.sidebar {
  width: 90px;
  background: #f7f8fa;
  overflow-y: auto;
}
.sidebar-item {
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  color: #666;
  position: relative;
  transition: all 0.3s;
}
.sidebar-item.active {
  background: #fff;
  color: #333;
  font-weight: 600;
}
.indicator {
  position: absolute;
  left: 0;
  top: 15px;
  bottom: 15px;
  width: 4px;
  background: #1989fa;
  border-radius: 0 4px 4px 0;
}

.content {
  flex: 1;
  overflow-y: auto;
  padding: 10px;
  background: #fff;
}
.banner-wrapper {
  position: relative;
  height: 100px;
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 16px;
}
.cat-banner {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.banner-text {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.3);
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding-left: 16px;
  color: #fff;
}
.banner-text h3 {
  margin: 0 0 4px 0;
  font-size: 18px;
  font-weight: 600;
}
.banner-text p {
  margin: 0;
  font-size: 12px;
  opacity: 0.9;
}

.product-item {
  display: flex;
  gap: 12px;
  margin-bottom: 16px;
}
.prod-img {
  width: 88px;
  height: 88px;
  border-radius: 8px;
  object-fit: cover;
  background: #f7f8fa;
}
.prod-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 2px 0;
}
.prod-name {
  margin: 0;
  font-size: 15px;
  color: #333;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.tags {
  display: flex;
  gap: 4px;
}
.prod-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.price {
  color: #ee0a24;
  font-size: 16px;
  font-weight: 600;
}
</style>

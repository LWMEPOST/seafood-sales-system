<template>
  <div class="home">
    <van-nav-bar title="鲜到家" fixed placeholder :border="false" />
    
    <!-- Banner -->
    <van-swipe :autoplay="3000" indicator-color="white" class="banner">
      <van-swipe-item v-for="(image, index) in banners" :key="index">
        <img :src="image" class="banner-img" />
      </van-swipe-item>
    </van-swipe>

    <!-- Categories -->
    <van-grid :column-num="4" :border="false" class="categories">
      <van-grid-item 
        v-for="cat in categories" 
        :key="cat.id" 
        :icon="cat.icon" 
        :text="cat.name" 
        @click="goToCategory(cat.id)"
      />
    </van-grid>

    <!-- Product Waterfall -->
    <div class="product-section">
      <div class="section-header">
        <h3>今日鲜选</h3>
        <span class="subtitle">Fresh Daily</span>
      </div>
      
      <div class="waterfall">
        <div class="product-card" v-for="product in products" :key="product.id" @click="goToDetail(product.id)">
          <div class="card-img-wrapper">
            <img :src="product.mainImage || 'https://img.yzcdn.cn/vant/apple-1.jpg'" class="card-img" />
            <div class="card-tags-overlay">
              <span class="tag-origin"><van-icon name="location-o" /> {{ product.origin }}</span>
            </div>
          </div>
          <div class="card-info">
            <h4 class="card-name">{{ product.name }}</h4>
            <div class="card-meta">
              <span class="price">¥{{ product.price }}</span>
              <span class="catch-date" v-if="product.catchDate">{{ product.catchDate }}捕捞</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getProductPage, getCategoryList } from '@/api/product'

const router = useRouter()
const banners = ref([
  'https://img.yzcdn.cn/vant/apple-1.jpg',
  'https://img.yzcdn.cn/vant/apple-2.jpg'
])
const categories = ref([])
const products = ref([])

onMounted(async () => {
  try {
    // Load categories
    const catRes = await getCategoryList()
    categories.value = catRes || []

    // Load products
    const res = await getProductPage({ page: 1, size: 20 })
    products.value = res.records
    
    // Set banners from top products
    if (res.records && res.records.length > 0) {
      banners.value = res.records
        .slice(0, 5)
        .map(p => p.mainImage)
        .filter(img => img)
    }
  } catch (error) {
    console.error('Failed to load data', error)
  }
})

const goToCategory = (id) => {
  router.push(`/category?id=${id}`)
}

const goToDetail = (id) => {
  router.push(`/detail/${id}`)
}
</script>

<style scoped>
.home {
  padding-bottom: 20px;
}
.banner {
  height: 240px; /* Taller banner for high quality feel */
  margin-bottom: 10px;
}
.banner-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.categories {
  margin: 10px 16px;
  background: #fff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.02);
}
.product-section {
  padding: 0 16px;
}
.section-header {
  display: flex;
  align-items: baseline;
  margin-bottom: 12px;
  padding-top: 10px;
}
.section-header h3 {
  margin: 0;
  font-size: 20px;
  color: #1a2a3a;
  font-weight: 600;
}
.subtitle {
  margin-left: 8px;
  font-size: 12px;
  color: #969799;
  font-family: 'Times New Roman', serif;
  font-style: italic;
}
.waterfall {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.product-card {
  width: 48%;
  background: #fff;
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 16px;
  box-shadow: 0 4px 16px rgba(0,0,0,0.04);
  transition: transform 0.2s;
}
.product-card:active {
  transform: scale(0.98);
}
.card-img-wrapper {
  position: relative;
  height: 200px; /* Taller images */
}
.card-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.card-tags-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 8px;
  background: linear-gradient(to top, rgba(0,0,0,0.4), transparent);
  display: flex;
  gap: 4px;
}
.tag-origin {
  color: #fff;
  font-size: 10px;
  display: flex;
  align-items: center;
  gap: 2px;
  text-shadow: 0 1px 2px rgba(0,0,0,0.3);
}
.card-info {
  padding: 12px;
}
.card-name {
  margin: 0 0 8px 0;
  font-size: 15px;
  color: #323233;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: 500;
}
.card-meta {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
}
.price {
  color: #323233;
  font-weight: 600;
  font-size: 16px;
}
.catch-date {
  color: #969799;
  font-size: 10px;
  background: #f0f2f5;
  padding: 2px 6px;
  border-radius: 4px;
}
</style>

import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Detail from '../views/Detail.vue'
import Category from '../views/Category.vue'
import Cart from '../views/Cart.vue'
import User from '../views/User.vue'
import OrderList from '../views/OrderList.vue'
import OrderDetail from '../views/OrderDetail.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import Address from '../views/Address.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/detail/:id', component: Detail },
  { path: '/category', component: Category }, 
  { 
    path: '/cart', 
    component: Cart,
    meta: { requiresAuth: true }
  },
  { 
    path: '/user', 
    component: User,
    meta: { requiresAuth: true }
  },
  { 
    path: '/orders', 
    component: OrderList,
    meta: { requiresAuth: true }
  },
  { 
    path: '/order/:id', 
    component: OrderDetail,
    meta: { requiresAuth: true }
  },
  { path: '/login', component: Login },
  { path: '/register', component: Register },
  { 
    path: '/address', 
    component: Address,
    meta: { requiresAuth: true }
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  if (to.meta.requiresAuth && !token) {
    next('/login')
  } else {
    next()
  }
})

export default router

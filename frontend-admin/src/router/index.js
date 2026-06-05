import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '../views/Dashboard.vue'
import Product from '../views/Product.vue'
import Order from '../views/Order.vue'
import Login from '../views/Login.vue'

const routes = [
  { path: '/login', component: Login },
  {
    path: '/',
    component: () => import('../layout/Layout.vue'),
    children: [
      { path: '', component: Dashboard },
      { path: 'product', component: Product },
      { path: 'order', component: Order },
      { path: 'recipe', component: () => import('../views/Recipe.vue') },
      { path: 'user', component: () => import('../views/User.vue') }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  if (to.path === '/login') {
    if (token) {
      next('/')
    } else {
      next()
    }
    return
  }
  if (!token) {
    next('/login')
    return
  }
  next()
})

export default router

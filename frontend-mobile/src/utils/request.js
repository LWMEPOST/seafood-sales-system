import axios from 'axios'
import { showToast } from 'vant'
import router from '@/router'

const service = axios.create({
  baseURL: '/api',
  timeout: 5000
})

service.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = token
    }
    return config
  },
  error => Promise.reject(error)
)

service.interceptors.response.use(
  response => {
    const res = response.data
    if (res.code === 401) {
      localStorage.removeItem('token')
      localStorage.removeItem('userInfo')
      showToast('Login expired or unauthorized')
      router.push('/login')
      return Promise.reject(new Error('Unauthorized'))
    }
    if (res.code !== 200) {
      showToast(res.message || 'Error')
      return Promise.reject(new Error(res.message || 'Error'))
    } else {
      return res.data
    }
  },
  error => {
    if (error.response && error.response.status === 401) {
      localStorage.removeItem('token')
      localStorage.removeItem('userInfo')
      showToast('Login expired or unauthorized')
      router.push('/login')
    } else {
      showToast(error.message)
    }
    return Promise.reject(error)
  }
)

export default service

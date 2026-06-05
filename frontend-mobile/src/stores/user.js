import { defineStore } from 'pinia'
import { login, register, getUserInfo } from '@/api/user'
import { getCurrentAddress, saveAddress as saveAddressApi } from '@/api/address'

export const useUserStore = defineStore('user', {
  state: () => ({
    token: localStorage.getItem('token') || '',
    userInfo: localStorage.getItem('userInfo')
      ? JSON.parse(localStorage.getItem('userInfo'))
      : null,
    address: { name: '', phone: '', detail: '' }
  }),
  getters: {
    isLoggedIn: state => !!state.token,
    userId: state => (state.userInfo ? state.userInfo.id : null),
    hasAddress: state => !!(state.address.name && state.address.phone && state.address.detail)
  },
  actions: {
    async fetchAddress() {
      if (!this.userId) return
      try {
        const res = await getCurrentAddress(this.userId)
        if (res) {
          this.address = res
        }
      } catch (error) {
        console.error('Failed to fetch address', error)
      }
    },
    async saveAddress(addr) {
      this.address = addr
      if (this.userId) {
        addr.userId = this.userId
        await saveAddressApi(addr)
      }
    },
    async loginUser(payload) {
      const res = await login(payload)
      this.token = res.token
      this.userInfo = res.userInfo
      localStorage.setItem('token', res.token)
      localStorage.setItem('userInfo', JSON.stringify(res.userInfo || {}))
      // Fetch address after login
      this.fetchAddress()
      return res
    },
    async registerUser(payload) {
      const res = await register(payload)
      return res
    },
    async fetchUserInfo() {
      if (!this.token) return null
      const res = await getUserInfo(this.token)
      this.userInfo = res
      localStorage.setItem('userInfo', JSON.stringify(res || {}))
      // Fetch address when refreshing user info
      this.fetchAddress()
      return res
    },
    logout() {
      this.token = ''
      this.userInfo = null
      this.address = { name: '', phone: '', detail: '' }
      localStorage.removeItem('token')
      localStorage.removeItem('userInfo')
    }
  }
})

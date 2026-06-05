import { defineStore } from 'pinia'

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: [],
    receiverName: '',
    receiverPhone: '',
    receiverAddress: ''
  }),
  getters: {
    totalCount: state => state.items.reduce((sum, item) => sum + item.quantity, 0),
    totalPrice: state => state.items.reduce((sum, item) => sum + item.productPrice * item.quantity, 0)
  },
  actions: {
    addItem(item) {
      const existing = this.items.find(i => i.productId === item.productId)
      if (existing) {
        existing.quantity += item.quantity
      } else {
        this.items.push({ ...item })
      }
    },
    updateQuantity(productId, quantity) {
      const target = this.items.find(i => i.productId === productId)
      if (!target) return
      if (quantity <= 0) {
        this.items = this.items.filter(i => i.productId !== productId)
      } else {
        target.quantity = quantity
      }
    },
    removeItem(productId) {
      this.items = this.items.filter(i => i.productId !== productId)
    },
    updateAddress(payload) {
      this.receiverName = payload.receiverName
      this.receiverPhone = payload.receiverPhone
      this.receiverAddress = payload.receiverAddress
    },
    clear() {
      this.items = []
      this.receiverName = ''
      this.receiverPhone = ''
      this.receiverAddress = ''
    }
  }
})

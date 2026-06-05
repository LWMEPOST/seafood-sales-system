<template>
  <div class="address-page">
    <van-nav-bar
      title="收货地址"
      left-arrow
      @click-left="router.back()"
      fixed
      placeholder
    />

    <van-form @submit="onSave">
      <van-cell-group inset>
        <van-field
          v-model="form.name"
          name="name"
          label="收货人"
          placeholder="收货人姓名"
          :rules="[{ required: true, message: '请填写收货人姓名' }]"
        />
        <van-field
          v-model="form.phone"
          name="phone"
          label="手机号"
          placeholder="收货人手机号"
          :rules="[{ required: true, message: '请填写手机号' }]"
        />
        <van-field
          v-model="form.detail"
          name="detail"
          label="详细地址"
          placeholder="街道门牌、楼层房间号等信息"
          :rules="[{ required: true, message: '请填写详细地址' }]"
        />
      </van-cell-group>
      <div style="margin: 16px;">
        <van-button round block type="primary" native-type="submit">
          保存
        </van-button>
      </div>
    </van-form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { showToast } from 'vant'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()

const form = ref({
  name: '',
  phone: '',
  detail: ''
})

onMounted(() => {
  if (userStore.address) {
    form.value = { ...userStore.address }
  }
})

const onSave = async (values) => {
  await userStore.saveAddress(values)
  showToast('保存成功')
  router.back()
}
</script>

<style scoped>
.address-page {
  min-height: 100vh;
  background: #f7f8fa;
  padding-top: 20px;
}
</style>

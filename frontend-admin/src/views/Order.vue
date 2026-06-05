<template>
  <div class="order-page">
    <div class="glass-card">
      <el-table :data="tableData" style="width: 100%">
        <el-table-column prop="orderSn" label="订单号" width="180" />
        <el-table-column prop="totalAmount" label="金额" />
        <el-table-column prop="status" label="状态">
          <template #default="scope">
             <el-tag :type="getStatusType(scope.row.status)">{{ getStatusText(scope.row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button v-if="scope.row.status === 1" size="small" type="primary" @click="handleShip(scope.row)">发货</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import request from '@/utils/request'

const tableData = ref([])

const loadOrders = async () => {
  const res = await request({
    url: '/order/list',
    method: 'get'
  })
  tableData.value = res || []
}

onMounted(() => {
  loadOrders()
})

const getStatusText = (status) => {
  const map = { 0: '待支付', 1: '待发货', 2: '已发货', 3: '已完成' }
  return map[status] || '未知'
}

const getStatusType = (status) => {
  const map = { 0: 'warning', 1: 'primary', 2: 'info', 3: 'success' }
  return map[status] || ''
}

const handleShip = async (row) => {
  await request({
    url: `/order/ship/${row.id}`,
    method: 'post'
  })
  ElMessage.success('发货成功')
  loadOrders()
}
</script>

<style scoped>
.order-page { padding: 20px; }
.glass-card { background: #fff; padding: 20px; border-radius: 8px; }
</style>

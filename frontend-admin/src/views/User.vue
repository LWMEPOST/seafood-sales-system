<template>
  <div class="user-page">
    <div class="glass-card">
      <div class="toolbar">
        <el-input
          v-model="searchQuery"
          placeholder="搜索用户名"
          style="width: 200px; margin-right: 10px"
          clearable
          @clear="loadData"
          @keyup.enter="loadData"
        />
        <el-button type="primary" @click="loadData">搜索</el-button>
      </div>

      <el-table :data="tableData" style="width: 100%">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="username" label="用户名" />
        <el-table-column prop="nickname" label="昵称" />
        <el-table-column prop="role" label="角色">
          <template #default="scope">
            <el-tag :type="scope.row.role === 'ADMIN' ? 'danger' : 'success'">{{ scope.row.role }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="注册时间" />
      </el-table>

      <el-pagination
        background
        layout="prev, pager, next"
        :total="total"
        :page-size="10"
        @current-change="handlePageChange"
        class="pagination"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getUserPage } from '@/api/user'

const tableData = ref([])
const total = ref(0)
const currentPage = ref(1)
const searchQuery = ref('')

const loadData = async () => {
  const res = await getUserPage({
    page: currentPage.value,
    size: 10,
    username: searchQuery.value
  })
  tableData.value = res.records
  total.value = res.total
}

onMounted(() => {
  loadData()
})

const handlePageChange = (page) => {
  currentPage.value = page
  loadData()
}
</script>

<style scoped>
.user-page {
  padding: 20px;
}
.glass-card {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
}
.toolbar {
  margin-bottom: 20px;
}
.pagination {
  margin-top: 20px;
  justify-content: center;
}
</style>

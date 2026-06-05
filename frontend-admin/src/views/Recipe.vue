<template>
  <div class="recipe-page">
    <div class="glass-card">
      <div class="toolbar">
        <el-input
          v-model="searchQuery"
          placeholder="搜索食谱标题"
          style="width: 200px; margin-right: 10px"
          clearable
          @clear="loadData"
          @keyup.enter="loadData"
        />
        <el-button type="primary" @click="loadData">搜索</el-button>
        <el-button type="success" @click="handleAdd">新增食谱</el-button>
      </div>

      <el-table :data="tableData" style="width: 100%">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="image" label="图片" width="100">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px" :src="scope.row.image" fit="cover" />
          </template>
        </el-table-column>
        <el-table-column prop="title" label="标题" />
        <el-table-column prop="productId" label="关联商品ID" width="120" />
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button size="small" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
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

    <!-- Dialog -->
    <el-dialog v-model="dialogVisible" :title="form.id ? '编辑食谱' : '新增食谱'">
      <el-form :model="form" label-width="100px">
        <el-form-item label="食谱标题">
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="关联商品">
          <el-select v-model="form.productId" placeholder="请选择关联商品" filterable>
             <el-option
              v-for="item in productList"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="食谱图片">
          <el-upload
            class="avatar-uploader"
            action="/api/common/upload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
          >
            <img v-if="form.image" :src="form.image" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>
        <el-form-item label="制作内容">
          <el-input v-model="form.content" type="textarea" :rows="6" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getRecipePage, saveRecipe, updateRecipe, removeRecipe, getProductList } from '@/api/recipe'
import { Plus } from '@element-plus/icons-vue'

const tableData = ref([])
const total = ref(0)
const currentPage = ref(1)
const searchQuery = ref('')
const dialogVisible = ref(false)
const form = ref({})
const productList = ref([])

const loadData = async () => {
  const res = await getRecipePage({
    page: currentPage.value,
    size: 10,
    title: searchQuery.value
  })
  tableData.value = res.records
  total.value = res.total
}

const loadProducts = async () => {
    const res = await getProductList()
    productList.value = res.records
}

onMounted(() => {
  loadData()
  loadProducts()
})

const handlePageChange = (page) => {
  currentPage.value = page
  loadData()
}

const handleAdd = () => {
  form.value = {}
  dialogVisible.value = true
}

const handleEdit = (row) => {
  form.value = { ...row }
  dialogVisible.value = true
}

const handleDelete = (row) => {
  ElMessageBox.confirm('确认删除该食谱吗?', '提示', { type: 'warning' })
    .then(async () => {
      await removeRecipe(row.id)
      ElMessage.success('删除成功')
      loadData()
    })
}

const handleAvatarSuccess = (res) => {
  if (res.code === 200) {
    form.value.image = res.data
  } else {
    ElMessage.error(res.message)
  }
}

const handleSubmit = async () => {
  if (!form.value.title || !form.value.content) {
    ElMessage.warning('请完善信息')
    return
  }
  if (form.value.id) {
    await updateRecipe(form.value)
    ElMessage.success('更新成功')
  } else {
    await saveRecipe(form.value)
    ElMessage.success('创建成功')
  }
  dialogVisible.value = false
  loadData()
}
</script>

<style scoped>
.recipe-page {
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
.avatar-uploader .avatar {
  width: 178px;
  height: 178px;
  display: block;
}
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}
.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  text-align: center;
}
</style>

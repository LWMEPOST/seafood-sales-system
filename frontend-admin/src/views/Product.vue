<template>
  <div class="product-page">
    <div class="glass-card">
      <div class="toolbar">
        <el-select v-model="searchCategory" placeholder="分类" clearable style="width: 120px; margin-right: 10px" @change="loadData">
          <el-option label="鱼类" :value="1" />
          <el-option label="虾类" :value="2" />
          <el-option label="蟹类" :value="3" />
          <el-option label="贝类" :value="4" />
        </el-select>
        <el-input
          v-model="searchOrigin"
          placeholder="产地"
          style="width: 150px; margin-right: 10px"
          clearable
          @clear="loadData"
          @keyup.enter="loadData"
        />
        <el-button type="primary" @click="loadData">搜索</el-button>
        <el-button type="primary" @click="handleAdd">新增商品</el-button>
        <el-upload
          action="/api/product/import"
          :show-file-list="false"
          :on-success="handleImportSuccess"
          style="display: inline-block; margin: 0 10px;"
        >
          <el-button type="success">表格导入</el-button>
        </el-upload>
        <el-button type="info" @click="handleDownloadTemplate">下载模板</el-button>
      </div>
      
      <el-table :data="tableData" style="width: 100%">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="mainImage" label="图片" width="100">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px" :src="scope.row.mainImage" fit="cover" />
          </template>
        </el-table-column>
        <el-table-column prop="name" label="名称" />
        <el-table-column prop="price" label="价格" />
        <el-table-column prop="stock" label="库存" />
        <el-table-column prop="origin" label="产地" />
        <el-table-column prop="farmingMethod" label="养殖方式" />
        <el-table-column label="操作" width="220">
          <template #default="scope">
            <el-button size="small" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="small" type="success" @click="handleTrace(scope.row)">溯源</el-button>
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
    <el-dialog v-model="dialogVisible" :title="form.id ? '编辑商品' : '新增商品'">
      <el-form :model="form" label-width="100px">
        <el-form-item label="商品名称">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="form.categoryId" placeholder="请选择分类">
            <el-option label="鱼类" :value="1" />
            <el-option label="虾类" :value="2" />
            <el-option label="蟹类" :value="3" />
            <el-option label="贝类" :value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="价格">
          <el-input-number v-model="form.price" :precision="2" :step="0.1" />
        </el-form-item>
        <el-form-item label="库存">
          <el-input-number v-model="form.stock" />
        </el-form-item>
        <el-form-item label="产地">
          <el-input v-model="form.origin" />
        </el-form-item>
        <el-form-item label="捕捞日期">
          <el-date-picker v-model="form.catchDate" type="date" value-format="YYYY-MM-DD" />
        </el-form-item>
        <el-form-item label="养殖方式">
          <el-select v-model="form.farmingMethod">
            <el-option label="野生捕捞" value="野生捕捞" />
            <el-option label="人工养殖" value="人工养殖" />
          </el-select>
        </el-form-item>
        <el-form-item label="商品图片">
          <el-upload
            class="avatar-uploader"
            action="/api/common/upload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
          >
            <img v-if="form.mainImage" :src="form.mainImage" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <el-dialog v-model="traceDialogVisible" title="溯源管理" width="800px">
      <div style="display: flex; gap: 20px;">
        <!-- Left: Trace List -->
        <div style="flex: 1; border-right: 1px solid #eee; padding-right: 20px;">
           <div style="margin-bottom: 10px; font-weight: bold;">现有溯源节点</div>
           <el-timeline v-if="traceList.length > 0">
             <el-timeline-item
               v-for="(activity, index) in traceList"
               :key="index"
               :timestamp="activity.nodeTime"
               placement="top"
             >
               <el-card shadow="hover" @click="handleEditTrace(activity)" style="cursor: pointer">
                 <h4>{{ activity.nodeName }}</h4>
                 <p>{{ activity.operator }} @ {{ activity.location }}</p>
               </el-card>
             </el-timeline-item>
           </el-timeline>
           <el-empty v-else description="暂无溯源信息" />
           <el-button type="primary" style="width: 100%; margin-top: 10px" @click="handleNewTrace">新增节点</el-button>
        </div>

        <!-- Right: Edit Form -->
        <div style="flex: 1;">
          <div style="margin-bottom: 10px; font-weight: bold;">{{ traceForm.id ? '编辑节点' : '新增节点' }}</div>
          <el-form :model="traceForm" label-width="90px">
            <el-form-item label="节点名称">
              <el-select v-model="traceForm.nodeName" placeholder="请选择节点" style="width: 100%">
                <el-option label="捕捞" value="捕捞" />
                <el-option label="加工" value="加工" />
                <el-option label="运输" value="运输" />
                <el-option label="入库" value="入库" />
                <el-option label="上架" value="上架" />
              </el-select>
            </el-form-item>
            <el-form-item label="节点时间">
              <el-date-picker
                v-model="traceForm.nodeTime"
                type="datetime"
                value-format="YYYY-MM-DD HH:mm:ss"
                style="width: 100%"
              />
            </el-form-item>
            <el-form-item label="地点">
              <el-input v-model="traceForm.location" />
            </el-form-item>
            <el-form-item label="操作人">
              <el-input v-model="traceForm.operator" />
            </el-form-item>
            <el-form-item label="节点描述">
              <el-input v-model="traceForm.description" type="textarea" />
            </el-form-item>
            <el-form-item label="节点图片">
              <el-upload
                class="avatar-uploader"
                action="/api/common/upload"
                :show-file-list="false"
                :on-success="handleTraceImageSuccess"
              >
                <img v-if="traceForm.image" :src="traceForm.image" class="avatar" />
                <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
              </el-upload>
            </el-form-item>
            <el-form-item>
               <el-button type="primary" @click="handleTraceSubmit">保存</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getProductPage, saveProduct, updateProduct, removeProduct } from '@/api/product'
import { saveTraceRecord, updateTraceRecord, getTraceRecordList } from '@/api/trace'

const tableData = ref([])
const total = ref(0)
const currentPage = ref(1)
const searchCategory = ref('')
const searchOrigin = ref('')
const dialogVisible = ref(false)
const traceDialogVisible = ref(false)
const form = ref({})
const traceForm = ref({})
const traceList = ref([]) // To store trace records for editing
const currentProductId = ref(null)

const loadData = async () => {
  const res = await getProductPage({
    page: currentPage.value,
    size: 10,
    categoryId: searchCategory.value || undefined,
    origin: searchOrigin.value || undefined
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

const handleAdd = () => {
  form.value = { categoryId: 1, status: 1 } // Default values
  dialogVisible.value = true
}

const handleEdit = (row) => {
  form.value = { ...row }
  dialogVisible.value = true
}

const handleTrace = async (row) => {
  traceDialogVisible.value = true
  currentProductId.value = row.id
  const res = await getTraceRecordList(row.id)
  traceList.value = res || []
  handleNewTrace()
}

const handleNewTrace = () => {
  traceForm.value = {
    productId: currentProductId.value,
    nodeName: '',
    nodeTime: '',
    location: '',
    operator: '',
    description: '',
    image: ''
  }
}

const handleEditTrace = (record) => {
  traceForm.value = { ...record }
}

const handleDownloadTemplate = () => {
  const headers = ['商品名称', '分类ID(1:鱼类 2:虾类 3:蟹类 4:贝类)', '价格', '库存', '产地', '养殖方式', '商品描述']
  const example = ['深海大黄鱼', '1', '128.00', '1000', '浙江舟山', '野生捕捞', '肉质鲜美']
  const content = ['\uFEFF' + headers.join(','), example.join(',')].join('\n')
  
  const blob = new Blob([content], { type: 'text/csv;charset=utf-8;' })
  const link = document.createElement('a')
  const url = URL.createObjectURL(blob)
  link.setAttribute('href', url)
  link.setAttribute('download', '商品导入模板.csv')
  link.style.visibility = 'hidden'
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
}

const handleDelete = (row) => {
  ElMessageBox.confirm('确认删除该商品吗?', '提示', { type: 'warning' })
    .then(async () => {
      await removeProduct(row.id)
      ElMessage.success('删除成功')
      loadData()
    })
}

const handleSubmit = async () => {
  if (form.value.id) {
    await updateProduct(form.value)
  } else {
    await saveProduct(form.value)
  }
  ElMessage.success('保存成功')
  dialogVisible.value = false
  loadData()
}

const handleAvatarSuccess = (response) => {
  if (response.code === 200) {
    form.value.mainImage = response.data
  } else {
    ElMessage.error(response.message)
  }
}

const handleImportSuccess = (response) => {
  if (response.code === 200) {
    ElMessage.success('导入成功')
    loadData()
  } else {
    ElMessage.error(response.message)
  }
}

const handleTraceImageSuccess = (response) => {
  if (response.code === 200) {
    traceForm.value.image = response.data
  } else {
    ElMessage.error(response.message)
  }
}

const handleTraceSubmit = async () => {
  if (!traceForm.value.productId || !traceForm.value.nodeName || !traceForm.value.nodeTime) {
    ElMessage.warning('请填写必填信息')
    return
  }
  if (traceForm.value.id) {
    await updateTraceRecord(traceForm.value)
    ElMessage.success('溯源节点已更新')
  } else {
    await saveTraceRecord(traceForm.value)
    ElMessage.success('溯源节点已新增')
  }
  // Refresh list
  const res = await getTraceRecordList(currentProductId.value)
  traceList.value = res || []
  handleNewTrace()
}
</script>

<style scoped>
.product-page {
  padding: 20px;
}
.glass-card {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
}
.toolbar {
  margin-bottom: 20px;
  display: flex;
  gap: 10px;
  align-items: center;
}
.pagination {
  margin-top: 20px;
  justify-content: flex-end;
}
.avatar-uploader .avatar {
  width: 100px;
  height: 100px;
  display: block;
}
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
  line-height: 100px;
}
</style>

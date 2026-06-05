<template>
  <div class="dashboard">
    <!-- Top Cards -->
    <div class="card-row">
      <div class="glass-card">
        <div class="card-title">今日销售额</div>
        <div class="card-value">¥ {{ stats.todaySales }}</div>
        <div class="card-trend up">同比 +12% <el-icon><Top /></el-icon></div>
      </div>
      <div class="glass-card">
        <div class="card-title">今日订单量</div>
        <div class="card-value">{{ stats.todayOrders }}</div>
        <div class="card-trend">昨日 140</div>
      </div>
      <div class="glass-card alert">
        <div class="card-title">库存预警</div>
        <div class="card-value">{{ stats.stockAlertCount }}</div>
        <div class="card-trend down">急需补货</div>
      </div>
      <div class="glass-card warning">
        <div class="card-title">待发货订单</div>
        <div class="card-value">{{ stats.toShipCount }}</div>
        <div class="card-trend">请及时处理</div>
      </div>
    </div>

    <!-- Todo List & Shortcuts -->
    <div class="todo-row">
      <el-card class="box-card todo-card">
        <template #header>
          <div class="card-header">
            <span>待办事项</span>
          </div>
        </template>
        <div class="text item">
          <el-badge :value="stats.toShipCount" class="item-badge" type="warning">
            <el-button @click="$router.push('/order')">待发货订单</el-button>
          </el-badge>
        </div>
        <div class="text item">
          <el-badge :value="stats.stockAlertCount" class="item-badge" type="danger">
            <el-button @click="$router.push('/product')">库存预警商品</el-button>
          </el-badge>
        </div>
        <div class="text item">
           <el-badge :value="stats.pendingPaymentCount" class="item-badge" type="info">
            <el-button @click="$router.push('/order')">待支付订单</el-button>
          </el-badge>
        </div>
      </el-card>
    </div>

    <!-- Middle Charts -->
    <div class="chart-row">
      <div class="glass-card chart-card">
        <h3>实时库存热力图</h3>
        <div ref="heatmapRef" class="chart-container"></div>
      </div>
      <div class="glass-card chart-card">
        <h3>近7天销售趋势</h3>
        <div ref="lineChartRef" class="chart-container"></div>
      </div>
    </div>

    <!-- Bottom Table -->
    <div class="glass-card table-card">
      <h3>最新订单</h3>
      <el-table :data="tableData" style="width: 100%" :row-class-name="tableRowClassName">
        <el-table-column prop="date" label="时间" width="180" />
        <el-table-column prop="name" label="商品" width="180" />
        <el-table-column prop="amount" label="金额" />
        <el-table-column prop="status" label="状态">
          <template #default="scope">
            <el-tag :type="scope.row.status === '已完成' ? 'success' : 'warning'">{{ scope.row.status }}</el-tag>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import * as echarts from 'echarts'
import { getStats } from '@/api/dashboard'
import { getRegionStockList } from '@/api/region-stock'

const heatmapRef = ref(null)
const lineChartRef = ref(null)
const stats = ref({
  todaySales: 0,
  todayOrders: 0,
  stockAlertCount: 0,
  activeUsers: 0
})
const tableData = ref([
  { date: '2023-10-26 10:00', name: '深海大黄鱼', amount: '¥128', status: '已支付' },
  { date: '2023-10-26 09:30', name: '波士顿龙虾', amount: '¥298', status: '已完成' },
])

onMounted(async () => {
  const data = await getStats()
  stats.value = data
  
  const regionData = await getRegionStockList()
  initHeatmap(regionData)
  
  initLineChart(data.salesTrend)
})

const initHeatmap = (regionData) => {
  if (!regionData) return
  
  const chart = echarts.init(heatmapRef.value)
  const regions = regionData.map(item => item.regionName)
  const yData = ['库存量']
  const data = regionData.map((item, index) => [index, 0, item.stockCount])
  
  chart.setOption({
    tooltip: { position: 'top' },
    grid: { height: '50%', top: '10%' },
    xAxis: { 
      type: 'category', 
      data: regions, 
      splitArea: { show: true },
      axisLabel: {
        interval: 0,
        rotate: 30,
        formatter: function (value) {
          const shortNames = {
            '广西壮族自治区': '广西',
            '内蒙古自治区': '内蒙古',
            '新疆维吾尔自治区': '新疆',
            '宁夏回族自治区': '宁夏',
            '西藏自治区': '西藏',
            '香港特别行政区': '香港',
            '澳门特别行政区': '澳门'
          };
          if (shortNames[value]) return shortNames[value];
          return value.replace(/[省市]$/, '');
        }
      }
    },
    yAxis: { type: 'category', data: yData, splitArea: { show: true } },
    visualMap: {
      min: 0,
      max: 5000,
      calculable: true,
      orient: 'horizontal',
      left: 'center',
      bottom: '15%'
    },
    series: [{
      name: '库存',
      type: 'heatmap',
      data: data,
      label: { show: true },
      emphasis: { itemStyle: { shadowBlur: 10, shadowColor: 'rgba(0, 0, 0, 0.5)' } }
    }]
  })
}

const initLineChart = (trendData) => {
  if (!trendData) return

  const chart = echarts.init(lineChartRef.value)
  const dates = trendData.map(item => item.date)
  const values = trendData.map(item => item.value)

  chart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: { type: 'category', data: dates },
    yAxis: { type: 'value' },
    series: [{
      data: values,
      type: 'line',
      smooth: true,
      areaStyle: {
        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: 'rgba(58,77,233,0.8)' },
          { offset: 1, color: 'rgba(58,77,233,0.1)' }
        ])
      },
      itemStyle: { color: '#3a4de9' }
    }]
  })
}

const tableRowClassName = () => {
  return ''
}
</script>

<style scoped>
.dashboard {
  background: linear-gradient(135deg, #0f2027, #203a43, #2c5364); /* Deep Sea Theme */
  min-height: 100vh;
  padding: 20px;
  color: #fff;
}
.card-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}
.glass-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  padding: 20px;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
  flex: 1;
  margin: 0 10px;
}
.glass-card:first-child { margin-left: 0; }
.glass-card:last-child { margin-right: 0; }

.card-title { font-size: 14px; opacity: 0.8; }
.card-value { font-size: 28px; font-weight: bold; margin: 10px 0; }
.card-trend { font-size: 12px; display: flex; align-items: center; }
.card-trend.up { color: #67c23a; }
.card-trend.down { color: #f56c6c; }
.alert .card-value { color: #f56c6c; }
.warning .card-value { color: #e6a23c; }

.todo-row {
  margin-bottom: 20px;
}
.todo-card {
  background: rgba(255, 255, 255, 0.1) !important;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  color: #fff;
}
.todo-card :deep(.el-card__header) {
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}
.todo-card .item {
  display: inline-block;
  margin-right: 20px;
}
.item-badge {
  margin-right: 10px;
}

.chart-row {
  display: flex;
  height: 400px;
  margin-bottom: 20px;
}
.chart-card {
  flex: 1;
  display: flex;
  flex-direction: column;
}
.chart-container {
  flex: 1;
  width: 100%;
}
.table-card {
  color: #333; /* Reset text color for table */
}
</style>

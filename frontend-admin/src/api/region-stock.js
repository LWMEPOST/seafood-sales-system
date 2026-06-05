import request from '@/utils/request'

export function getRegionStockList() {
  return request({
    url: '/region-stock/list',
    method: 'get'
  })
}

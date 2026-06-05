import request from '@/utils/request'

export function getCategoryList() {
  return request({
    url: '/category/list',
    method: 'get'
  })
}

export function getProductPage(params) {
  return request({
    url: '/product/page',
    method: 'get',
    params
  })
}

export function getProductDetail(id) {
  return request({
    url: `/product/${id}`,
    method: 'get'
  })
}

export function getTraceRecords(productId) {
  return request({
    url: `/trace/list/${productId}`,
    method: 'get'
  })
}

export function getRecipeByProductId(productId) {
  return request({
    url: `/recipe/product/${productId}`,
    method: 'get'
  })
}

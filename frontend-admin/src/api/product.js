import request from '@/utils/request'

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

export function saveProduct(data) {
  return request({
    url: '/product',
    method: 'post',
    data
  })
}

export function updateProduct(data) {
  return request({
    url: '/product',
    method: 'put',
    data
  })
}

export function removeProduct(id) {
  return request({
    url: `/product/${id}`,
    method: 'delete'
  })
}

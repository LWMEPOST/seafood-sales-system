import request from '@/utils/request'

export function createOrder(payload) {
  return request({
    url: '/order/create',
    method: 'post',
    data: payload
  })
}

export function payOrder(orderId) {
  return request({
    url: `/order/pay/${orderId}`,
    method: 'post'
  })
}

export function getOrderList(userId) {
  return request({
    url: `/order/list`, // Note: Backend might not have this yet, checking later
    method: 'get',
    params: { userId }
  })
}

export function getOrderDetail(id) {
  return request({
    url: `/order/${id}`,
    method: 'get'
  })
}

export function confirmReceive(id) {
  return request({
    url: `/order/receive/${id}`,
    method: 'post'
  })
}

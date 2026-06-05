import request from '@/utils/request'

export function getCurrentAddress(userId) {
  return request({
    url: '/address/current',
    method: 'get',
    params: { userId }
  })
}

export function saveAddress(data) {
  return request({
    url: '/address',
    method: 'post',
    data
  })
}

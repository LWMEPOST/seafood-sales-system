import request from '@/utils/request'

export function login(data) {
  return request({
    url: '/user/login',
    method: 'post',
    data
  })
}

export function getUserPage(params) {
  return request({
    url: '/user/page',
    method: 'get',
    params
  })
}

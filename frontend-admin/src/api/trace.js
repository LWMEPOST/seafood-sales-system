import request from '@/utils/request'

export function saveTraceRecord(data) {
  return request({
    url: '/trace',
    method: 'post',
    data
  })
}

export function updateTraceRecord(data) {
  return request({
    url: '/trace',
    method: 'put',
    data
  })
}

export function getTraceRecordList(productId) {
  return request({
    url: `/trace/list/${productId}`,
    method: 'get'
  })
}

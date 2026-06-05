import request from '@/utils/request'

export function getRecipePage(params) {
  return request({
    url: '/recipe/page',
    method: 'get',
    params
  })
}

export function getRecipe(id) {
  return request({
    url: `/recipe/${id}`,
    method: 'get'
  })
}

export function saveRecipe(data) {
  return request({
    url: '/recipe',
    method: 'post',
    data
  })
}

export function updateRecipe(data) {
  return request({
    url: '/recipe',
    method: 'put',
    data
  })
}

export function removeRecipe(id) {
  return request({
    url: `/recipe/${id}`,
    method: 'delete'
  })
}

export function getProductList() {
    return request({
        url: '/product/page', // Using page endpoint to populate dropdown if specific list endpoint doesn't exist
        method: 'get',
        params: { page: 1, size: 100 }
    })
}

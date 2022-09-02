import request from '@/utils/rest'

export function getVisit(visitID) {
  return request({
    url: 'visit/' + visitID.toString(),
    method: 'get'
  })
}


export function getListVisit() {
  return request({
    url: 'visit',
    method: 'get'
  })
}

export function postVisit(data) {
  return request({
    url: 'visit',
    method: 'post',
    data
  })
}

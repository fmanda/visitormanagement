// import axios from 'axios'
import request from '@/utils/rest'
import { getToken } from '@/utils/auth'

// const customRest = axios.create({
//   baseURL: process.env.VUE_APP_BASE_URL,
//   timeout: 5000 // request timeout
// })


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

export function postVisit(data, img1) {

  const formData = new FormData();
  formData.append('img1', img1)
  // formData.append('test', 'test')
  formData.append('data', JSON.stringify(data));

  for (var pair of formData.entries()) {
      console.log(pair[0]+ ', ' + pair[1]);
  }

  let token = getToken();

  // return customRest.request({
  //     url: 'visit',
  //     method: 'post',
  //     data: formData,
  //     headers: {
  //       'Authorization' : token,
  //       // 'content-type': 'multipart/form-data'
  //     }
  // })
  return request({
    url: 'visit',
    method: 'post',
    data : formData
  })
}

export function getVisitImage(id) {
  return request({
    url: 'visitimage/' + id.toString() ,
    method: 'get'
  })
}

export function getVisitImgURL(id) {
  if (!id) return null;
  return process.env.VUE_APP_IMG_URL + '/'+  id.toString();
}

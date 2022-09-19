// import axios from 'axios'
import request from '@/utils/rest'
// import { getToken } from '@/utils/auth'

// const customRest = axios.create({
//   baseURL: process.env.VUE_APP_BASE_URL,
//   timeout: 5000 // request timeout
// })

export function getAppointment(visitID) {
  return request({
    url: 'appointment/' + visitID.toString(),
    method: 'get'
  })
}

export function getListAppointment() {
  return request({
    url: 'appointment',
    method: 'get'
  })
}

export function getOngoingAppointment() {
  return request({
    url: 'ongoingappointment',
    method: 'get'
  })
}

export function postAppointment(data) {
  data.planningdate = formatDate(data.planningdate);
  return request({
    url: 'appointment',
    method: 'post',
    data
  })
}


export function searchAppointment(dt1, dt2, filtertxt) {
  let _url = 'searchappointment/' + formatDate(dt1) + '/' + formatDate(dt2);
  if (filtertxt && filtertxt != '') _url = _url  + '/' + filtertxt;

  return request({
    url: _url,
    method: 'get'
  })
}


export function deleteAppointment(id) {
  return request({
    url: 'deleteappointment/' + id.toString(),
    method: 'get'
  })
}


function formatDate(date) {
  var d = new Date(date);

  var dformat = [d.getFullYear(),
                (d.getMonth()+1).padLeft(),
                d.getDate().padLeft(),
                ].join('-') +' '
                +
                [d.getHours().padLeft(),
                d.getMinutes().padLeft(),
                d.getSeconds().padLeft()
                ].join(':');

  return dformat;
}


Number.prototype.padLeft = function(base,chr){
   var  len = (String(base || 10).length - String(this).length)+1;
   return len > 0? new Array(len).join(chr || '0')+this : this;
}

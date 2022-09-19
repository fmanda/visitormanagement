import request from '@/utils/rest'

export function getDepartment(deptid) {
  return request({
    url: 'department/' + deptid.toString(),
    method: 'get'
  })
}

export function getDeptHeader(deptid) {
  return request({
    url: 'departmentheader/' + deptid.toString(),
    method: 'get'
  })
}

export function getListDept() {
  return request({
    url: 'department',
    method: 'get'
  })
}

export function postDepartment(data) {
  return request({
    url: 'department',
    method: 'post',
    data
  })
}

export function getListEmployee(deptname, employeename) {
  return request({
    url: 'employee/' + deptname + '/' + employeename ,
    method: 'get'
  })
}

export function getAllEmployee(employeename) {
  var _url = 'allemployee';

  if (employeename && employeename != ''){
    _url = 'allemployee/' + employeename;
  }

  return request({
    url: _url ,
    method: 'get'
  })
}

import request from '@/utils/rest'


export function getVisitDashboardWeek(visitID) {
  return request({
    url: 'visitdashboardweek',
    method: 'get'
  })
}

export function getVisitDashboardMonth(visitID) {
  return request({
    url: 'visitdashboardmonth',
    method: 'get'
  })
}

export function getVisitDeptDashboard(visitID) {
  return request({
    url: 'visitdeptdashboard',
    method: 'get'
  })
}

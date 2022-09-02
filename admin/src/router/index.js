import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },

  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },

  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [{
      path: 'dashboard',
      name: 'Dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: { title: 'Dashboard', icon: 'dashboard' }
    }]
  },

  {
    path: '/master',
    component: Layout,
    name: 'Master',
    meta: { title: 'Master Data', icon: 'table' },
    children: [
      {
        path: 'department',
        name: 'Department',
        component: () => import('@/views/master/department/index'),
        meta: { title: 'Department', icon: 'link' }
      },

      {
        props: true,
        path: 'update_department',
        name: 'update_department',
        component: () => import('@/views/master/department/update'),
        meta: { title: 'Update Department', icon: 'link' },
        hidden: true
      },

      {
        path: 'users',
        name: 'Users',
        component: () => import('@/views/master/users'),
        meta: { title: 'Users', icon: 'user' }
      }
    ]
  },

  {
    path: '/register',
    // name: 'upload_p',
    component: Layout,
    children: [
      {
        path: 'register',
        name: 'register',
        component: () => import('@/views/register/index'),
        meta: { title: 'Register KPI', icon: 'password' }
      }
    ]
  },

  {
    path: '/upload',
    // name: 'upload_p',
    component: Layout,
    children: [
      {
        path: 'upload',
        name: 'upload',
        component: () => import('@/views/upload/index'),
        meta: { title: 'Upload Data', icon: 'link' }
      }
    ]
  },

  {
    path: '/preview',
    component: Layout,
    hidden: true,
    children: [
      {
        path: 'preview',
        name: 'preview',
        component: () => import('@/views/preview/index'),
        meta: { title: 'Preview Data', icon: 'eye-open' }
      }
    ]
  },

  {
    path: '/directory',
    component: Layout,
    children: [
      {
        path: 'directory',
        name: 'Directory',
        component: () => import('@/views/directory/index'),
        meta: { title: 'Directory', icon: 'nested' }
      }
    ]
  },
  {
    path: '/uploadlog',
    component: Layout,
    children: [
      {
        path: 'uploadlog',
        name: 'uploadlog',
        component: () => import('@/views/upload/log'),
        meta: { title: 'Log Upload', icon: 'example' }
      }
    ]
  },
  {
    path: '/assesment',
    component: Layout,
    children: [
      {
        path: 'assesment',
        name: 'assesment',
        component: () => import('@/views/assesment/index'),
        meta: { title: 'Assesment', icon: 'tree' }
      }
    ]
  },
  // 404 page must be placed at the end !!!
  { path: '*', redirect: '/404', hidden: true }
]

const scrollBehavior = (to, from, savedPosition) => {
  if (savedPosition) {
    return savedPosition;
  } else {
    return { x: 0, y: 0 }
  }
};

const createRouter = () => new Router({
  // mode: 'history', // require service support
  // scrollBehavior: () => ({ y: 0 }),
  scrollBehavior,
  routes: constantRoutes

})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router

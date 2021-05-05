import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue') // set home as path '/'
  },
  {
    path: '/manager',
    name: 'Manager',
    component: () => import('../views/Manager.vue') // set owner as path '/'
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('../views/Login.vue') // set owner as path '/'
  },
  {
    path: '/pointofsell',
    name: 'pointofsell',
    component: () => import('../views/Pos.vue') // set owner as path '/'
  },
  {
    path: '/ordermenu',
    name: 'ordermenu',
    component: () => import('../views/Ordermenu.vue') // set owner as path '/'
  },
  {
    path: '/signup',
    name: 'signup',
    component: () => import('../views/Signup.vue') // set owner as path '/'
  },
  {
    path: '/comment',
    name: 'comment',
    component: () => import('../views/Comment.vue') // set owner as path '/'
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
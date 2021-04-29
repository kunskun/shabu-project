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
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
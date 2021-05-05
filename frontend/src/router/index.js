import Vue from 'vue'
import VueRouter from 'vue-router'
import axios from 'axios'
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
    meta: { login: true },
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

router.beforeEach((to, from, next) => {
  const isLoggedIn = !!localStorage.getItem('token')
  const token = localStorage.getItem('token')

  if (to.meta.login && !isLoggedIn) {
    alert('Please login first!')
    next({ path: '/' })
  }

  if (to.meta.guess && isLoggedIn) {
    alert("You've already logged in")
    next({ path: '/'})
  }

  axios.get("http://localhost:3000/user/me", {
    headers: { Authorization: "Bearer " + token },
  })
  .then(res => {
    console.log(res.data)
    if(to.meta.login && res.data.role!='admin'){
      alert('admin only')
      next({ path: '/ordermenu' })

    }
  })


  

  next()
})

export default router
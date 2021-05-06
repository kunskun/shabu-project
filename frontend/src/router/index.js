import Vue from 'vue'
import VueRouter from 'vue-router'
import axios from 'axios'
import Carousel3d from 'vue-carousel-3d';
Vue.use(Carousel3d)
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    meta:{guess:true},
    component: () => import('../views/Home.vue') // set home as path '/'
  },
  {
    path: '/manager',
    name: 'Manager',
    meta: { admin: true},
    component: () => import('../views/Manager.vue') // set owner as path '/'
  },
  {
    path: '/pointofsell',
    name: 'pointofsell',
    meta: { employee: true },
    component: () => import('../views/Pos.vue') // set owner as path '/'
  },
  {
    path: '/ordermenu',
    name: 'ordermenu',
    meta: { login: true },
    component: () => import('../views/Ordermenu.vue') // set owner as path '/'
  },
  {
    path: '/signup',
    name: 'signup',
    meta: { guess: true },
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
    next({ path: '/ordermenu'})
  }
  if((to.meta.admin || to.meta.employee)&&(!isLoggedIn)){
    alert('Please login first!')
    next({ path: '/' })
  }
  if(isLoggedIn){
  axios.get("http://localhost:3000/user/me", {
    headers: { Authorization: "Bearer " + token },
  })
  .then(res => {
    if(to.meta.admin && res.data.role!='admin'){
      alert('admin only')
      next({ path: '/ordermenu' })
    }
    if(to.meta.employee && res.data.role =='customer'){
      alert('employee only')
      next({path:'/ordermenu'})
    }
  })
}


  

  next()
})

export default router
<template>
  <div class="container is-fluid" style="margin-top:50px">
    <div class="columns is-centered">
      <div class="column is-4 ">
        <h1 class="title has-text-left">เข้าสู่ระบบ</h1>
        <!-- Login form -->
        <div class="field">
          <label class="label has-text-left">Username</label>
          <div class="control has-icons-left">
            <input v-model="username" class="input" type="text" />
            <span class="icon is-small is-left">
              <i class="fa fa-user"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <label class="label has-text-left">Password</label>
          <div class="control has-icons-left has-icons-right">
            <input v-model="password" class="input" type="password" />
            <span class="icon is-small is-left">
              <i class="fa fa-lock"></i>
            </span>
            <span class="icon is-small is-right">
              <i class="fa fa-check"></i>
            </span>
          </div>
        </div>

        <button class="button is-primary is-fullwidth" @click="submit()">Login</button>

        <p class="my-3 has-text-dark has-text-left">
          ยังไม่ได้เป็นสมาชิกใช่ไหม? <router-link to="/signup">
              signup
            </router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import axios from 'axios'
export default {
  data() {
    return {
      username: "",
      password: "",
      error: "",
    };
  },
  methods: {
     submit () {
       const data = {
         username: this.username,
         password: this.password
       }
 
       axios.post('http://localhost:3000/user/login/', data)
         .then(res => {
           const token = res.data.token                                
           localStorage.setItem('token', token)
           this.$emit('auth-change')
           if(res.data.role == "customer"){
           this.$router.push({path: '/ordermenu'})
           }
           else if(res.data.role == "admin"){
             this.$router.push({path: '/manager'})
           }
         })
         .catch(error => {
           this.error = error.response.data
           console.log(error.response.data)
         })
     }
  }
}
</script>

<style scoped>
</style>
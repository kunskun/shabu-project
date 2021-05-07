<template>
  <div id="app" class="Site" style="margin-top: 0px">
    <main class="Site-content">
    <nav
      class="navbar"
      role="navigation"
      aria-label="main navigation"
      style="background-color: #31525b"
    >
      <div class="navbar-brand" style="background-color: #31525b">
        <a class="navbar-item" href="http://localhost:8080/">
          <img src="./assets/logo.png" width="112" height="28" />
        </a>
      </div>

      <div id="navbarBasicExample" class="navbar-menu">
        <div class="navbar-end">
          <div class="navbar-item">
            <div class="buttons">
              <router-link
                to="/comment"
                class="button"
                style="background-color: #31525b; color: white"
              >
                แสดงความคิดห็น
              </router-link>
            </div>
          </div>
          <div class="navbar-item" v-if="!user">
            <div class="buttons">
              <router-link
                to="/"
                class="button"
                style="background-color: #31525b; color: white"
              >
                เข้าสู่ระบบ
              </router-link>
              <router-link
                to="/signup"
                class="button"
                style="background-color: #fae681"
              >
                สมัครสมาชิก
              </router-link>
            </div>
          </div>
          <div v-if="user" class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
              <figure class="image is-24x24 my-auto">
                <img
                  class="is-rounded"
                  src="https://www.pngfind.com/pngs/m/93-938050_png-file-transparent-white-user-icon-png-download.png"
                />
              </figure>
              <span class="pl-3 has-text-white"
                >{{ user.first_name }} {{ user.last_name }}</span
              >
            </a>
            <div class="navbar-dropdown">
              <a class="navbar-item" href="/">Profile</a>
              <a class="navbar-item" @click="logOut">Log out</a>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <router-view :key="$route.fullPath" @auth-change="onAuthChange" />
    </main>
               <footer style="background-color: #31525b;padding: 3rem 1.5rem 3rem; height:28vh">
  <div class="content">
    <div class="columns">
      <div class="column is-4  has-text-left">
        <h3 class="has-text-light ml-3">Contact Us</h3>
        <div class="column">
            <p>
              นายกฤษกร		 อำนาจสถิตย์ รหัสนักศึกษา 62070006 <br>
              นายญาณวุฒิ	  ศรีทอง รหัสนักศึกษา 62070051 <br>
              นายธนายุทธ    กันซัน รหัสนักศึกษา 62070084 
            </p>
        </div>
      </div>
      <div class="column is-4">
        <img src="./assets/logo.png" alt="ระบบฐานข้อมูลร้านชาบู" width="70%">
      </div>
      <div class="column is-4  has-text-right">
        <h3 class="has-text-light">Term of Us</h3>
        <p>
          ระบบฐานข้อมูลร้านชาบู <br> 
          โดยนักศึกษาชั้นปีที่ 2 คณะเทคโนโลยีสารสนเทศ <br>
          สาขาวิชา Software Engineer <br>
          สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง
        </p>
        
      </div>
    </div>
  </div>
</footer>
  </div>
  
  
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      user: null,
    };
  },
  mounted() {
    this.onAuthChange();
  },
  methods: {
    onAuthChange() {
      const token = localStorage.getItem("token");
      if (token) {
        this.getUser();
      }
    },
    getUser() {
      const token = localStorage.getItem("token");
      axios
        .get("http://localhost:3000/user/me", {
          headers: { Authorization: "Bearer " + token },
        })
        .then((res) => {
          this.user = res.data;
        });
    },
    logOut() {
      localStorage.clear();
      this.user = null;
      this.$router.push({ path: "/" });
      if(window.location.href == "http://localhost:8080/"){
        window.location.reload()
      }
    },
  },
};
</script>



<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: white;
  margin-top: 0px;
}
.button {
  background-color: #31525b;
  color: white;
}
.Site {
  display: flex;
  min-height: 100vh;
  flex-direction: column;
}

.Site-content {
  flex: 1;
}
</style>

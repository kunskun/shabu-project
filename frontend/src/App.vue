<template>
  <div id="app" style="margin-top:0px">
    <nav class="navbar" role="navigation" aria-label="main navigation" style="background-color:#31525b;">
  <div class="navbar-brand" style="background-color:#31525b;">
    <a class="navbar-item" href="http://localhost:8080/" >
      <img src="./assets/logo.png" width="112" height="28">
    </a>
  </div>

  <div id="navbarBasicExample" class="navbar-menu">

    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <a class="button" style="background-color:#31525b;color:white;">
            เข้าสู่ระบบ
          </a>
          <a class="button" style="background-color:#fae681;">
            สมัครสมาชิก
          </a>
        </div>
      </div>
    </div>
  </div>
</nav>
    <router-view :key="$route.fullPath" />
  </div>
</template>
<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: white;
  margin-top: 60px;
}
.button{
  background-color:#31525b;
  color:white;
}
</style>

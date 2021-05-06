<template>
  <div class="container is-fluid" style="margin-top: 50px">
    <div class="columns is-centered mt-5">
      <div class="column is-8">
        <div id="example">
          <p class="title">Shabu Restaurant</p>
          <carousel-3d
            :autoplay="true"
            :autoplay-timeout="3000"
            :display="5"
            :controls-visible="true"
          >
            <slide v-for="(slide, i) in slides" :key="i" :index="i">
              <figure>
                <img :src="slide.image" />
              </figure>
            </slide>
          </carousel-3d>
        </div>
          <button class="button is-large  my-5 has-background-warning size-5" 
          style="width:60%"
          onclick="location.href='/ordermenu';">สั่งเลย !!</button>
      </div>
      <div class="column is-4" v-if="user">
        <h1 class="title has-text-center">
          <span class="icon mr-3">
            <i class="fa fa-user"></i>
          </span>
          ข้อมูลผู้ใช้
        </h1>
        <div class="columns my-2">
          <div class="column is-6 has-text-right">
            <p class="subtitle">Customer ID:</p>
            <p class="subtitle">Name:</p>
            <p class="subtitle">Point:</p>
            <p class="subtitle">Email:</p>
            <p class="subtitle">Phone:</p>
            <p class="subtitle">Role:</p>
          </div>
          <div class="column is-6 has-text-left">
            <p class="subtitle">{{custinfo.cus_id}}</p>
            <p class="subtitle">{{user.first_name}} {{user.last_name}}</p>
            <p class="subtitle">{{custinfo.point}}</p>
            <p class="subtitle">{{user.email}}</p>
            <p class="subtitle">{{user.mobile}}</p>
            <p class="subtitle">{{user.role}}</p>
          </div>
        </div>
      </div>

      <div class="column is-4" v-if="!user">
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

        <button class="button is-primary is-fullwidth" @click="submit()">
          Login
        </button>

        <p class="my-3 has-text-dark has-text-left">
          ยังไม่ได้เป็นสมาชิกใช่ไหม?
          <router-link to="/signup"> signup </router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import axios from "axios";
export default {
  data() {
    return {
      username: "",
      password: "",
      error: "",
      user: "",
      custinfo: "",
      slides: [
        {
          image:
            "https://foodsguy.com/wp-content/uploads/2020/08/Can-You-Freeze-Uncooked-Bacon.jpg",
        },
        {
          image:
            "https://img.wongnai.com/p/1920x0/2019/05/06/23ac401d7bb54cd2a6015d5615c14289.jpg",
        },
        { image: "https://f.ptcdn.info/379/049/000/olo4nbziuotStJAF89A-o.jpg" },
        {
          image:
            "https://cfcdn2.azsg.opensnap.com/azsg/snapphoto/photo/LL/H2GM/3DDI5K847601F48E6091E7lv.jpg",
        },
        {
          image:
            "https://www.thammachartseafood.com/media/catalog/product/cache/2/image/1500x1500/6dcdb3bec3b7d3d8fa2d31ce95a0090e/f/r/frozen_us_scallops_2-min.jpg",
        },
      ],
    };
  },
  mounted() {
    this.getUser();
    this.getCustomer();
  },
  methods: {
    getUser() {
      axios
        .get("http://localhost:3000/user/me", {
          headers: { Authorization: "Bearer " + localStorage.getItem("token") },
        })
        .then((response) => {
          this.user = response.data;
          this.getCustomer();
        });
    },
    getCustomer() {
      axios
        .get("http://localhost:3000/user/customer/" + this.user.id)
        .then((response) => {
          this.custinfo = response.data[0];
        })
        .catch((err) => {
          console.log(err);
        });
    },
    submit() {
      const data = {
        username: this.username,
        password: this.password,
      };

      axios
        .post("http://localhost:3000/user/login/", data)
        .then((res) => {
          const token = res.data.token;
          localStorage.setItem("token", token);
          this.$emit("auth-change");
          window.location.reload();
          // if (res.data.role == "customer") {
          //   this.$router.push({ path: "/ordermenu" });
          // } else if (res.data.role == "admin") {
          //   this.$router.push({ path: "/manager" });
          // } else if (res.data.role == "employee") {
          //   this.$router.push({ path: "/pointofsell" });
          // }
        })
        .catch((error) => {
          this.error = error.response.data;
          console.log(error.response.data);
        });
    },
  },
};
</script>

<style scoped>
</style>
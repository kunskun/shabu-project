<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title">Add new comment</p>
      </div>
    </section>
    <section class="px-6">



      <div class="field mt-5">
        <label class="label">Your name</label>
        <div class="control">
          <input v-model="commentOwner" class="input" type="text" placeholder="ชื่อผู้แสดงความคิดเห็น" />
        </div>
      </div>

      <div class="field">
        <label class="label">Your Comment</label>
        <div class="control">
          <textarea v-model="commentContent" class="textarea" placeholder="ข้อความ"></textarea>
        </div>
      </div>




      <div class="field is-grouped">
        <div class="control">
          <button @click="submitComment" class="button is-link">Submit</button>
        </div>
        <div class="control">
          <button @click="$router.go(-1)" class="button is-link is-light">Cancel</button>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "axios" 

export default({
  data() {
    return {
      commentOwner:"",
      commentContent:"",
    };
  },
  methods:{
      submitComment(){
        axios
        .post("http://localhost:3000/comment",{name:this.commentOwner,comment:this.commentContent})
        .then(() => this.$router.push({name: 'ordermenu'}))
        .catch((e) => console.log(e.response.data));

      }
  }
})
</script>



<style>
</style>
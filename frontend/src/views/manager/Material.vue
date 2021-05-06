<template>
  <section>
    <div class="column is-full my-5">
          <p class="title is-4 has-text-left">Material
            <button style="float: right" class="button is-primary" @click="newModal = true">New Material</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>Material ID</th>
                <th>Name</th>
                <th>Material Left</th>
                <th>Price</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="mat in blogs" :key="mat.mats_id">
                <td>{{ mat.mats_id }}</td>
                <td>{{ mat.mats_name }}</td>
                <td :class="{'has-text-danger': mat.mats_left < 5}">{{ mat.mats_left }}</td>
                <td>{{ mat.price }} </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editItem(mat)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteItem(mat.mats_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

    <!-- edit modal -->
    <div class="modal" :class="{'is-active': editModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit material ID: {{ editId }}</p>
          <button class="delete" aria-label="close" @click="editModal = false"></button>
        </header>
        <section class="modal-card-body">
          <div class="columns" style="color: black;">
            <div class="column is-4 has-text-left">Name: <br>
              <input class="input mt-4" type="text" v-model="editName">
            </div>
            <div class="column is-5 has-text-left">Material Left: <br>
              <input class="input mt-4" type="number" v-model="editMatLeft">
            </div>
            <div class="column is-3 has-text-left">Price: <br>
              <input class="input mt-4" type="number" v-model="editPrice">
            </div>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveEdit">Save changes</button>
          <button class="button" @click="editModal = false">Cancel</button>
        </footer>
      </div>
    </div>

    <!-- new modal -->
    <div class="modal" :class="{'is-active': newModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit material ID: {{ editId }}</p>
          <button class="delete" aria-label="close" @click="newModal = false"></button>
        </header>
        <section class="modal-card-body">
          <div class="columns" style="color: black;">
            <div class="column is-4 has-text-left">Name: <br>
              <input class="input mt-4" type="text" v-model="editName">
            </div>
            <div class="column is-5 has-text-left">Material Left: <br>
              <input class="input mt-4" type="number" v-model="editMatLeft">
            </div>
            <div class="column is-3 has-text-left">Price: <br>
              <input class="input mt-4" type="number" v-model="editPrice">
            </div>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveNewItem">Save changes</button>
          <button class="button" @click="newModal = false">Cancel</button>
        </footer>
      </div>
    </div>

  </section>
</template>

<script>
import axios from "axios";
// import moment from 'moment';

export default {
  data: function () {
    return {
      blogs: [],
      detailBlog: [],
      detailModal: false,
      editModal: false,
      editId: 0,
      editName: '',
      editMatLeft: 0,
      editPrice: 0,
      newModal: false,
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    getItems() {
      axios
        .get("http://localhost:3000/manager/materials")
        .then((res) => {
          console.log(res);
          this.blogs = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    editItem(item) {
      this.editModal = true
      this.editId = item.mats_id
      this.editName = item.mats_name
      this.editMatLeft = item.mats_left
      this.editPrice = item.price
    },
    saveEdit(){
      axios
      .put("http://localhost:3000/manager/materials/"+this.editId, 
      {name: this.editName, left: this.editMatLeft, price: this.editPrice})
        .then((res) => {
            this.blogs.forEach(val => {
              if(val.mats_id == res.data.id){
                val.mats_name = res.data.name
                val.mat_left = res.data.mat_left
                val.price = res.data.price
              }
           })
          this.getItems()
          this.editModal = false      
          this.editId = 0
          this.editName = ''
          this.editMatLeft = 0 
          this.editPrice = 0
        })
        .catch((e) => console.log(e));
    },
    deleteItem(id) {
      const result = confirm(`Are you sure you want to delete materials ID `+id);
      if (result) {
        axios
          .delete(`http://localhost:3000/manager/materials/`+id)
          .then((response) => {
            console.log(response);
            this.blogs = this.getItems()  
            this.$router.push("/manager");
          })
          .catch((error) => {
            alert(error.response.data.message);
          });
      }
    },
    saveNewItem(){
      axios
      .post("http://localhost:3000/manager/materials", 
      {name: this.editName, left: this.editMatLeft, price: this.editPrice})
        .then((res) => {
          console.log(res);
          this.getItems()
          this.newModal = false       
        })
        .catch((e) => console.log(e));
    },
  },
}
</script>

<style scoped>
tr{
    line-height: 3rem;
  }
</style>

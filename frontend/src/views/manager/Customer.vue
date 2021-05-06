<template>
  <section>
    <div class="column is-full mx-1 my-5">
      <p class="title is-4 has-text-left">Customer</p>
      <table class="table is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
          <tr>
            <th>ID</th>
            <th>First name</th>
            <th>Last name</th>
            <th>Point</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="cus in blogs" :key="'cus' + cus.cus_id">
            <td>{{ cus.cus_id }}</td>
            <td>{{ cus.cus_fname }}</td>
            <td>{{ cus.cus_lname }}</td>
            <td>{{ cus.point }}</td>
            <td>
              <i
                class="fa fa-edit"
                style="cursor: pointer"
                @click="editItem(cus)"
              ></i>
              <i
                class="fa fa-trash ml-4"
                aria-hidden="true"
                style="cursor: pointer; transform: translateY(-1px)"
                @click="deleteItem(cus.cus_id)"
              ></i>
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
          <p class="modal-card-title">Edit customer ID: {{ editId }}</p>
          <button class="delete" aria-label="close" @click="editModal = false"></button>
        </header>
        <section class="modal-card-body">
          <div class="columns" style="color: black;">
            <div class="column is-4 has-text-left">First Name: <br>
              <input class="input mt-4" type="text" v-model="editFname">
            </div>
            <div class="column is-4 has-text-left">Last Name: <br>
              <input class="input mt-4" type="text" v-model="editLname">
            </div>
            <div class="column is-3 has-text-left">Point: <br>
              <input class="input mt-4" type="number" v-model="editPoint">
            </div>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveEdit">Save changes</button>
          <button class="button" @click="editModal = false">Cancel</button>
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
      editFname: '',
      editLname: '',
      editPoint: -1,
      newModal: false,
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    getItems() {
      axios
        .get("http://localhost:3000/manager/customer")
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
      this.editId = item.cus_id
      this.editFname = item.cus_fname
      this.editLname = item.cus_lname
      this.editPoint = item.point
    },
    saveEdit(){
      axios
      .put("http://localhost:3000/manager/customer/"+this.editId, 
      {fname: this.editFname, lname: this.editLname, point: this.editPoint})
        .then((res) => {
            this.blogs.forEach(val => {
              if(val.cus_id == res.data.id){
                val.cus_fname = res.data.fname
                val.cus_lname = res.data.lname
                val.point = res.data.point
              }
           })
          this.getItems()
          this.editModal = false      
          this.editId = 0
          this.editFname = ''
          this.editLname = '' 
          this.editPoint = -1
        })
        .catch((e) => console.log(e));
    },
    deleteItem(id) {
      const result = confirm(`Are you sure you want to delete customer ID `+id);
      if (result) {
        axios
          .delete(`http://localhost:3000/manager/customer/`+id)
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
};
</script>
<style scoped>
tr{
    line-height: 3rem;
  }
</style>
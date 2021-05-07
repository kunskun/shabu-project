<template>
    <div class="column is-full mx-1 my-5">
          <p class="title is-4 has-text-left">Supplier
              <button style="float: right" class="button is-primary" @click="createModal = true">New Supplier</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="sup in blogs" :key="'sup'+sup.sup_id">
                <td>{{ sup.sup_id }}</td>
                <td>{{ sup.sup_name }}</td>
                <td>{{ sup.phone }}</td>
                <td>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteSup(sup.sup_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>

          <!-- Create Menu modal -->
    <div class="modal" :class="{ 'is-active': createModal }">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Add new {{ selectSite }}</p>
          <button
            class="delete"
            aria-label="close"
            @click="createModal = false"
          ></button>
        </header>
        <section class="modal-card-body">
          <span>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Name: <br>
                <input class="input mt-4" type="text" v-model="newSupName">
              </div>
              <div class="column is-6 has-text-left">Phone: <br>
                <input class="input mt-4" type="text" v-model="newPhone">
              </div>
            </div>
          </span>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="createSup">
            Save changes  
          </button>
          <button class="button" @click="(createModal = false)">
            Cancel
          </button>
        </footer>
        <!-- end create modal -->
        </div>
    </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
  name:"supplier",
    data() {
        return{
      selectSite: "supplier",
      blogs: [],
      detailBlog: [],
      createModal: false,
      detailModal: false,
      editModal: false,
      newSupName:"",
      newPhone:"",
        }
    },
  mounted() {
    this.getItems();
  },
  methods:{
        createSup() {
      axios
        .post("http://localhost:3000/manager/supplier", {
          name: this.newSupName,
          phone: this.newPhone,
        })
        .then((res) => {
          alert(res.data);
          this.createModal = false;
          this.newSupName = "";
          this.newPhone = "";
          this.getItems();
        });
    },
    deleteSup(id){
        axios
        .delete("http://localhost:3000/manager/supplier/"+id)
        .then((res) => {
          alert(res.data);
          this.getItems();
        });
    },
        getItems() {
      console.log("Create Menu");
      axios
        .get("http://localhost:3000/manager/supplier")
        .then((res) => {
          console.log(res.data);
          this.blogs = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  }
}
</script>
<style scoped>
tr {
  line-height: 3rem;
}
</style>

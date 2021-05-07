<template>
  <div class="column is-full my-5">
    <p class="title is-4 has-text-left">
      Menu
      <button
        style="float: right"
        class="button is-primary"
        @click="createModal = true"
      >
        New Menu
      </button>
    </p>
    <table class="table is-striped is-narrow is-hoverable is-fullwidth">
      <thead>
        <tr>
          <th>ID</th>
          <th>Image</th>
          <th>Name</th>
          <th>Price</th>
          <th>Cost</th>
          <th>Description</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <template v-for="menu in blogs">
          <tr v-if="menu.status == 'Stayed'" :key="'menu' + menu.menu_id">
            <td>{{ menu.menu_id }}</td>
            <td>
              <img :src="menu.image" :alt="menu.menu_name" width="170px" />
            </td>
            <td>{{ menu.menu_name }}</td>
            <td>{{ menu.sale_price }}</td>
            <td>{{ menu.mats_cost }}</td>
            <td>{{ menu.description }}</td>
            <td>
              <i
                class="fa fa-edit"
                style="cursor: pointer"
                @click="editClickedModal(menu)"
              ></i>
              <i
                class="fa fa-trash ml-4"
                aria-hidden="true"
                style="cursor: pointer; transform: translateY(-1px)"
                @click="deleteMenu(menu.menu_id)"
              ></i>
            </td>
          </tr>
        </template>
      </tbody>
    </table>

    <!-- EditModal -->
    <div class="modal" :class="{ 'is-active': editModal }">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit {{ selectSite }} ID: {{ editId }}</p>
        </header>
        <section class="modal-card-body">
          <span>
            <div class="columns" style="color: black">
              <div class="column is-6 has-text-left">
                Image: <br />
                <input class="input mt-4" type="url" v-model="editImage" />
              </div>
              <div class="column is-6 has-text-left">
                Name: <br />
                <input class="input mt-4" type="text" v-model="editMatName" />
              </div>
            </div>
            <div class="columns" style="color: black">
              <div class="column is-6 has-text-left">
                Price: <br />
                <input class="input mt-4" type="number" v-model="editPrice" />
              </div>
              <div class="column is-6 has-text-left">
                Cost: <br />
                <input class="input mt-4" type="number" v-model="editCost" />
              </div>
            </div>
            <div class="columns" style="color: black">
              <div class="column is-full has-text-left">
                Description: <br />
                <textarea
                  class="textarea mt-4"
                  v-model="editDescrip"
                ></textarea>
              </div>
            </div>
          </span>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveEditModal">Save changes</button>
          <button class="button" @click="(editModal = false), clearEdit()">
            Cancel
          </button>
        </footer>
      </div>
    </div>

    <!-- Create Menu modal -->
    <div class="modal" :class="{ 'is-active': createModal }">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Add new {{ selectSite }}</p>
          <button
            class="delete"
            aria-label="close"
            @click="(createModal = false)"
          ></button>
        </header>
        <section class="modal-card-body">
          <span v-if="selectSite === 'menu'">
            <div class="columns" style="color: black">
              <div class="column is-6 has-text-left">
                Image: <br />
                <input class="input mt-4" type="url" v-model="newImage" />
              </div>
              <div class="column is-6 has-text-left">
                Name: <br />
                <input class="input mt-4" type="text" v-model="newMatName" />
              </div>
            </div>
            <div class="columns" style="color: black">
              <div class="column is-6 has-text-left">
                Price: <br />
                <input class="input mt-4" type="number" v-model="newPrice" />
              </div>
              <div class="column is-6 has-text-left">
                Cost: <br />
                <input class="input mt-4" type="number" v-model="newCost" />
              </div>
            </div>
            <div class="columns" style="color: black">
              <div class="column is-full has-text-left">
                Description: <br />
                <textarea class="textarea mt-4" v-model="newDescrip"></textarea>
              </div>
            </div>
          </span>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="createMenu">
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
// import moment from 'moment';

export default {
  name: "menu",
  data: function () {
    return {
      selectSite: "menu",
      blogs: [],
      detailBlog: [],
      createModal: false,
      detailModal: false,
      editModal: false,

      newImage: "",
      newMatName: "",
      newCost: "",
      newPrice: "",
      newDescrip: "",

      editImage: "",
      editMatName: "",
      editCost: "",
      editPrice: "",
      editDescrip: "",
      editId: "",
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    createMenu() {
      axios
        .post("http://localhost:3000/manager/menu", {
          image: this.newImage,
          newMat: this.newMatName,
          cost: this.newCost,
          price: this.newPrice,
          descrip: this.newDescrip,
        })
        .then((res) => {
          alert(res);
          this.createModal = false;
          this.newImage = "";
          this.newMatName = "";
          this.newCost = "";
          this.newPrice = "";
          this.newDescrip = "";
          this.getItems();
        });
    },
    editClickedModal(menu) {
      this.editModal = true;
      this.editImage = menu.image;
      this.editMatName = menu.menu_name;
      this.editCost = menu.mats_cost;
      this.editPrice = menu.sale_price;
      this.editDescrip = menu.description;
      this.editId = menu.menu_id;
    },
    saveEditModal() {
      axios
        .put("http://localhost:3000/manager/menu",
         {  id: this.editId,
           image: this.editImage,
          editMat: this.editMatName,
          cost: this.editCost,
          price: this.editPrice,
          descrip: this.editDescrip,})
        .then(() => {
          alert("Edited menu:" + this.editId);
          this.editModal = false
          this.getItems();

        })
        .catch((err) => {
          console.log(err);
        });
    },
    deleteMenu(menu_id) {
      axios
        .put("http://localhost:3000/manager/deletemenu", { id: menu_id })
        .then(() => {
          alert("Deleted menu:" + menu_id);
          this.getItems();
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getItems() {
      console.log("Create Menu");
      axios
        .get("http://localhost:3000/manager/menu")
        .then((res) => {
          console.log(res);
          this.blogs = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>
<style scoped>
tr {
  line-height: 3rem;
}
</style>


<template>
  <section>
    <div class="column is-full my-5">
      <p class="title is-4 has-text-left">Users </p>
      <table class="table is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
          <tr>
            <th>Username</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>E-mail</th>
            <th>Mobile</th>
            <th>Role</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in blogs" :key="user.id">
            <td>{{ user.username }}</td>
            <td>{{ user.first_name }}</td>
            <td>{{ user.last_name }}</td>
            <td>{{ user.email }}</td>
            <td>{{ user.mobile }}</td>
            <td>{{ user.role }}</td>
            <td>
              <i
                class="fa fa-edit"
                style="cursor: pointer"
                @click="editItem(user)"
              ></i>
              <i
                class="fa fa-trash ml-4"
                aria-hidden="true"
                style="cursor: pointer; transform: translateY(-1px)"
                @click="deleteItem(user.id)"
              ></i>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- EditModal -->
    <div class="modal is-small" :class="{ 'is-active': editModal }">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit role user: {{name}}</p>
        </header>
        <section class="modal-card-body" style="float: center; color: balck">
            <div class="column has-text-center is-full has-text-dark">User Role</div>
            <div class="select is-6 mt-4" style="color: black;">
                <select v-model="newRole">
                    <option disabled hidden selected="selected">Select Role</option>
                    <option key="admin" value="admin">admin</option>
                    <option key="customer" value="customer">customer</option>
                    <option key="employee" value="employee">employee</option>
                </select>
            </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveEditModal">Save changes</button>
          <button class="button" @click="(editModal = false), oldRole = ''">
            Cancel
          </button>
        </footer>
      </div>
    </div>
  </section>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      blogs: [],
      detailBlog: [],
      detailModal: false,
      editModal: false,
      newRole: '',
      oldRole: '',
      editId: 0,
      name: ''
    };
  },
  mounted() {
    this.getItems();
    this.getSup();
  },
  methods: {
    getItems() {
      axios
        .get("http://localhost:3000/manager/userrole")
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
      this.editId = item.id
      this.name = item.username
      this.oldRole = item.role
    },
    saveEditModal() {
        console.log(this.newRole, this.oldRole, this.editId);
      axios
        .put("http://localhost:3000/manager/userrole/"+this.editId, {role: this.newRole})
        .then((res) => {
          console.log(res);
          this.editModal = false
          this.getItems();
        })
        .catch((err) => {
          console.log(err);
        });
    },
    deleteItem(id) {
      const result = confirm(`Are you sure you want to delete user ID `+id);
      if (result) {
        axios
          .delete(`http://localhost:3000/manager/userrole/`+id)
          .then((response) => {
            console.log(response);
            this.blogs = this.getItems()  
          })
          .catch((error) => {
            alert(error.response.data.message);
          });
      }
    },
  },
};
</script>

<style scoped>
tr{
    line-height: 3rem;
  }
</style>

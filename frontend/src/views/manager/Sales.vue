<template >
  <section id="app">
    <div class="column is-full my-5">
      <div class="columns">
        <div class="column is-full">
          <p class="title is-4 has-text-left">Order Food</p>
        </div>
      </div>
      <table class="table is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
          <tr>
            <th>ID</th>
            <th>Date</th>
            <th class="has-text-left">Customer Name</th>
            <th>Income</th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="sale in blogs" :key="sale.sale_id">
            <td>{{ sale.sale_id }}</td>
            <td>{{ formatDate(sale.date) }}</td>
            <td class="has-text-left">
              {{ sale.cus_fname + " " + sale.cus_lname }}
            </td>
            <td>{{ sale.income }}</td>
            <td>
              <button class="button is-light" @click="seeDetail(sale.sale_id)">
                see more
              </button>
            </td>
            <td>
              <!-- <i
                class="fa fa-edit"
                aria-hidden="true"
                style="cursor: pointer"
                @click="editItem(sale)"
              ></i> -->
              <i
                class="fa fa-trash ml-4"
                aria-hidden="true"
                style="cursor: pointer; transform: translateY(-1px)"
                @click="deleteItem(sale.sale_id)"
              ></i>
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <!-- <th v-if="del"></th> -->
            <th>Total</th>
            <th></th>
            <th></th>
            <th>{{ sumSales }}</th>
            <th></th>
            <th></th>
          </tr>
        </tfoot>
      </table>
    </div>
    
    <!-- detail modal -->
    <div class="modal" :class="{'is-active': detailModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Detail for Order ID: {{ detailIndex }}</p>
          <button class="delete" aria-label="close" @click="detailModal = false"></button>
        </header>
        <section class="modal-card-body">
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <th>Menu</th>
              <th>Name</th>
              <th>Unit</th>
              <th>Price</th>
            </thead>
            <tbody>
              <tr v-for="(item, index) in detailBlog" :key="item.item_id">
                <td>{{ index+1 }}</td>
                <td>{{ item.menu_name }}</td>
                <td>{{ item.unit }}</td>
                <td>{{ item.price*item.unit }}</td>
              </tr>
            </tbody>
            <tfoot>
              <th>Total</th>
              <th></th>
              <th></th>
              <th>{{ sumDetail }}</th>
            </tfoot>
          </table>
        </section>
        <footer class="modal-card-foot"></footer>
      </div>
    </div>

    <!-- edit modal -->
    <!-- <div class="modal" :class="{'is-active': editModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit Sale ID: {{ editId }}</p>
          <button class="delete" aria-label="close" @click="editModal = false"></button>
        </header>
        <section class="modal-card-body">
          <div class="columns" style="color: black;">
            <div class="column is-5 has-text-left">Date: <br>
              <input class="input mt-4" type="date" >
            </div>
            <div class="column is-7 has-text-left">Income: <br>
              <input class="input mt-4" type="number" >
            </div>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" >Save changes</button>
          <button class="button" @click="editModal = false">Cancel</button>
        </footer>
      </div>
    </div> -->

  </section>
</template>
<script>
import axios from "axios";
import moment from 'moment';

export default {
  name: "sales",
  data: function () {
    return {
      selectSite: "sales",
      blogs: [],
      detailBlog: [],
      detailModal: false,
      editModal: false,
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    getItems() {
      console.log("Create Sale");
      axios
        .get("http://localhost:3000/manager/sales")
        .then((res) => {
          console.log(res);
          this.blogs = res.data;

        })
        .catch((err) => {
          console.log(err);
        });
    },
    seeDetail(id) {
      this.detailModal = true;
      this.detailIndex = id;
      axios
        .get("http://localhost:3000/manager/sales/" + id)
        .then((response) => {
          console.log(response);
          this.detailBlog = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
     formatDate(value) {
      if (value) {
        return moment(String(value)).format('DD-MM-YYYY')
      }
    },
    editItem(item) {
      this.editModal = true
      this.editId = item.sale_id
      this.editDate = item.date.substring(0,10)
      this.editIncome = item.income
    },
    deleteItem(id) {
      const result = confirm(`Are you sure you want to delete sale at ID `+id);
      if (result) {
        axios
          .delete(`http://localhost:3000/manager/sales/`+id)
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
  },
  computed: {
    sumSales() {
      var sum = 0;
      console.log("start");
      this.blogs.forEach((val) => (sum += parseFloat(val.income)));
      return sum;
    },
    sumDetail() {
      var sum = 0;
      this.detailBlog.forEach(
        (val) => (sum += parseFloat(val.price) * parseFloat(val.unit))
      );
      return sum;
    },
  },
};
</script>
<style scoped>
tr{
    line-height: 3rem;
  }
</style>

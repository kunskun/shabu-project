<template>
  <section>
    <div class="column is-full my-5">
      <p class="title is-4 has-text-left">Order Material
        <button style="float: right" class="button is-primary" @click="newModal = true">New Order</button>
      </p>
      <table class="table is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
          <tr>
            <th>Order ID</th>
            <th>Date</th>
            <!-- <th>Name</th> -->
            <th>Unit</th>
            <th>Price</th>
            <th>Total</th>
            <th>Supplier ID</th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="order in blogs" :key="order.order_id">
            <td>{{ order.order_id }}</td>
            <td>{{ formatDate(order.buy_date) }}</td>
            <!-- <td>{{ order.mats_name }}</td> -->
            <td>{{ order.unit }}</td>
            <td>{{ order.price }}</td>
            <td>{{ order.total_price }}</td>
            <td>{{ order.supplier_id }}</td>
            
            <!-- <td>
              <button class="button is-light" @click="seeDetail(order.order_id)">
                see more
              </button>
            </td> -->
            <td>
              <!-- <i
                class="fa fa-edit"
                style="cursor: pointer"
                @click="editItem(order)"
              ></i> -->
              <i
                class="fa fa-trash ml-4"
                aria-hidden="true"
                style="cursor: pointer; transform: translateY(-1px)"
                @click="deleteItem(order.order_id)"
              ></i>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- detail modal -->
    <div class="modal" :class="{'is-active': detailModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Detail for Order ID: {{ detailId }}</p>
          <button class="delete" aria-label="close" @click="detailModal = false"></button>
        </header>
        <section class="modal-card-body">
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <th>Material</th>
              <th>Name</th>
              <th>Unit</th>
              <th>Price</th>
            </thead>
            <tbody>
              <tr v-for="(item, index) in detailBlog" :key="item.item_id">
                <td>{{ index+1 }}</td>
                <td>{{ item.mats_name }}</td>
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

    <!-- new modal -->
    <div class="modal" :class="{'is-active': newModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Add new order</p>
          <button class="delete" aria-label="close" @click="newModal = false"></button>
        </header>
        <section class="modal-card-body">
          <div class="columns" style="color: black;">
            <div class="column is-6 has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="newDate">
            </div>
            <div class="column is-6 has-text-left">Name: <br>
              <input class="input mt-4" type="text" v-model="newName">
            </div>
          </div>
          <div class="columns" style="color: black;">
            <div class="column is-4 has-text-left">Unit: <br>
              <input class="input mt-4" type="number" v-model="newUnit">
            </div>
            <div class="column is-4 has-text-left">Price: <br>
              <input class="input mt-4" type="number" v-model="newPrice">
            </div>
            <div class="column is-4 has-text-left">Supplier ID: <br>
              <div class="select is-full mt-4" style="color: black;">
                <select v-model="chooseSup">
                  <option disabled hidden selected="selected">Select Supplier</option>
                  <template v-for="sup in supBlog" >
                    <option :key="sup.sup_id" :value="sup.sup_id">{{sup.sup_name}}</option>
                  </template>
                </select>
              </div>
            </div>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveNewItem">Confirm</button>
          <button class="button" @click="newModal = false">Cancel</button>
        </footer>
      </div>
    </div>

  </section>
</template>

<script>
import axios from "axios";
import moment from 'moment';

export default {
  data: function () {
    return {
      blogs: [],
      detailBlog: [],
      detailModal: false,
      editModal: false,
      detailId: 0,
      newModal: false,
      newDate: '',
      newName: '',
      newUnit: 0,
      newPrice: 0,
      supBlog: [],
      chooseSup: 0,
    };
  },
  mounted() {
    this.getItems();
    this.getSup();
  },
  methods: {
    getItems() {
      axios
        .get("http://localhost:3000/manager/orders")
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
      axios
        .get("http://localhost:3000/manager/orders/"+ id)
        .then((response) => {
          console.log(response);
          this.detailBlog = response.data;
          this.detailId = id
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
    // editItem(item) {
    //   this.editModal = true
    //   this.editId = item.sale_id
    //   this.editDate = item.date.substring(0,10)
    //   this.editIncome = item.income
    // },
    deleteItem(id) {
      const result = confirm(`Are you sure you want to delete order ID `+id);
      if (result) {
        axios
          .delete(`http://localhost:3000/manager/orders/`+id)
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
      // console.log(this.blogs[0]);
      axios
      .post("http://localhost:3000/manager/orders", 
      {date: this.newDate, name: this.newName, unit: this.newUnit, supid: this.chooseSup, price: this.newPrice})
        .then((res) => {
          console.log(res);
          this.getItems()
          this.newModal = false       
        })
        .catch((e) => console.log(e));
    },
    getSup() {
      axios
        .get("http://localhost:3000/manager/supplier")
        .then((res) => {
          console.log(res);
          this.supBlog = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
  computed:{
    sumDetail() {
      var sum = 0
      this.detailBlog.forEach(val => sum += (parseFloat(val.price)*parseFloat(val.unit)));
      return sum
    },
  }
};
</script>

<style scoped>
tr{
    line-height: 3rem;
  }
</style>

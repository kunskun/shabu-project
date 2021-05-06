<template>
  <section>
    <div class="column is-full my-5">
      <p class="title is-4 has-text-left">Order Material</p>
      <table class="table is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
          <tr>
            <th>Order ID</th>
            <th>Date</th>
            <th>Name</th>
            <th>Unit</th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="order in blogs" :key="order.order_id">
            <td>{{ order.order_id }}</td>
            <td>{{ formatDate(order.buy_date) }}</td>
            <td>{{ order.mats_name }}</td>
            <td>{{ order.unit }}</td>
            <td>
              <button class="button is-light" @click="seeDetail(order.order_id)">
                see more
              </button>
            </td>
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
          <p class="modal-card-title">Detail for Order ID: {{ detailIndex }}</p>
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
    };
  },
  mounted() {
    this.getItems();
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
  },
};
</script>

<style scoped>
tr{
    line-height: 3rem;
  }
</style>

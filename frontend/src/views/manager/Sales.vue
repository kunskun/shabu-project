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
              <i
                class="fa fa-edit"
                aria-hidden="true"
                style="cursor: pointer"
                @click="editModals(sale)"
              ></i>
              <i
                class="fa fa-trash ml-4"
                aria-hidden="true"
                style="cursor: pointer; transform: translateY(-1px)"
                @click="deleteRecord(sale.sale_id)"
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

<template>
<section>
    <div class="column is-full mx-1 my-5">
      <p class="title is-4 has-text-left">Day Account</p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Income</th>
                <th>Expense</th>
                <th>Tip</th>
                <th>Profit</th>
                <th></th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="day in blogs" :key="day.acc_id">
                <td>{{ day.acc_id }}</td>
                <td>{{ formatDate(day.acc_date) }}</td>
                <td class="has-text-success">{{ day.sale_income }} </td>
                <td class="has-text-danger">{{ day.mats_expense }} </td>
                <td>{{ day.tip }}</td>
                <td>{{ day.balance }}</td>
                <td>
                  <button class="button is-light" @click="seeDetail(day.acc_date)">see more</button>
                </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editItem(day)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteItem(day.acc_id)"></i>
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th colspan="2" class="has-text-left pl-5">Total</th>
                <th>{{ sumDayIncome }}</th>
                <th>{{ sumDayExp }}</th>
                <th>{{ sumDayTip }}</th>
                <th>{{ sumDayBalance }}</th>
                <th></th>
                <th></th>
              </tr>
            </tfoot>
          </table>
    </div>

    <!-- edit modal -->
    <div class="modal" :class="{'is-active': editModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit account ID: {{ editId }}</p>
          <button class="delete" aria-label="close" @click="editModal = false"></button>
        </header>
        <section class="modal-card-body">
          <div class="columns" style="color: black;">
            <div class="column is-full has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="editDate">
            </div>
          </div>
          <div class="columns" style="color: black;">
            <div class="column is-6 has-text-left">Income: <br>
              <input class="input mt-4" type="number" v-model="editIncome">
            </div>
            <div class="column is-6 has-text-left">Expense: <br>
              <input class="input mt-4" type="number" v-model="editExpense">
            </div>
          </div>
          <div class="columns" style="color: black;">
            <div class="column is-6 has-text-left">Tip: <br>
              <input class="input mt-4" type="number" v-model="editTip">
            </div>
            <div class="column is-6 has-text-left">Profit: <br>
              <input class="input mt-4" type="number" v-model="editProfit">
            </div>
          </div>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveEdit">Save changes</button>
          <button class="button" @click="editModal = false">Cancel</button>
        </footer>
      </div>
    </div>

    <!-- detail modal -->
    <div class="modal" :class="{'is-active': detailModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Detail for date: {{ formatDate(detaildate) }}</p>
          <button class="delete" aria-label="close" @click="detailModal = false"></button>
        </header>
        <section class="modal-card-body">
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <th>Menu</th>
              <th>Sale ID</th>
              <th>income</th>
            </thead>
            <tbody>
              <tr v-for="(item, index) in detailBlog" :key="item.sale_id">
                <td>{{ index+1 }}</td>
                <td>{{ item.sale_id }}</td>
                <td>{{ item.income }}</td>
              </tr>
            </tbody>
            <tfoot>
              <th>Total</th>
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
      editDate: '',
      editId: 0,
      editIncome: 0,
      editExpense: 0,
      editTip: 0,
      editProfit: 0,
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    formatDate(value) {
      if (value) {
        return moment(String(value)).format('DD-MM-YYYY')
      }
    },
    getItems() {
      axios
        .get("http://localhost:3000/manager/day_account")
        .then((res) => {
          console.log(res);
          this.blogs = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    seeDetail(date) {
      this.detailModal = true;
      this.detaildate = date;
      axios
        .get("http://localhost:3000/manager/day_account/" + date.substring(0,10))
        .then((response) => {
          console.log(response);
          this.detailBlog = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    editItem(item) {
      this.editModal = true
      this.editId = item.acc_id
      this.editDate = item.acc_date.substring(0,10)
      this.editIncome = item.sale_income
      this.editExpense = item.mats_expense
      this.editTip = item.tip
      this.editProfit = item.balance  
    },
    saveEdit(){
      axios
      .put("http://localhost:3000/manager/day_account/"+this.editId, 
      {date: this.editDate, income: this.editIncome, expense: this.editExpense, tip: this.editTip, prof: this.editProfit})
        .then((res) => {
            this.blogs.forEach(val => {
              if(val.acc_id == res.data.id){
                val.acc_date = res.data.date
                val.sale_income = res.data.income
                val.mats_expense = res.data.expense
                val.tip = res.data.tip
                val.balance = res.data.prof
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
      const result = confirm(`Are you sure you want to delete day account ID `+id);
      if (result) {
        axios
          .delete(`http://localhost:3000/manager/day_account/`+id)
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
  computed: {
    sumDetail() {
      var sum = 0
      this.detailBlog.forEach(val => sum += (parseFloat(val.income)));
      return sum
    },
  }
}
</script>

<style scoped>
tr{
    line-height: 3rem;
  }
</style>

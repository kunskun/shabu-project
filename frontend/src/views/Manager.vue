<template>
  <section id="app">
    <div class="columns orange">
      <div class="column is-2 py-5 pl-5">  
        <!-- <header class="card-header pb-5 orange">
          <img src="../assets/logo.png" alt="" width="100%">
        </header> -->

        <!-- item bar -->
        <template>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'sales' ? false:true}" @click="getItems(selectSite = 'sales')">
            <span class="title is-6">Order Food</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'orders' ? false:true}" @click="getItems(selectSite = 'orders')">
            <span class="title is-6">Order Material</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'day_account' ? false:true}" @click="getItems(selectSite = 'day_account')">
            <span class="title is-6">Day Account</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'month_account' ? false:true}" @click="getItems(selectSite = 'month_account')">
            <span class="title is-6">Month Account</span>
          </div>      
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'materials' ? false:true}" @click="getItems(selectSite = 'materials')">
            <span class="title is-6">Material</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'menu' ? false:true}" @click="getItems(selectSite = 'menu')">
            <span class="title is-6">Menu</span>
          </div>
          
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'supplier' ? false:true}" @click="getItems(selectSite = 'supplier')">
            <span class="title is-6">Supplier</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'employees' ? false:true}" @click="getItems(selectSite = 'employees')">
            <span class="title is-6">Employees</span>
          </div>
          
        </template>
      </div>

      
      <div class="column is-10 px-4  has-background-light is-rounded">
        <!-- Sales -->
        <div class="column is-full my-5" v-if="selectSite === 'sales'">
          <div class="columns">
            <div class="column is-full">
              <p class="title is-4 has-text-left">Sales
              <span style="float: right">
                <button class="button is-primary" >Add new record</button>
                <button class="button is-danger ml-3">Delete</button>
              </span>
              </p>
            </div>
          </div>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Income</th>
                <th></th>
              </tr>
            </thead>
            <tbody>             
              <tr v-for="sale in blogs" :key="sale.sale_id">
                <td>{{ sale.sale_id }}</td>
                <td>{{ sale.date.substring(0,10) }}</td>
                <td>{{ sale.income.toFixed(2) }}</td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th></th>
                    <th></th>
                    <th>Sum : {{ sumSales }}</th>
                    <th></th>
                </tr>
            </tfoot>
          </table>
        </div>
        
        <!-- Order -->
        <div class="column is-full my-5" v-if="selectSite === 'orders'">
          <p class="title is-4 has-text-left">Order Material
              <span style="float: right">
                <button class="button is-primary" >Add new record</button>
                <button class="button is-danger ml-3">Delete</button>
              </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>Order ID</th>
                <th>Date</th>
                <th>Name</th>
                <th>Unit</th>
                <!-- <th>Table no.</th> -->
              </tr>
            </thead>
            <tbody>
              <tr v-for="order in blogs" :key="order.order_id">
                <td>{{ order.order_id }}</td>
                <td>{{ order.buy_date.substring(0,10) }}</td>
                <td>{{ order.mats_name }}</td>
                <td>{{ order.unit }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Material -->
        <div class="column is-full my-5" v-if="selectSite === 'materials'">
          <p class="title is-4 has-text-left">Material
              <span style="float: right">
                <button class="button is-primary" >Add new record</button>
                <button class="button is-danger ml-3">Delete</button>
              </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>Material ID</th>
                <th>Name</th>
                <th>Material Left</th>
                <th>Price</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="mat in blogs" :key="mat.mats_id">
                <td>{{ mat.mats_id }}</td>
                <td>{{ mat.mats_name }}</td>
                <td :class="{'has-text-danger': mat.mats_left < 5 }">{{ mat.mats_left }}</td>
                <td>{{ mat.price.toFixed(2) }} </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Menu -->
        <div class="column is-full my-5" v-if="selectSite === 'menu'">
          <p class="title is-4 has-text-left">Menu
              <span style="float: right">
                <button class="button is-primary" >Add new record</button>
                <button class="button is-danger ml-3">Delete</button>
              </span>
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
              </tr>
            </thead>
            <tbody>
              <tr v-for="menu in blogs" :key="menu.menu_id">
                <td>{{ menu.menu_id }}</td>
                <td><img :src="menu.image" :alt="menu.menu_name"></td>
                <td>{{ menu.menu_name }}</td>
                <td>{{ menu.sale_price.toFixed(2) }}</td>
                <td>{{ menu.mats_cost.toFixed(2) }}</td>
                <td>{{ menu.description }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Month Account -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'month_account'">
          <p class="title is-4 has-text-left">Month Account
              <span style="float: right">
                <button class="button is-primary" >Add new record</button>
                <button class="button is-danger ml-3">Delete</button>
              </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Month</th>
                <th>Title</th>
                <th>Expense</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="month in blogs" :key="month.acc_id">
                <td>{{ month.acc_id }}</td>
                <td>{{ month.acc_month }}</td>
                <td>{{ month.title_exp }}</td>
                <td>{{ month.amount_exp.toFixed(2) }} </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th></th>
                <th></th>
                <th></th>
                <th>Sum : {{ sumMonthExp }}</th>
              </tr>
            </tfoot>
          </table>
        </div>

        <!-- Day Account -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'day_account'">
          <p class="title is-4 has-text-left">Day Account
              <span style="float: right">
                <button class="button is-primary" >Add new record</button>
                <button class="button is-danger ml-3">Delete</button>
              </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Income</th>
                <th>Expense</th>
                <th>Tip</th>
                <th>Balance</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="day in blogs" :key="day.acc_id">
                <td>{{ day.acc_id }}</td>
                <td>{{ day.acc_date.substring(8,10) }}</td>
                <td class="has-text-success">{{ day.sale_income.toFixed(2) }} </td>
                <td class="has-text-danger">{{ day.mats_expense.toFixed(2) }} </td>
                <td>{{ day.tip.toFixed(2) }}</td>
                <td>{{ day.balance.toFixed(2) }}</td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th colspan="2" class="has-text-left pl-5">Sum</th>
                <th>{{ sumDayIncome }}</th>
                <th>{{ sumDayExp }}</th>
                <th>{{ sumDayTip }}</th>
                <th>{{ sumDayBalance }}</th>
              </tr>
            </tfoot>
          </table>
        </div>

        <!-- Suplier -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'supplier'">
          <h1 class="title is-4 has-text-left">Supplier</h1>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Material Name</th>
                <th>Unit</th>
                <th>Price</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="sup in blogs" :key="sup.sup_id">
                <td>{{ sup.sup_id }}</td>
                <td>{{ sup.sup_name }}</td>
                <td>{{ sup.phone }}</td>
                <td>{{ sup.mats_name }}</td>
                <td>{{ sup.unit }}</td>
                <td>{{ sup.total_price }} </td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <!-- Employees -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'employees'">
          <p class="title is-4 has-text-left">Employees
              <span style="float: right">
                <button class="button is-primary" >Add new record</button>
                <button class="button is-danger ml-3">Delete</button>
              </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>First name</th>
                <th>Last name</th>
                <!-- <th>Phone</th> -->
                <th>Salary</th>
                <th>Position</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="emp in blogs" :key="emp.emp_id">
                <td>{{ emp.emp_id }}</td>
                <td>{{ emp.fname }}</td>
                <td>{{ emp.lname }}</td>
                <!-- <td></td> -->
                <td>{{ emp.salary }}</td>
                <td>{{ emp.position }}</td>
              </tr>
            </tbody>
          </table>
        </div>
        
      </div>
    </div>
    
  </section>
</template>
<script>
import axios from "axios";

export default {
  name: 'manager',
  month_list: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
  data() {
    return {
      selectSite: 'sales',
      blogs: [],
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    getItems() {
      axios
        .get("http://localhost:3000/manager/"+this.selectSite)
        .then((response) => {
          console.log(response);
          this.blogs = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
  computed: {
    sumSales() {
      var sum = 0
      this.blogs.forEach(val => sum += val.income);
      return sum.toFixed(2)
    },
    sumMonthExp() {
      var sum = 0
      this.blogs.forEach(val => sum += val.amount_exp);
      return sum.toFixed(2)
    },
    sumDayIncome() {
      var sum = 0
      this.blogs.forEach(val => sum += val.sale_income);
      return sum.toFixed(2)
    },
    sumDayExp() {
      var sum = 0
      this.blogs.forEach(val => sum += val.mats_expense);
      return sum.toFixed(2)
    },
    sumDayTip() {
      var sum = 0
      this.blogs.forEach(val => sum += val.tip);
      return sum.toFixed(2)
    },
    sumDayBalance() {
      var sum = 0
      this.blogs.forEach(val => sum += val.balance);
      return sum.toFixed(2)
    }
  },
};
</script>

<style scoped>
  tr{
    line-height: 3rem;
  }
  .orange{
    background-color: #FFA101;
  }
  .light-orange{
    background-color: #FAE6B1;
  }

</style>
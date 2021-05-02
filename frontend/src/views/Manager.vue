<template>
  <section id="app">
    <div class="columns orange">
      <div class="column is-2 py-5 pl-5">  
        <!-- <header class="card-header pb-5 orange">
          <img src="../assets/logo.png" alt="" width="100%">
        </header> -->

        <!-- item bar -->
        <template>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'sales' ? false:true}" @click="selectSite = 'sales'">
            <span class="title is-6">Sales</span>
          </div>      
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'materials' ? false:true}" @click="selectSite = 'materials'">
            <span class="title is-6">Material</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'menu' ? false:true}" @click="selectSite = 'menu'">
            <span class="title is-6">Menu</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'orders' ? false:true}" @click="selectSite = 'orders'">
            <span class="title is-6">Order</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'supplier' ? false:true}" @click="selectSite = 'supplier'">
            <span class="title is-6">Suplier</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'employees' ? false:true}" @click="selectSite = 'employees'">
            <span class="title is-6">Employees</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'day_account' ? false:true}" @click="selectSite = 'day_account'">
            <span class="title is-6">Day Account</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'month_account' ? false:true}" @click="selectSite = 'month_account'">
            <span class="title is-6">Month Account</span>
          </div>
          {{blogs}}
        </template>
      </div>

      
      <div class="column is-10 px-4  has-background-light is-rounded">
        <!-- Sales -->
        <div class="column is-full my-5" v-if="selectSite === 'sales'">
          <div class="columns">
            <div class="column is-full">
              <p class="title is-4 has-text-left">Sales
              <span style="float: right">
                <button class="button is-primary" @click="getItems">Add new record</button>
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
              <tr>
                <td>1</td>
                <td>2021-04-16</td>
                <td>213.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>2</td>
                <td>2021-04-17</td>
                <td>212.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>3</td>
                <td>2021-04-18</td>
                <td>302.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>4</td>
                <td>2021-04-18</td>
                <td>255.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>5</td>
                <td>2021-04-19</td>
                <td>315.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>6</td>
                <td>2021-04-19</td>
                <td>242.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>7</td>
                <td>2021-04-19</td>
                <td>306.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>8</td>
                <td>2021-04-20</td>
                <td>318.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>9</td>
                <td>2021-04-21</td>
                <td>432.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>10</td>
                <td>2021-04-21</td>
                <td>492.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>11</td>
                <td>2021-04-22</td>
                <td>145.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>12</td>
                <td>2021-04-22</td>
                <td>200.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>13</td>
                <td>2021-04-23</td>
                <td>117.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>14</td>
                <td>2021-04-23</td>
                <td>215.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
              <tr>
                <td>15</td>
                <td>2021-04-24</td>
                <td>268.00 </td>
                <td><i class="fa fa-edit"></i></td>
              </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th></th>
                    <th></th>
                    <th>Sum : 4073.00</th>
                    <th></th>
                </tr>
            </tfoot>
          </table>
        </div>
        <!-- <div class="is-full has-text-right pr-4">
          <button class="button is-outlined mr-4">Delete</button>
          <button class="button is-primary">Add</button>
        </div> -->
        
        <!-- Order -->
        <div class="column is-full my-5" v-if="selectSite === 'orders'">
          <h1 class="title is-4 has-text-left">Order</h1>
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
              <tr>
                <td>1</td>
                <td>2020-01-01</td>
                <td>Cucumber</td>
                <td>19</td>
              </tr>
              <tr>
                <td>2</td>
                <td>2020-01-01</td>
                <td>chicken</td>
                <td>6</td>
              </tr>
              <tr>
                <td>3</td>
                <td>2020-01-01</td>
                <td>Cola</td>
                <td>2</td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Material -->
        <div class="column is-full my-5" v-if="selectSite === 'materials'">
          <h1 class="title is-4 has-text-left">Material</h1>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>Material ID</th>
                <th>Name</th>
                <th>Material Left</th>
                <th>Price</th>
                <!-- <th>Table no.</th> -->
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>Cucumber</td>
                <td class="has-text-danger">0</td>
                <td>20.00 </td>
              </tr>
              <tr>
                <td>2</td>
                <td>Chicken</td>
                <td>14</td>
                <td>150.00 </td>
              </tr>
              <tr>
                <td>3</td>
                <td>Cola</td>
                <td>18</td>
                <td>12.00 </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Menu -->
        <div class="column is-full my-5" v-if="selectSite === 'menu'">
          <h1 class="title is-4 has-text-left">Menu</h1>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th class="is-2">Image</th>
                <th class="is-1">ID</th>
                <th class="is-2">Name</th>
                <th class="is-2">Price</th>
                <th class="is-2">Cost</th>
                <th class="is-3">Description</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td></td>
                <td>1</td>
                <td>Cucumber</td>
                <td>0</td>
                <td>20.00 </td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td>2</td>
                <td>Cucumber</td>
                <td>0</td>
                <td>20.00 </td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td>3</td>
                <td>Cucumber</td>
                <td>0</td>
                <td>20.00 </td>
                <td></td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Month Account -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'month_account'">
          <h1 class="title is-4 has-text-left">Month Account</h1>
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
              <tr>
                <td>1</td>
                <td>Jan</td>
                <td>Buy DB</td>
                <td class="has-text-danger">15.00 </td>
              </tr>
              <tr>
                <td>2</td>
                <td>May</td>
                <td>Buy Console</td>
                <td class="has-text-danger">200.00 </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th></th>
                <th></th>
                <th></th>
                <th>Sum</th>
              </tr>
            </tfoot>
          </table>
        </div>

        <!-- Day Account -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'day_account'">
          <h1 class="title is-4 has-text-left">Day Account</h1>
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
              <tr>
                <td>1</td>
                <td>01</td>
                <td class="has-text-success">300.00 </td>
                <td class="has-text-danger">150.00 </td>
                <td>0.00 </td>
                <td>150.00 </td>
              </tr>
              <tr>
                <td>2</td>
                <td>05</td>
                <td class="has-text-success">160.00 </td>
                <td class="has-text-danger">200.00 </td>
                <td>20.00 </td>
                <td class="has-text-danger">-20.00 </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th></th>
                <th></th>
                <th>Sum : 460.00</th>
                <th>Sum : 350.00</th>
                <th>Sum : 20.00</th>
                <th>Sum : 130.00</th>
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
              <tr>
                <td>1</td>
                <td>SOS Cucumber</td>
                <td>088-888-8888</td>
                <td>Cucumber</td>
                <td>40</td>
                <td>5.00 </td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <!-- Employees -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'employees'">
          <h1 class="title is-4 has-text-left">Employees</h1>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>First name</th>
                <th>Last name</th>
                <th>Phone</th>
                <th>Salary</th>
                <th>Position</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>A</td>
                <td>Lert</td>
                <td>011-111-1111</td>
                <td>15,000</td>
                <td>Chief</td>
              </tr>
              <tr>
                <td>2</td>
                <td>B</td>
                <td>Udom</td>
                <td>012-122-2222</td>
                <td>13,000</td>
                <td>Cashier</td>
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
        .get("http://localhost:3000/manager/"+this.selectSite, {test: 'It\'s OK!!'})
        // .then((response) => {
        //   console.log(response);
        //   this.blogs = response.data;
        // })
        // .catch((err) => {
        //   console.log(err);
        // });
    },
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
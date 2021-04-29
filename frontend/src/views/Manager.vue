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
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'material' ? false:true}" @click="selectSite = 'material'">
            <span class="title is-6">Material</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'menu' ? false:true}" @click="selectSite = 'menu'">
            <span class="title is-6">Menu</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'order' ? false:true}" @click="selectSite = 'order'">
            <span class="title is-6">Order</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'supplier' ? false:true}" @click="selectSite = 'supplier'">
            <span class="title is-6">Suplier</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'employee' ? false:true}" @click="selectSite = 'employee'">
            <span class="title is-6">Employees</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'day' ? false:true}" @click="selectSite = 'day'">
            <span class="title is-6">Day Account</span>
          </div>
          <div class="button is-full box my-3 is-rounded is-light" :class="{'light-orange': selectSite === 'month' ? false:true}" @click="selectSite = 'month'">
            <span class="title is-6">Month Account</span>
          </div>
          
        </template>
      </div>

      <div class="column is-10 px-4  has-background-light is-rounded">
        <!-- Sales -->
        <div class="column is-full my-6" v-if="selectSite === 'sales'">
          <h1 class="title is-4">Sales</h1>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Income</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>2020-01-01</td>
                <td>300.00 </td>
              </tr>
              <tr>
                <td>2</td>
                <td>2020-01-02</td>
                <td>1000.00 </td>
              </tr>
              <tr>
                <td>3</td>
                <td>2020-01-06</td>
                <td>2000.00 </td>
              </tr>
              <tr>
                <td>4</td>
                <td>2020-01-08</td>
                <td>2300.00 </td>
              </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th></th>
                    <th></th>
                    <th>Sum : 5600</th>
                </tr>
            </tfoot>
          </table>
        </div>
        <!-- <div class="is-full has-text-right pr-4">
          <button class="button is-outlined mr-4">Delete</button>
          <button class="button is-primary">Add</button>
        </div> -->
        
        <!-- Order -->
        <div class="column is-full my-6" v-if="selectSite === 'order'">
          <h1 class="title is-4">Order</h1>
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
                <td>20</td>
              </tr>
              <tr>
                <td>2</td>
                <td>2020-01-01</td>
                <td>Chicken</td>
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
        <div class="column is-full my-6" v-if="selectSite === 'material'">
          <h1 class="title is-4">Material</h1>
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
        <div class="column is-full my-6" v-if="selectSite === 'menu'">
          <h1 class="title is-4">Menu</h1>
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
        <div class="column is-full mx-1 my-6" v-if="selectSite === 'month'">
          <h1 class="title is-4">Month Account</h1>
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
        <div class="column is-full mx-1 my-6" v-if="selectSite === 'day'">
          <h1 class="title is-4">Day Account</h1>
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
        <div class="column is-full mx-1 my-6" v-if="selectSite === 'supplier'">
          <h1 class="title is-4">Supplier</h1>
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
        <div class="column is-full mx-1 my-6" v-if="selectSite === 'employee'">
          <h1 class="title is-4">Employees</h1>
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
export default {
  data() {
    return {
      selectSite: 'sales',
    };
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
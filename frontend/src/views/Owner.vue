<template>
  <section id="app">
    <div class="columns">
      <div class="column is-2 pl-6 py-6">
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Material</span>
        </div>
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Menu</span>
        </div>
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Order</span>
        </div>
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Promotion</span>
        </div>
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Suplier</span>
        </div>
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Employees</span>
        </div>
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Account</span>
        </div>
        <div class="button is-full is-primary box my-2">
          <span class="title is-6">Sales</span>
        </div>
      </div>
      <div class="column is-8">
        <!-- Sales -->
        <div class="column is-full my-6">
          <h1 class="title is-4">Sales ...</h1>
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
                <td>300.00 $</td>
              </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th></th>
                    <th></th>
                    <th>Sum</th>
                </tr>
            </tfoot>
          </table>
        </div>

        <!-- Order -->
        <div class="column is-full my-6">
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
        <div class="column is-full my-6">
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
                <td>20.00 $</td>
              </tr>
              <tr>
                <td>2</td>
                <td>Chicken</td>
                <td>14</td>
                <td>150.00 $</td>
              </tr>
              <tr>
                <td>3</td>
                <td>Cola</td>
                <td>18</td>
                <td>12.00 $</td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Month Account -->
        <div class="column is-full mx-1 my-6">
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
                <td class="has-text-danger">15.00 $</td>
              </tr>
              <tr>
                <td>2</td>
                <td>May</td>
                <td>Buy Console</td>
                <td class="has-text-danger">200.00 $</td>
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
        <div class="column is-full mx-1 my-6">
          <h1 class="title is-4">Day Account for ...</h1>
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
                <td class="has-text-success">20.00 $</td>
                <td class="has-text-danger">15.00 $</td>
                <td>0.00 $</td>
                <td>5.00 $</td>
              </tr>
              <tr>
                <td>2</td>
                <td>05</td>
                <td class="has-text-success">160.00 $</td>
                <td class="has-text-danger">200.00 $</td>
                <td>20.00 $</td>
                <td class="has-text-danger">-20.00 $</td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th></th>
                <th></th>
                <th>Sum</th>
                <th>Sum</th>
                <th>Sum</th>
                <th>Sum</th>
              </tr>
            </tfoot>
          </table>
        </div>

        <!-- Suplier -->
        <div class="column is-full mx-1 my-6">
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
                <td>5.00 $</td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <!-- Employees -->
        <div class="column is-full mx-1 my-6">
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
    return {};
  },
};
</script>

<style scoped>
</style>
<template>
  <section id="app">
    <div class="columns orange" style="min-height: 100vh; ">
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
              <p class="title is-4 has-text-left">Order Food
                <span style="float: right" v-if="!del">
                  <button class="button is-primary" @click="newRecord">New Order</button>
                  <button class="button is-danger ml-3" @click="del = true">Delete</button>
                </span>
                <span style="float: right" v-else>
                  <button class="button is-danger">Confirm</button>
                  <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
                </span>
              </p>
            </div>
          </div>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>ID</th>
                <th>Date</th>
                <th>Income</th>
                <th></th>
              </tr>
            </thead>
            <tbody>             
              <tr v-for="sale in blogs" :key="'sale'+sale.sale_id">
                <td v-if="del"><input type="checkbox" :name="sale.sale_id" :id="sale.sale_id" v-model="delCol" style="cursor: pointer"></td>
                <td>{{ sale.sale_id }}</td>
                <td>{{ sale.date.substring(0,10) }}</td>
                <td>{{ sale.income.toFixed(2) }}</td>
                <td @click="editModals(sale)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th v-if="del"></th>
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
            <span style="float: right" v-if="!del">
              <button class="button is-primary" @click="newRecord">New Order</button>
              <button class="button is-danger ml-3" @click="del = true">Delete</button>
            </span>
            <span style="float: right" v-else>
              <button class="button is-danger">Confirm</button>
              <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
            </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>Order ID</th>
                <th>Date</th>
                <th>Name</th>
                <th>Unit</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="order in blogs" :key="'order'+order.order_id">
                <td v-if="del"><input type="checkbox" :name="order.order_id" :id="order.order_id"  style="cursor: pointer"></td>
                <td>{{ order.order_id }}</td>
                <td>{{ order.buy_date.substring(0,10) }}</td>
                <td>{{ order.mats_name }}</td>
                <td>{{ order.unit }}</td>
                <td  @click="editModals(order)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Material -->
        <div class="column is-full my-5" v-if="selectSite === 'materials'">
          <p class="title is-4 has-text-left">Material
            <span style="float: right" v-if="!del">
              <button class="button is-primary" @click="newRecord">New Material</button>
              <button class="button is-danger ml-3" @click="del = true">Delete</button>
            </span>
            <span style="float: right" v-else>
              <button class="button is-danger">Confirm</button>
              <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
            </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>Material ID</th>
                <th>Name</th>
                <th>Material Left</th>
                <th>Price</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="mat in blogs" :key="'mat'+mat.mats_id">
                <td v-if="del"><input type="checkbox" :name="mat.mats_id" :id="mat.mats_id" style="cursor: pointer"></td>
                <td>{{ mat.mats_id }}</td>
                <td>{{ mat.mats_name }}</td>
                <td :class="{'has-text-danger': mat.mats_left < 5 }">{{ mat.mats_left }}</td>
                <td>{{ mat.price.toFixed(2) }} </td>
                <td @click="editModals(mat)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Menu -->
        <div class="column is-full my-5" v-if="selectSite === 'menu'">
          <p class="title is-4 has-text-left">Menu
            <span style="float: right" v-if="!del">
              <button class="button is-primary" @click="newRecord">New Menu</button>
              <button class="button is-danger ml-3" @click="del = true">Delete</button>
            </span>
            <span style="float: right" v-else>
              <button class="button is-danger">Confirm</button>
              <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
            </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Price</th>
                <th>Cost</th>
                <th>Description</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="menu in blogs" :key="'menu'+menu.menu_id">
                <td v-if="del"><input type="checkbox" :name="menu.menu_id" :id="menu.menu_id" style="cursor: pointer"></td>
                <td>{{ menu.menu_id }}</td>
                <td><img :src="menu.image" :alt="menu.menu_name" width="170px"></td>
                <td>{{ menu.menu_name }}</td>
                <td>{{ menu.sale_price.toFixed(2) }}</td>
                <td>{{ menu.mats_cost.toFixed(2) }}</td>
                <td>{{ menu.description }}</td>
                <td @click="editModals(menu)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Month Account -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'month_account'">
          <p class="title is-4 has-text-left">Month Account
            <span style="float: right" v-if="!del">
              <button class="button is-primary" @click="newRecord">New Record</button>
              <button class="button is-danger ml-3" @click="del = true">Delete</button>
            </span>
            <span style="float: right" v-else>
              <button class="button is-danger">Confirm</button>
              <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
            </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>ID</th>
                <th>Month</th>
                <th>Title</th>
                <th>Expense</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="month in blogs" :key="'month'+month.acc_id">
                <td v-if="del"><input type="checkbox" :name="month.acc_id" :id="month.acc_id" style="cursor:pointer"></td>
                <td>{{ month.acc_id }}</td>
                <td>{{ month.acc_month }}</td>
                <td>{{ month.title_exp }}</td>
                <td>{{ month.amount_exp.toFixed(2) }} </td>
                <td @click="editModals(month)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th v-if="del"></th>
                <th></th>
                <th></th>
                <th></th>
                <th>Sum : {{ sumMonthExp }}</th>
                <td></td>
              </tr>
            </tfoot>
          </table>
        </div>

        <!-- Day Account -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'day_account'">
          <p class="title is-4 has-text-left">Day Account
            <span style="float: right" v-if="!del">
              <button class="button is-primary" @click="newRecord">New Record</button>
              <button class="button is-danger ml-3" @click="del = true">Delete</button>
            </span>
            <span style="float: right" v-else>
              <button class="button is-danger">Confirm</button>
              <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
            </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>ID</th>
                <th>Date</th>
                <th>Income</th>
                <th>Expense</th>
                <th>Tip</th>
                <th>Balance</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="day in blogs" :key="'day'+day.acc_id">
                <td v-if="del"><input type="checkbox" :name="day.acc_id" :id="day.acc_id" style="cursor: pointer"></td>
                <td>{{ day.acc_id }}</td>
                <td>{{ day.acc_date.substring(8,10) }}</td>
                <td class="has-text-success">{{ day.sale_income.toFixed(2) }} </td>
                <td class="has-text-danger">{{ day.mats_expense.toFixed(2) }} </td>
                <td>{{ day.tip.toFixed(2) }}</td>
                <td>{{ day.balance.toFixed(2) }}</td>
                <td @click="editModals(day)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th v-if="del"></th>
                <th colspan="2" class="has-text-left pl-5">Sum</th>
                <th>{{ sumDayIncome }}</th>
                <th>{{ sumDayExp }}</th>
                <th>{{ sumDayTip }}</th>
                <th>{{ sumDayBalance }}</th>
                <th></th>
              </tr>
            </tfoot>
          </table>
        </div>

        <!-- Suplier -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'supplier'">
          <p class="title is-4 has-text-left">Supplier
            <span style="float: right" v-if="!del">
              <button class="button is-primary" @click="newRecord">New Supplier</button>
              <button class="button is-danger ml-3" @click="del = true">Delete</button>
            </span>
            <span style="float: right" v-else>
              <button class="button is-danger">Confirm</button>
              <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
            </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Material Name</th>
                <th>Unit</th>
                <th>Price</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="sup in blogs" :key="'sup'+sup.sup_id">
                <td v-if="del"><input type="checkbox" :name="sup.sup_id" :id="sup.sup_id" style="cursor: pointer"></td>
                <td>{{ sup.sup_id }}</td>
                <td>{{ sup.sup_name }}</td>
                <td>{{ sup.phone }}</td>
                <td>{{ sup.mats_name }}</td>
                <td>{{ sup.unit }}</td>
                <td>{{ sup.total_price }} </td>
                <td @click="editModals(sup)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <!-- Employees -->
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'employees'">
          <p class="title is-4 has-text-left">Employees
            <span style="float: right" v-if="!del">
              <button class="button is-primary" @click="newRecord">New Employee</button>
              <button class="button is-danger ml-3" @click="del = true">Delete</button>
            </span>
            <span style="float: right" v-else>
              <button class="button is-danger">Confirm</button>
              <button class="button is-danger is-light ml-3" @click="del = false">Cancel</button>
            </span>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th v-if="del"></th>
                <th>ID</th>
                <th>First name</th>
                <th>Last name</th>
                <!-- <th>Phone</th> -->
                <th>Salary</th>
                <th>Position</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="emp in blogs" :key="'emp'+emp.emp_id">
                <td v-if="del"><input type="checkbox" :name="emp.emp_id" :id="emp.emp_id" style="cursor: pointer"></td>
                <td>{{ emp.emp_id }}</td>
                <td>{{ emp.fname }}</td>
                <td>{{ emp.lname }}</td>
                <!-- <td></td> -->
                <td>{{ emp.salary }}</td>
                <td>{{ emp.position }}</td>
                <td @click="editModals(emp)"><i class="fa fa-edit" style="cursor: pointer"></i></td>
              </tr>
            </tbody>
          </table>
        </div>
        
      </div>
    </div>

    <!-- Edit modal -->
    <div class="modal" :class="{'is-active': saleModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit {{ selectSite }} ID: {{ editId }}</p>
          <button class="delete" aria-label="close" @click="saleModal = false, clearEdit()"></button>
        </header>
        <section class="modal-card-body">
          <!-- for sales -->
          <div class="columns" style="color: black;" v-if="selectSite === 'sales'">
            <div class="column is-5 has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="editDate">
            </div>
            <div class="column is-7 has-text-left">Income: <br>
              <input class="input mt-4" type="number" v-model="editIncome">
            </div>
          </div>
          <!-- for orders -->
          <div class="columns" style="color: black;" v-if="selectSite === 'orders'">
            <div class="column is-5 has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="editDate">
            </div>
            <div class="column is-4 has-text-left">Name: <br>
              <input class="input mt-4" type="text" v-model="editMatName">
            </div>
            <div class="column is-3 has-text-left">Unit: <br>
              <input class="input mt-4" type="number" v-model="editUnit">
            </div>
          </div>
          <!-- for materials -->
          <div class="columns" style="color: black;" v-if="selectSite === 'materials'">
            <div class="column is-4 has-text-left">Name: <br>
              <input class="input mt-4" type="text" v-model="editMatName">
            </div>
            <div class="column is-5 has-text-left">Material Left: <br>
              <input class="input mt-4" type="number" v-model="editLeft">
            </div>
            <div class="column is-3 has-text-left">Price: <br>
              <input class="input mt-4" type="number" v-model="editPrice">
            </div>
          </div>
          <!-- for menu -->
          <span v-if="selectSite === 'menu'">
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Image: <br>
                <input class="input mt-4" type="url" v-model="editImage">
              </div>
              <div class="column is-6 has-text-left">Name: <br>
                <input class="input mt-4" type="text" v-model="editMatName">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Price: <br>
                <input class="input mt-4" type="number" v-model="editPrice">
              </div>
              <div class="column is-6 has-text-left">Cost: <br>
                <input class="input mt-4" type="number" v-model="editCost">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-full has-text-left">Description: <br>
                <textarea class="textarea mt-4" v-model="editDescrip"></textarea>
              </div>
            </div>
          </span>
          <!-- for month account -->
          <div class="columns" style="color: black;" v-if="selectSite === 'month_account'">
            <div class="column is-3 has-text-left">Month: <br>
              <input class="input mt-4" type="text" v-model="editMonth">
            </div>
            <div class="column is-5 has-text-left">Title: <br>
              <input class="input mt-4" type="text" v-model="editTitle">
            </div>
            <div class="column is-4 has-text-left">Expense: <br>
              <input class="input mt-4" type="number" v-model="editExp">
            </div>
          </div>
          <!-- for day account -->
          <span v-if="selectSite === 'day_account'">
            <div class="columns" style="color: black;">
              <div class="column is-full has-text-left">Date: <br>
                <input class="input mt-4" type="text" v-model="editDate">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Income: <br>
                <input class="input mt-4" type="number" v-model="editIncome">
              </div>
              <div class="column is-6 has-text-left">Expense: <br>
                <input class="input mt-4" type="number" v-model="editExp">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Tip: <br>
                <input class="input mt-4" type="number" v-model="editTip">
              </div>
              <div class="column is-6 has-text-left">Balance: <br>
                <input class="input mt-4" type="number" v-model="editBalance">
              </div>
            </div>
          </span>
          <!-- for supplier -->
          <span v-if="selectSite === 'supplier'">
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Name: <br>
                <input class="input mt-4" type="text" v-model="editSupName">
              </div>
              <div class="column is-6 has-text-left">Phone: <br>
                <input class="input mt-4" type="text" v-model="editPhone">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-full has-text-left">Material Name: <br>
                <input class="input mt-4" type="text" v-model="editMatName">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Unit: <br>
                <input class="input mt-4" type="number" v-model="editUnit">
              </div>
              <div class="column is-6 has-text-left">Price: <br>
                <input class="input mt-4" type="number" v-model="editPrice">
              </div>
            </div>
          </span>
          <!-- for employees -->
          <span v-if="selectSite === 'employees'">
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">First Name: <br>
                <input class="input mt-4" type="text" v-model="editFname">
              </div>
              <div class="column is-6 has-text-left">Last Name: <br>
                <input class="input mt-4" type="text" v-model="editLname">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Salary: <br>
                <input class="input mt-4" type="number" v-model="editSalary">
              </div>
              <div class="column is-6 has-text-left">Position: <br>
                <input class="input mt-4" type="text" v-model="editPosition">
              </div>
            </div>
          </span>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="saveEditModals">Save changes</button>
          <button class="button" @click="saleModal = false, clearEdit()">Cancel</button>
        </footer>
      </div>
    </div>

    <!-- new sale modal -->
    <div class="modal" :class="{'is-active': newSaleModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Add new {{ selectSite }}</p>
          <button class="delete" aria-label="close" @click="newSaleModal = false, clearEdit()"></button>
        </header>
        <section class="modal-card-body">
          <!-- for sales -->
          <div class="columns" style="color: black;" v-if="selectSite === 'sales'">
            <div class="column is-5 has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="editDate">
            </div>
            <div class="column is-7 has-text-left">Income: <br>
              <input class="input mt-4" type="number" v-model="editIncome">
            </div>
          </div>
          <!-- for orders -->
          <div class="columns" style="color: black;" v-if="selectSite === 'orders'">
            <div class="column is-5 has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="editDate">
            </div>
            <div class="column is-4 has-text-left">Name: <br>
              <input class="input mt-4" type="text" v-model="editMatName">
            </div>
            <div class="column is-3 has-text-left">Unit: <br>
              <input class="input mt-4" type="number" v-model="editUnit">
            </div>
          </div>
          <!-- for materials -->
          <div class="columns" style="color: black;" v-if="selectSite === 'materials'">
            <div class="column is-4 has-text-left">Name: <br>
              <input class="input mt-4" type="text" v-model="editMatName">
            </div>
            <div class="column is-5 has-text-left">Material Left: <br>
              <input class="input mt-4" type="number" v-model="editLeft">
            </div>
            <div class="column is-3 has-text-left">Price: <br>
              <input class="input mt-4" type="number" v-model="editPrice">
            </div>
          </div>
          <!-- for menu -->
          <span v-if="selectSite === 'menu'">
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Image: <br>
                <input class="input mt-4" type="url" v-model="editImage">
              </div>
              <div class="column is-6 has-text-left">Name: <br>
                <input class="input mt-4" type="text" v-model="editMatName">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Price: <br>
                <input class="input mt-4" type="number" v-model="editPrice">
              </div>
              <div class="column is-6 has-text-left">Cost: <br>
                <input class="input mt-4" type="number" v-model="editCost">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-full has-text-left">Description: <br>
                <textarea class="textarea mt-4" v-model="editDescrip"></textarea>
              </div>
            </div>
          </span>
          <!-- for month account -->
          <div class="columns" style="color: black;" v-if="selectSite === 'month_account'">
            <div class="column is-3 has-text-left">Month: <br>
              <input class="input mt-4" type="text" v-model="editMonth">
            </div>
            <div class="column is-5 has-text-left">Title: <br>
              <input class="input mt-4" type="number" v-model="editTitle">
            </div>
            <div class="column is-4 has-text-left">Expense: <br>
              <input class="input mt-4" type="number" v-model="editExp">
            </div>
          </div>
          <!-- for day account -->
          <span v-if="selectSite === 'day_account'">
            <div class="columns" style="color: black;">
              <div class="column is-full has-text-left">Date: <br>
                <input class="input mt-4" type="text" v-model="editDate">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Income: <br>
                <input class="input mt-4" type="number" v-model="editIncome">
              </div>
              <div class="column is-6 has-text-left">Expense: <br>
                <input class="input mt-4" type="number" v-model="editExp">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Tip: <br>
                <input class="input mt-4" type="number" v-model="editTip">
              </div>
              <div class="column is-6 has-text-left">Balance: <br>
                <input class="input mt-4" type="number" v-model="editBalance">
              </div>
            </div>
          </span>
          <!-- for supplier -->
          <span v-if="selectSite === 'supplier'">
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Name: <br>
                <input class="input mt-4" type="text" v-model="editSupName">
              </div>
              <div class="column is-6 has-text-left">Phone: <br>
                <input class="input mt-4" type="text" v-model="editPhone">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-full has-text-left">Material Name: <br>
                <input class="input mt-4" type="text" v-model="editMatName">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Unit: <br>
                <input class="input mt-4" type="number" v-model="editUnit">
              </div>
              <div class="column is-6 has-text-left">Price: <br>
                <input class="input mt-4" type="number" v-model="editPrice">
              </div>
            </div>
          </span>
          <!-- for employees -->
          <span v-if="selectSite === 'employees'">
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">First Name: <br>
                <input class="input mt-4" type="text" v-model="editFname">
              </div>
              <div class="column is-6 has-text-left">Last Name: <br>
                <input class="input mt-4" type="text" v-model="editLname">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Salary: <br>
                <input class="input mt-4" type="number" v-model="editSalary">
              </div>
              <div class="column is-6 has-text-left">Position: <br>
                <input class="input mt-4" type="text" v-model="editPosition">
              </div>
            </div>
          </span>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-success" @click="newRecord">Save changes</button>
          <button class="button" @click="newSaleModal = false, clearEdit()">Cancel</button>
        </footer>
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
      saleModal: false,
      newSaleModal: false,
      del: false,
      editId: 0,
      editDate: '',
      editIncome: 0,
      editMatName: '',
      editUnit: 0,
      editLeft: 0,
      editPrice: 0,
      editImage: '',
      editCost: 0,
      editDescrip: '',
      editMonth: 0,
      editTitle: '',
      editExp: 0,
      editTip: 0,
      editBalance: 0,
      editPhone: '',
      editSupName: '',
      editFname: '',
      editLname: '',
      editSalary: 0,
      editPosition: '',
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    getItems() {
      this.del = false
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
    clearEdit() {
      this.editId = 0
      this.editDate = ''
      this.editIncome = 0
    },
    editModals(item) {
      this.saleModal = true
      if(this.selectSite === 'sales'){
        // if select order food
        this.editId = item.sale_id
        this.editDate = item.date.substring(0,10)
        this.editIncome = item.income
      } 
      else if(this.selectSite === 'orders'){
        // if select order material
        this.editId = item.order_id
        this.editDate = item.buy_date.substring(0,10)
        this.editMatName = item.mats_name
        this.editUnit = item.unit
      }
      else if(this.selectSite === 'materials'){
        this.editId = item.mats_id
        this.editMatName = item.mats_name
        this.editLeft = item.mats_left
        this.editPrice = item.price
      }
      else if(this.selectSite === 'menu'){
        this.editId = item.menu_id
        this.editImage = item.image
        this.editMatName = item.menu_name
        this.editPrice = item.price
        this.editCost = item.mats_cost
        this.editDescrip = item.description
      }
      else if(this.selectSite === 'month_account'){
        this.editId = item.acc_id
        this.editMonth = item.acc_month
        this.editTitle = item.title_exp
        this.editExp = item.amount_exp
      }
      else if(this.selectSite === 'day_account'){
        this.editId = item.acc_id
        this.editDate = item.acc_date.substring(8,10)
        this.editIncome = item.sale_income
        this.editExp = item.mats_expense
        this.editTip = item.tip
        this.editBalance = item.balance
      }
      else if(this.selectSite === 'supplier'){
        this.editId = item.sup_id
        this.editSupName = item.sup_name
        this.editPhone = item.phone
        this.editMatName = item.mats_name
        this.editUnit = item.unit
        this.editPrice = item.total_price
      }
      else if(this.selectSite === 'employees'){
        this.editId = item.emp_id
        this.editFname = item.fname
        this.editLname = item.lname
        this.editSalary = item.salary
        this.editPosition = item.position
      }
    },
    saveEditModals() {
      // let formData = new FormData();
      // formData.append("sale_id", );
      // formData.append("date", );
      // formData.append("income", );
      axios
      .put("http://localhost:3000/manager/" + this.selectSite, {
        'sale_id': this.editId,
        'date': this.editDate,
        'income': this.editIncome
      })
        .then((res) => {
          this.blogs.forEach(val => {
            if(val.sale_id == res.data.id){
              val.date = res.data.date
              val.income = res.data.income
            }
          })
          this.saleModal = false
          this.clearEdit()
        })
        .catch((e) => console.log(e));
    },
    newRecord() {
      this.newSaleModal = true
      // axios
      // .post("http://localhost:3000/manager/" + this.selectSite, {
      //   'sale_id': this.editId,
      //   'date': this.editDate,
      //   'income': this.editIncome
      // })
      //   .then((res) => {
      //     this.blogs.forEach(val => {
      //       if(val.sale_id == res.data.id){
      //         val.date = res.data.date
      //         val.income = res.data.income
      //       }
      //     })
      //     this.newSaleModal = false
      //     this.clearEdit()
      //   })
      //   .catch((e) => console.log(e));
    },
  },
  computed: {
    sumSales() {
      var sum = 0
      this.blogs.forEach(val => sum += val.income);
      return sum
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
  /* #app{
     height: 10000px;
     width: 100%;
  } */
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
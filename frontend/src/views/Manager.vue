<template>
  <section id="app">
    <div class="columns orange" style="min-height: 100vh; ">
      <div class="column is-2 py-5 pl-5">  

        <template>
          <div class="button is-full box my-3 is-rounded is-light" 
            :class="[{'light-orange': !(selectSite === tab)} ]" 
            v-for="tab in tabs" 
            :key="tab" 
            @click="selectSite = tab" >
            <span class="title is-6">{{tab}}</span>
          </div>
        </template>
      </div>      

      <div class="column is-10 px-4  has-background-light is-rounded mb-5">
        <component :is="selectSite"></component>
        
        <!-- <div class="column is-full my-5" v-if="selectSite === 'sales'">
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
              <tr v-for="sale in blogs" :key="'sale'+sale.sale_id">
                <td>{{ sale.sale_id }}</td>
                <td>{{ formatDate(sale.date) }}</td>
                <td class="has-text-left">{{ sale.cus_fname +" "+ sale.cus_lname}}</td>
                <td>{{ sale.income }}</td>
                <td>
                  <button class="button is-light" @click="seeDetail(sale.sale_id)">see more</button>
                </td>
                <td>
                  <i class="fa fa-edit" aria-hidden="true" style="cursor: pointer" @click="editModals(sale)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(sale.sale_id)"></i>
                </td>
              </tr>
            </tbody>
            <tfoot>
                <tr>
 
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
      

        <div class="column is-full my-5" v-if="selectSite === 'orders'">
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
              <tr v-for="order in blogs" :key="'order'+order.order_id">
                <td>{{ order.order_id }}</td>
                <td>{{ formatDate(order.buy_date) }}</td>
                <td>{{ order.mats_name }}</td>
                <td>{{ order.unit }}</td>
                <td>
                  <button class="button is-light" @click="seeDetail(order.order_id)">see more</button>
                </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer"  @click="editModals(order)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(order.order_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div>


        <div class="column is-full my-5" v-if="selectSite === 'materials'">
          <p class="title is-4 has-text-left">Material
            <button style="float: right" class="button is-primary" @click="newRecord">New Material</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
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
                <td>{{ mat.price }} </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(mat)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(mat.mats_id)"></i>
                  </td>
              </tr>
            </tbody>
          </table>
        </div>


        <div class="column is-full my-5" v-if="selectSite === 'menu'">
          <p class="title is-4 has-text-left">Menu
              <button style="float: right" class="button is-primary" @click="newRecord">New Menu</button>
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
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="menu in blogs" :key="'menu'+menu.menu_id">
                <td>{{ menu.menu_id }}</td>
                <td><img :src="menu.image" :alt="menu.menu_name" width="170px"></td>
                <td>{{ menu.menu_name }}</td>
                <td>{{ menu.sale_price }}</td>
                <td>{{ menu.mats_cost }}</td>
                <td>{{ menu.description }}</td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(menu)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(menu.menu_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div>


        <div class="column is-full mx-1 my-5" v-if="selectSite === 'month_account'">
          <p class="title is-4 has-text-left">Month Account
              <button style="float: right" class="button is-primary" @click="newRecord">New Record</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Month</th>
                <th>Title</th>
                <th>Expense</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="month in blogs" :key="'month'+month.acc_id">
                <td>{{ month.acc_id }}</td>
                <td>{{ month_list[month.acc_month] }}</td>
                <td>{{ month.title_exp }}</td>
                <td>{{ month.amount_exp }} </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(month)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(month.acc_id)"></i>
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th>Total</th>
                <th></th>
                <th></th>
                <th>{{ sumMonthExp }}</th>
                <td></td>
              </tr>
            </tfoot>
          </table>
        </div>

    
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'day_account'">
          <p class="title is-4 has-text-left">Day Account
              <button style="float: right" class="button is-primary" @click="newRecord">New Record</button>
          </p>
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
              <tr v-for="day in blogs" :key="'d'+day.acc_id">
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
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(day)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(day.acc_id)"></i>
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

 
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'supplier'">
          <p class="title is-4 has-text-left">Supplier
              <button style="float: right" class="button is-primary" @click="newRecord">New Supplier</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
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
                <td>{{ sup.sup_id }}</td>
                <td>{{ sup.sup_name }}</td>
                <td>{{ sup.phone }}</td>
                <td>{{ sup.mats_name }}</td>
                <td>{{ sup.unit }}</td>
                <td>{{ sup.total_price }} </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(sup)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(sup.sup_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        

        <div class="column is-full mx-1 my-5" v-if="selectSite === 'employees'">
          <p class="title is-4 has-text-left">Employees
              <button style="float: right" class="button is-primary" @click="newRecord">New Employee</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>First name</th>
                <th>Last name</th>
                <th>E-mail</th>
                <th>Phone</th>
                <th>Salary</th>
                <th>Position</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="emp in blogs" :key="'emp'+emp.emp_id">
                <td>{{ emp.emp_id }}</td>
                <td>{{ emp.fname }}</td>
                <td>{{ emp.lname }}</td>
                <td>{{ emp.email }}</td>
                <td>{{ phoneFormat(emp.phone) }}</td>
                <td>{{ emp.salary }}</td>
                <td>{{ emp.position }}</td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(emp)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(emp.emp_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div>


        <div class="column is-full mx-1 my-5" v-if="selectSite === 'customer'">
          <p class="title is-4 has-text-left">Customer
              <button style="float: right" class="button is-primary" @click="newRecord">New Customer</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>First name</th>
                <th>Last name</th>
                <th>Point</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="cus in blogs" :key="'cus'+cus.cus_id">
                <td>{{ cus.cus_id }}</td>
                <td>{{ cus.cus_fname }}</td>
                <td>{{ cus.cus_lname }}</td>
                <td>{{ cus.point }}</td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(cus)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(cus.cus_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

    
        <div class="column is-full mx-1 my-5" v-if="selectSite === 'feedback'">
          <p class="title is-4 has-text-left">Feedback</p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>Customer ID</th>
                <th>Name</th>
                <th>Date</th>
                <th>Feedback</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="feedback in blogs" :key="'fb'+feedback.record_id">
                <td>{{ feedback.cus_id }}</td>
                <td>{{ feedback.name }}</td>
                <td>{{ formatDate(feedback.date) }}</td>
                <td>{{ feedback.comment }}</td>
                <td>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(feedback.record_id)"></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div> -->
      </div>
    </div>


    <!-- <div class="modal" :class="{'is-active': saleModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Edit {{ selectSite }} ID: {{ editId }}</p>
          <button class="delete" aria-label="close" @click="saleModal = false, clearEdit()"></button>
        </header>
        <section class="modal-card-body">
     
          <div class="columns" style="color: black;" v-if="selectSite === 'sales'">
            <div class="column is-5 has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="editDate">
            </div>
            <div class="column is-7 has-text-left">Income: <br>
              <input class="input mt-4" type="number" v-model="editIncome">
            </div>
          </div>

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
              <div class="column is-6 has-text-left">Profit: <br>
                <input class="input mt-4" type="number" v-model="editBalance">
              </div>
            </div>
          </span>
    
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
 
          <span v-if="selectSite === 'customer'">
            <div class="columns" style="color: black;">
              <div class="column is-5 has-text-left">First Name: <br>
                <input class="input mt-4" type="text" v-model="editFname">
              </div>
              <div class="column is-5 has-text-left">Last Name: <br>
                <input class="input mt-4" type="text" v-model="editLname">
              </div>
              <div class="column is-2 has-text-left">Point: <br>
                <input class="input mt-4" type="number" v-model="editPoint">
              </div>
            </div>
          </span>
    
          <span v-if="selectSite === 'feedback'">
            <div class="columns" style="color: black;">
              <div class="column is-6 has-text-left">Name: <br>
                <input class="input mt-4" type="text" v-model="editFname">
              </div>
              <div class="column is-6 has-text-left">Date: <br>
                <input class="input mt-4" type="date" v-model="editDate">
              </div>
            </div>
            <div class="columns" style="color: black;">
              <div class="column is-full has-text-left">Feedback: <br>
                <textarea class="textarea mt-4" type="text" v-model="editFeedback"></textarea>
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

   
    <div class="modal" :class="{'is-active': newSaleModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Add new {{ selectSite }}</p>
          <button class="delete" aria-label="close" @click="newSaleModal = false, clearEdit()"></button>
        </header>
        <section class="modal-card-body">
    
          <div class="columns" style="color: black;" v-if="selectSite === 'sales'">
            <div class="column is-5 has-text-left">Date: <br>
              <input class="input mt-4" type="date" v-model="editDate">
            </div>
            <div class="column is-7 has-text-left">Income: <br>
              <input class="input mt-4" type="number" v-model="editIncome">
            </div>
          </div>

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

 
    <div class="modal" :class="{'is-active': detailModal}">
      <div class="modal-background"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title" v-if="selectSite === 'sales' || selectSite === 'orders'">Detail for Order ID: {{ detailIndex }}</p>
          <p class="modal-card-title" v-if="selectSite === 'day_account'">Detail for Day: {{ formatDate(detailIndex) }}</p>
          <button class="delete" aria-label="close" @click="detailModal = false, clearEdit()"></button>
        </header>
        <section class="modal-card-body">
          <table class="table is-striped is-narrow is-hoverable is-fullwidth" v-if="selectSite === 'sales'">
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
   
          <table class="table is-striped is-narrow is-hoverable is-fullwidth" v-if="selectSite === 'orders'">
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
 
          <table class="table is-striped is-narrow is-hoverable is-fullwidth" v-if="selectSite === 'day_account'">
            <thead>
              <th>Sale Order</th>
              <th>Date</th>
              <th>Price</th>
            </thead>
            <tbody>
              <tr v-for="(item, index) in detailBlog" :key="item.item_id">
                <td>{{ index+1 }}</td>
                <td>{{ formatDate(item.date) }}</td>
                <td>{{ item.income }}</td>
              </tr>
            </tbody>
            <tfoot>
              <th>Total</th>
              <th></th>
              <th>{{ sumDayDetail }}</th>
            </tfoot>
          </table>
        </section>
        <footer class="modal-card-foot"></footer>
      </div>
    </div> -->

  </section>
</template>
<script>
// import axios from "axios";
// import moment from 'moment';
import Sales from "./manager/Sales.vue"
import Orders from "./manager/Order.vue"
import Material from "./manager/Material.vue"
import Customer from "./manager/Customer.vue"
import DayAccount from "./manager/DayAccount.vue"
import MonthAccount from "./manager/MonthAccount.vue"
import Employees from "./manager/Employees.vue"
import Feedback from "./manager/Feedback.vue"
import Supplier from "./manager/Supplier.vue"
import Menu from "./manager/Menu.vue"


export default {
  name: 'manager',
  components: {
    Sales,
    Orders,
    Material,
    Customer,
    DayAccount,
    MonthAccount,
    Employees,
    Feedback,
    Supplier,
    Menu
  },
  data() {
    return {
      tabs:["Sales", "Orders", "Material", "Customer", "DayAccount", "MonthAccount", "Employees", "Feedback", "Supplier", "Menu"],
      selectSite: 'Sales',
      month_list: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
      // blogs: [],
      // detailBlog: [],
      // saleModal: false,
      // newSaleModal: false,
      // editId: 0,
      // editDate: '',
      // editIncome: 0,
      // editMatName: '',
      // editUnit: 0,
      // editLeft: 0,
      // editPrice: 0,
      // editImage: '',
      // editCost: 0,
      // editDescrip: '',
      // editMonth: 0,
      // editTitle: '',
      // editExp: 0,
      // editTip: 0,
      // editBalance: 0,
      // editPhone: '',
      // editSupName: '',
      // editFname: '',
      // editLname: '',
      // editSalary: 0,
      // editPosition: '',
      // editFeedback: '',
      // editPoint: 0,
      // detailModal: false,
      // detailIndex: '',
    };
  },
//   mounted() {
//     this.getItems();
//   },
//   methods: {
//     formatDate(value) {
//       if (value) {
//         return moment(String(value)).format('DD-MM-YYYY')
//       }
//     },
//     phoneFormat(number) {
//       return number.replace(/[^0-9]/g, '')
//                 .replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
//     //   let tmp = number.replace(/\D/g, "").match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
//     // return tmp[1]+'-'+tmp[2]+'-'+tmp[3]
//     },
//     getItems() {
//       this.del = false
//       axios
//         .get("http://localhost:3000/manager/"+this.selectSite)
//         .then((response) => {
//           console.log(response);
//           this.blogs = response.data          
//         })
//         .catch((err) => {
//           console.log(err);
//         });
//     },
//     clearEdit() {
//       this.editId = 0
//       this.editDate = ''
//       this.editIncome = 0
//       this.editMatName = ''
//       this.editUnit = 0
//       this.editLeft = 0
//       this.editPrice = 0
//       this.editImage = ''
//       this.editCost = 0
//       this.editDescrip = ''
//       this.editMonth = 0
//       this.editTitle = ''
//       this.editExp = 0
//       this.editTip = 0
//       this.editBalance = 0
//       this.editPhone = ''
//       this.editSupName = ''
//       this.editFname = ''
//       this.editLname = ''
//       this.editSalary = 0
//       this.editPosition = ''
//       this.editFeedback = ''
//       this.editPoint = 0
//     },
//     seeDetail(search) {
//       this.detailModal = true
//       this.detailIndex = search
//       axios
//         .get("http://localhost:3000/manager/"+this.selectSite+"/"+search)
//         .then((response) => {
//           console.log(response);
//           this.detailBlog = response.data;
//         })
//         .catch((err) => {
//           console.log(err);
//         });
//     },
//     editModals(item) {
//       this.saleModal = true
//       if(this.selectSite === 'sales'){
//         // if select order food
//         this.editId = item.sale_id
//         this.editDate = item.date.substring(0,10)
//         this.editIncome = item.income
//       } 
//       else if(this.selectSite === 'orders'){
//         // if select order material
//         this.editId = item.order_id
//         this.editDate = item.buy_date.substring(0,10)
//         this.editMatName = item.mats_name
//         this.editUnit = item.unit
//       }
//       else if(this.selectSite === 'materials'){
//         this.editId = item.mats_id
//         this.editMatName = item.mats_name
//         this.editLeft = item.mats_left
//         this.editPrice = item.price
//       }
//       else if(this.selectSite === 'menu'){
//         this.editId = item.menu_id
//         this.editImage = item.image
//         this.editMatName = item.menu_name
//         this.editPrice = item.sale_price
//         this.editCost = item.mats_cost
//         this.editDescrip = item.description
//       }
//       else if(this.selectSite === 'month_account'){
//         this.editId = item.acc_id
//         this.editMonth = item.acc_month
//         this.editTitle = item.title_exp
//         this.editExp = item.amount_exp
//       }
//       else if(this.selectSite === 'day_account'){
//         this.editId = item.acc_id
//         this.editDate = item.acc_date.substring(0,10)
//         this.editIncome = item.sale_income
//         this.editExp = item.mats_expense
//         this.editTip = item.tip
//         this.editBalance = item.balance
//       }
//       else if(this.selectSite === 'supplier'){
//         this.editId = item.sup_id
//         this.editSupName = item.sup_name
//         this.editPhone = item.phone
//         this.editMatName = item.mats_name
//         this.editUnit = item.unit
//         this.editPrice = item.total_price
//       }
//       else if(this.selectSite === 'employees'){
//         this.editId = item.emp_id
//         this.editFname = item.fname
//         this.editLname = item.lname
//         this.editSalary = item.salary
//         this.editPosition = item.position
//       }
//       else if(this.selectSite === 'customer'){
//         this.editId = item.cus_id
//         this.editFname = item.cus_fname
//         this.editLname = item.cus_lname
//         this.editPoint = item.point
//       }
//       else if(this.selectSite === 'feedback'){
//         this.editId = item.record_id
//         this.editFname = item.name
//         this.editDate = item.date.substring(0,10)
//         this.editFeedback = item.comment
//       }
//     },
//     saveEditModals() {
//       let array
//       if(this.selectSite === 'sales') array = {'id': this.editId, 'date': this.editDate, 'income': this.editIncome} 
//       else if(this.selectSite === 'orders') array = {'id': this.editId, 'name': this.editMatName, 'date': this.editDate, 'unit': this.editUnit} 
//       else if(this.selectSite === 'materials') array = {'id': this.editId, 'name': this.editMatName, 'left': this.editLeft, 'price': this.editPrice} 
//       else if(this.selectSite === 'menu') array = {'id': this.editId, 'name': this.editMatName, 'image': this.editImage, 'price': this.editPrice, 'cost': this.editCost, 'descript': this.editDescrip} 
//       else if(this.selectSite === 'month_account') array = {'id': this.editId, 'month': this.editMonth, 'title': this.editTitle, 'expense': this.editExp} 
//       else if(this.selectSite === 'day_account') array = {'id': this.editId, 'date': this.editDate, 'income': this.editIncome, 'expense': this.editExp, 'tip': this.editTip, 'profit': this.editBalance} 
//       else if(this.selectSite === 'supplier') array = {'id': this.editId, 'sup_name': this.editSupName, 'phone': this.editPhone, 'name': this.editMatName, 'unit': this.editUnit, 'price': this.editPrice}
//       else if(this.selectSite === 'employees') array = {'id': this.editId, 'fname': this.editFname, 'lname': this.editLname, 'salary': this.editSalary, 'position': this.editPosition} 
//       else if(this.selectSite === 'customer') array = {'id': this.editId, 'fname': this.editFname, 'lname': this.editLname, 'point': this.editPoint} 
//       else if(this.selectSite === 'feedback') array = {'id': this.editId, 'name': this.editFname, 'date': this.editDate, 'feedback': this.editFeedback} 

//      axios
//       .put("http://localhost:3000/manager/" + this.selectSite, array)
//         .then((res) => {
//           if(this.selectSite === 'materials'){
//             this.blogs.forEach(val => {
//               if(val.mats_id == res.data.id){
//                 val.mats_name = res.data.name
//                 val.mat_left = res.data.mat_left
//                 val.price = res.data.price
//               }
//            })
//           }
//           else if(this.selectSite === 'day_account'){
//             this.blogs.forEach(val => {
//             if(val.acc_id == res.data.id){
//               val.scc_date = res.data.date
//               val.sale_income = res.data.income
//               val.mats_expense = res.data.expense
//               val.tip = res.data.tip
//               val.balance = res.data.profit
//               }
//           })
//           }
          
//           this.getItems()
//           this.saleModal = false
//           this.clearEdit()
//         })
//         .catch((e) => console.log(e));
//     },
//     newRecord() {
//       this.newSaleModal = true
//       // axios
//       // .post("http://localhost:3000/manager/" + this.selectSite, {
//       //   'sale_id': this.editId,
//       //   'date': this.editDate,
//       //   'income': this.editIncome
//       // })
//       //   .then((res) => {
//       //     this.blogs.forEach(val => {
//       //       if(val.sale_id == res.data.id){
//       //         val.date = res.data.date
//       //         val.income = res.data.income
//       //       }
//       //     })
//       //     this.newSaleModal = false
//       //     this.clearEdit()
//       //   })
//       //   .catch((e) => console.log(e));
//     },
//     deleteRecord(id) {
//       const result = confirm(`Are you sure you want to delete `+ this.selectSite + ` at ID `+id);
//       if (result) {
//         axios
//           .delete(`http://localhost:3000/manager/`+this.selectSite+`/`+id)
//           .then((response) => {
//             console.log(response);
//             this.blogs = this.getItems()  
//             this.$router.push("/manager");
//           })
//           .catch((error) => {
//             alert(error.response.data.message);
//           });
//       }
//     },
//   },
//   computed: {
//     sumSales() {
//       var sum = 0
//       console.log('start');
//       this.blogs.forEach(val => sum += parseFloat(val.income));
//       return sum
//     },
//     sumMonthExp() {
//       var sum = 0
//       this.blogs.forEach(val => sum += parseFloat(val.amount_exp));
//       return sum
//     },
//     sumDayIncome() {
//       var sum = 0
//       this.blogs.forEach(val => sum += parseFloat(val.sale_income));
//       return sum
//     },
//     sumDayExp() {
//       var sum = 0
//       this.blogs.forEach(val => sum += parseFloat(val.mats_expense));
//       return sum
//     },
//     sumDayTip() {
//       var sum = 0
//       this.blogs.forEach(val => sum += parseFloat(val.tip));
//       return sum
//     },
//     sumDayBalance() {
//       var sum = 0
//       this.blogs.forEach(val => sum += parseFloat(val.balance));
//       return sum
//     },
//     sumDetail() {
//       var sum = 0
//       this.detailBlog.forEach(val => sum += (parseFloat(val.price)*parseFloat(val.unit)));
//       return sum
//     },
//     sumDayDetail() {
//       var sum = 0
//       this.detailBlog.forEach(val => sum += parseFloat(val.income));
//       return sum
//     },
//   },
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
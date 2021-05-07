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
      </div>
    </div>
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
import User from "./manager/User"


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
    Menu,
    User
  },
  data() {
    return {
      tabs:["Sales", "Orders", "Material", "Customer", "DayAccount", "MonthAccount", "Employees", "Feedback", "Supplier", "Menu","User"],
      selectSite: 'Sales',
    };
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
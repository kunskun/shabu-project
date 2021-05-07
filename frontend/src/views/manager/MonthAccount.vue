<template>
    <div class="column is-full mx-1 my-5">
          <p class="title is-4 has-text-left">Month Account
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
                <td>{{ month.acc_month }}</td>
                <td>{{ month.title_exp }}</td>
                <td>{{ month.amount_exp }} </td>
                <td>
                </td>
              </tr>
            </tbody>
            <!-- <tfoot>
              <tr>
                <th>Total</th>
                <th></th>
                <th></th>
                <th>{{ sumMonthExp }}</th>
                <td></td>
              </tr>
            </tfoot> -->
          </table>
        </div>
</template>

<script>
    import axios from 'axios'
export default {
  data() {
      return{
          blogs:[],
          createModal:false,
      }
  },
  mounted(){
    this.getItems()
  },
  methods:{
        getItems() {
      console.log("Create Menu");
      axios
        .get("http://localhost:3000/manager/month_account")
        .then((res) => {
          console.log(res);
          this.blogs = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
  },
}
}
</script>

<style scoped>
tr {
  line-height: 3rem;
}
</style>

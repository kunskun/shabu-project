<template>
    <div class="column is-full mx-1 my-5">
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
</template>

<script>


export default {
    data() {
        return{

        }
    },
}
</script>

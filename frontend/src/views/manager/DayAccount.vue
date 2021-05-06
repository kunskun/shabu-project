<template>
    <div class="column is-full mx-1 my-5">
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
</template>

<script>


export default {
    data() {
        return{

        }
    },
}
</script>

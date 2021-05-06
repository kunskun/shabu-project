<template>
  <div class="column is-full my-5">
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
        <tr v-for="order in blogs" :key="'order' + order.order_id">
          <td>{{ order.order_id }}</td>
          <td>{{ formatDate(order.buy_date) }}</td>
          <td>{{ order.mats_name }}</td>
          <td>{{ order.unit }}</td>
          <td>
            <button class="button is-light" @click="seeDetail(order.order_id)">
              see more
            </button>
          </td>
          <td>
            <i
              class="fa fa-edit"
              style="cursor: pointer"
              @click="editModals(order)"
            ></i>
            <i
              class="fa fa-trash ml-4"
              aria-hidden="true"
              style="cursor: pointer; transform: translateY(-1px)"
              @click="deleteRecord(order.order_id)"
            ></i>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
};
</script>

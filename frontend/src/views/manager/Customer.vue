<template>
  <div class="column is-full mx-1 my-5">
    <p class="title is-4 has-text-left">
      Customer
      <button style="float: right" class="button is-primary" @click="newRecord">
        New Customer
      </button>
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
        <tr v-for="cus in blogs" :key="'cus' + cus.cus_id">
          <td>{{ cus.cus_id }}</td>
          <td>{{ cus.cus_fname }}</td>
          <td>{{ cus.cus_lname }}</td>
          <td>{{ cus.point }}</td>
          <td>
            <i
              class="fa fa-edit"
              style="cursor: pointer"
              @click="editModals(cus)"
            ></i>
            <i
              class="fa fa-trash ml-4"
              aria-hidden="true"
              style="cursor: pointer; transform: translateY(-1px)"
              @click="deleteRecord(cus.cus_id)"
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

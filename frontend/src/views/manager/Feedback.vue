<template>
  <div class="column is-full mx-1 my-5">
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
        <tr v-for="feedback in blogs" :key="'fb' + feedback.record_id">
          <td>{{ feedback.cus_id }}</td>
          <td>{{ feedback.name }}</td>
          <td>{{ formatDate(feedback.date) }}</td>
          <td>{{ feedback.comment }}</td>
          <td>
            <!-- <i class="fa fa-edit" style="cursor: pointer" @click="editModals(feedback)"></i> -->
            <i
              class="fa fa-trash ml-4"
              aria-hidden="true"
              style="cursor: pointer; transform: translateY(-1px)"
              @click="deleteRecord(feedback.record_id)"
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
      return{
          
      }
  },
};
</script>
    
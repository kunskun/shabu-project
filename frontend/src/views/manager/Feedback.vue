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
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
    <script>
    import axios from 'axios'
    import moment from 'moment'
export default {
  data() {
      return{
          blogs:[]
      }
  },
  mounted(){
    this.getItems()
  },
  methods:{
        getItems() {
      console.log("Create Menu");
      axios
        .get("http://localhost:3000/manager/feedback")
        .then((res) => {
          console.log(res);
          this.blogs = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
  },
      formatDate(value) {
      if (value) {
        return moment(String(value)).format('DD-MM-YYYY')
      }
    },
}
}
</script>

<style scoped>
tr {
  line-height: 3rem;
}
</style>
    
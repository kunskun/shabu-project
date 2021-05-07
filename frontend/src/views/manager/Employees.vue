<template>
    <div class="column is-full mx-1 my-5">
          <p class="title is-4 has-text-left">Employees
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
                </td>
              </tr>
            </tbody>
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
        .get("http://localhost:3000/manager/employee")
        .then((res) => {
          console.log(res);
          this.blogs = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
  },
      phoneFormat(number) {
      return number.replace(/[^0-9]/g, '')
                .replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    },
}
}
</script>

<style scoped>
tr {
  line-height: 3rem;
}
</style>
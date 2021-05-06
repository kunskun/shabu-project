<template>
    <div class="column is-full mx-1 my-5">
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
</template>

<script>

export default {
    data() {
        return{
            
        }
    },
}
</script>

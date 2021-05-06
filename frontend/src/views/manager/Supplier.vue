<template>
    <div class="column is-full mx-1 my-5">
          <p class="title is-4 has-text-left">Supplier
              <button style="float: right" class="button is-primary" @click="newRecord">New Supplier</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Material Name</th>
                <th>Unit</th>
                <th>Price</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="sup in blogs" :key="'sup'+sup.sup_id">
                <td>{{ sup.sup_id }}</td>
                <td>{{ sup.sup_name }}</td>
                <td>{{ sup.phone }}</td>
                <td>{{ sup.mats_name }}</td>
                <td>{{ sup.unit }}</td>
                <td>{{ sup.total_price }} </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(sup)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(sup.sup_id)"></i>
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

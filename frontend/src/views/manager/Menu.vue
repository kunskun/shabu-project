<template>
    <div class="column is-full my-5">
          <p class="title is-4 has-text-left">Menu
              <button style="float: right" class="button is-primary" @click="newRecord">New Menu</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Price</th>
                <th>Cost</th>
                <th>Description</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="menu in blogs" :key="'menu'+menu.menu_id">
                <td>{{ menu.menu_id }}</td>
                <td><img :src="menu.image" :alt="menu.menu_name" width="170px"></td>
                <td>{{ menu.menu_name }}</td>
                <td>{{ menu.sale_price }}</td>
                <td>{{ menu.mats_cost }}</td>
                <td>{{ menu.description }}</td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(menu)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(menu.menu_id)"></i>
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

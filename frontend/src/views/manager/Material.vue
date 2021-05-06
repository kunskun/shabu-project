<template>
    <div class="column is-full my-5">
          <p class="title is-4 has-text-left">Material
            <button style="float: right" class="button is-primary" @click="newRecord">New Material</button>
          </p>
          <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
              <tr>
                <th>Material ID</th>
                <th>Name</th>
                <th>Material Left</th>
                <th>Price</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="mat in blogs" :key="'mat'+mat.mats_id">
                <td v-if="del"><input type="checkbox" :name="mat.mats_id" :id="mat.mats_id" style="cursor: pointer"></td>
                <td>{{ mat.mats_id }}</td>
                <td>{{ mat.mats_name }}</td>
                <td :class="{'has-text-danger': mat.mats_left < 5 }">{{ mat.mats_left }}</td>
                <td>{{ mat.price }} </td>
                <td>
                  <i class="fa fa-edit" style="cursor: pointer" @click="editModals(mat)"></i>
                  <i class="fa fa-trash ml-4" aria-hidden="true" style="cursor: pointer; transform: translateY(-1px)" @click="deleteRecord(mat.mats_id)"></i>
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

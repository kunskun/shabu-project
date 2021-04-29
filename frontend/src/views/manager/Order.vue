<template>
    <div class="column is-full my-6">
        <h1 class="title is-4">Order</h1>
        <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Name</th>
                    <th>Unit</th>
                    <!-- <th>Table no.</th> -->
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>2020-01-01</td>
                    <td>Cucumber</td>
                    <td>20</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>2020-01-01</td>
                    <td>Chicken</td>
                    <td>6</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>2020-01-01</td>
                    <td>Cola</td>
                    <td>2</td>
                </tr>
            </tbody>
        </table>
    </div>
</template>
<script>
// import store from '@/store.js'
export default {    
    data() {
        // return {destination: this.$route.params.id}
    },
}
</script>

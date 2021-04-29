<template>
    <!-- Material -->
    <div class="column is-full my-6">
        <h1 class="title is-4">Material</h1>
        <table class="table is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
                <tr>
                <th>Material ID</th>
                <th>Name</th>
                <th>Material Left</th>
                <th>Price</th>
                <!-- <th>Table no.</th> -->
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Cucumber</td>
                    <td class="has-text-danger">0</td>
                    <td>20.00 $</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Chicken</td>
                    <td>14</td>
                    <td>150.00 $</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Cola</td>
                    <td>18</td>
                    <td>12.00 $</td>
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

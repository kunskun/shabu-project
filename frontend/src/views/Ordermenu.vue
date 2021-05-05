<template>
  <div class="container is-widescreen">
    <div class="columns">
      <!-- Column แสดงสินค้า--------------------------------------------------------->
      <div class="column is-8 pt-6">
        <h1 class="is-size-4 mb-4 has-text-dark">โปรดเลือกค่ะท่าน {{custinfo.cus_fname}}</h1>
        <div class="container is-max-desktop">
          <div class="is-multiline columns is-variable is-2">
            <!-- Card element start here------------------------------------------>
            <div
              class="column is-one-quarter"
              v-for="item in menus"
              :key="item.id"
            >
              <div class="card">
                <div class="card-image">
                  <figure class="image is-1by1">
                    <img :src="item.image" alt="Placeholder image" />
                  </figure>
                </div>
                <div class="card-content">
                  <div class="media">
                    <div class="media-content">
                      <p class="title is-4">{{ item.menu_name }}</p>
                      <p class="subtitle is-6">{{ item.description }}</p>
                      <div class="columns">
                        <div class="column">
                          <p class="subtitle is-6 has-text-danger">
                            {{ item.sale_price }} ฿
                          </p>
                        </div>
                        <div class="column">
                          <div
                            class="icon is-size-4"
                            @click="addToOrder(item.menu_id)"
                          >
                            <i class="fa fa-shopping-cart has-text-info"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Column แสดงตะกร้า--------------------------------------------------->
      <div class="column is-3 pt-6 pl-0 pr-5">
        <div style="display: flex; justify-content: space-between">
          <span class="is-size-4 mb-4 has-text-dark">
            Your order {{ totalOrder }} items</span
          >
          <a class="is-danger mb-4 button">Clear</a>
        </div>
        <!-- Card element start here ------------------------------------------>
        <div class="card mb-4">
          <div class="card-content p-0">
            <div class="columns" v-for="item in menus" :key="item.id">
              <template v-if="item.quantity">
                <div class="column is-half">
                  <img class="image is-fullwidth" :src="item.image" alt="" />
                </div>
                <div class="column pt-5">
                  <div class="has-text-left">
                    <p>{{ item.menu_name }}</p>
                    <div class="columns mt-5">
                      <div class="column">
                        <p class="has-text-danger">{{ item.sale_price }} ฿</p>
                      </div>
                      <div class="column">
                        <p>{{ item.quantity }} unit</p>
                      </div>
                    </div>
                  </div>
                </div>
              </template>
            </div>
            <div class="field" v-if="cart.length">
              <p class="has-text-danger">Total Price: {{ sumPrice }}</p>
            </div>
            <div class="field" v-if="cart.length">
              <button class="button is-warning is-right" style="width: 100%">
                สั่งอาหาร
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <footer class="footer has-background-warning mt-5 pt-5 pb-5">
      <div class="content has-text-centered">
        <p>
          <strong>Bulma</strong> by
          <a href="https://jgthms.com">Jeremy Thomas</a>. The source code is
          licensed
          <a href="http://opensource.org/licenses/mit-license.php">MIT</a>. The
          website content is licensed
          <a href="http://creativecommons.org/licenses/by-nc-sa/4.0/"
            >CC BY NC SA 4.0</a
          >.
        </p>
      </div>
    </footer>
  </div>
</template>



<script>
import axios from "axios";
// @ is an alias to /src
export default {
  name: "Ordermenu",
  data() {
    return {
      menus: [],
      order: [],
      custinfo: {},
      userId: 0
    };
  },
  mounted() {
    this.getMenus();
    this.getUser();
  },
  computed: {
    cart() {
      return this.menus.filter((x) => {
        return x.quantity > 0;
      });
    },
    sumPrice() {
      let sum = 0;
      this.cart.map((a) => {
        sum += a.sale_price * a.quantity;
      });
      return sum;
    },
    totalOrder() {
      let total = 0;
      this.cart.map((a) => {
        total += a.quantity;
      });
      return total;
    },
  },
  methods: {
    getMenus() {
      axios
        .get("http://localhost:3000/menu", {})
        .then((response) => {
          this.menus = response.data.map((x) => {
            x["quantity"] = 0;
            return x;
          });
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getUser() {
      axios
        .get("http://localhost:3000/user/me", {
          headers: { Authorization: "Bearer " + localStorage.getItem('token')},
        })
        .then((response) => {
          this.userId = response.data.id
          this.getCustomer();
        });
    },
    getCustomer() {
      axios
        .get("http://localhost:3000/user/customer/"+this.userId)
        .then((response) => {
          console.log(response.data);
          this.custinfo = response.data[0]
        })
        .catch((err) => {
          console.log(err);
        });
    },
    addToOrder(id) {
      let check = this.menus.filter((x) => {
        return x.menu_id == id;
      })[0];
      let index = this.menus.indexOf(check);
      this.menus[index]["quantity"] += 1;
    },
  },
};
</script>
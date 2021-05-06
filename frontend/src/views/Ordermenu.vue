<template>
  <div class="container is-widescreen">
    <div class="columns">
      <!-- Column แสดงสินค้า--------------------------------------------------------->
      <div class="column is-8 pt-6">
        <h1 class="is-size-4 mb-4 has-text-dark">
          โปรดเลือกค่ะท่าน {{ custinfo.cus_fname }}
        </h1>
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
          <a class="is-danger mb-4 button" @click="deleteCart()">Clear</a>
        </div>
        <!-- Card element start here ------------------------------------------>
        <div class="card mb-4">
          <div class="card-content p-0">
            <div class="columns" v-for="item in menus" :key="item.id">
              <template v-if="item.unit">
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
                        <p>{{ item.unit }} unit</p>
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
              <button
                @click="orderFood()"
                class="button is-warning is-right"
                style="width: 100%"
              >
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
      userId: 0,
      saleId: 0,
    };
  },
  mounted() {
    this.getMenus();
    this.getUser();
  },
  computed: {
    cart() {
      return this.menus.filter((x) => {
        return x.unit > 0;
      });
    },
    sumPrice() {
      let sum = 0;
      this.cart.map((a) => {
        sum += a.sale_price * a.unit;
      });
      return sum;
    },
    totalOrder() {
      let total = 0;
      this.cart.map((a) => {
        total += a.unit;
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
            x["unit"] = 0;
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
          headers: { Authorization: "Bearer " + localStorage.getItem("token") },
        })
        .then((response) => {
          this.userId = response.data.id;
          console.log("userid", this.userId);
          this.getCustomer();
        });
    },
    getCustomer() {
      axios
        .get("http://localhost:3000/user/customer/" + this.userId)
        .then((response) => {
          this.custinfo = response.data[0];
        })
        .catch((err) => {
          console.log(err);
        });
    },
    deleteCart() {
      if (this.totalOrder > 0) {
        let con = confirm(
          "หากกดตกลงจะทำการลบออเดอร์ทั้งหมด " +
            this.totalOrder +
            " รายการ คุณแน่ใจนะ?"
        );
        if (con == true) {
          console.log("ลบน้า");
          this.menus.forEach((e) => {
            e.unit = 0;
          });
        } else {
          console.log("ใจโลเล");
        }
      } else {
        alert("ยังไม่มีการเลือกออเดอร์");
      }
    },
    addToOrder(id) {
      let check = this.menus.filter((x) => {
        return x.menu_id == id;
      })[0];
      let index = this.menus.indexOf(check);
      this.menus[index]["unit"] += 1;
    },
    ///กดสั่งอาหาร
    orderFood() {
      if(this.saleId==0){
        this.sales()
      }
      else{
        this.addSaleDetails()
      }
    },
    //เพิ่มรายการการซื้อ
    sales(){
      axios
        .post("http://localhost:3000/ordermenu", {
          income:this.sumPrice, 
          emp_id: 2,
          cus_id:this.custinfo.cus_id
        })
        .then(() => {
          alert("สั่งสำเร็จ");
          this.getSaleId()
        })
        .catch((e) => console.log(e.response.data));
    },
    getSaleId() {
      axios
        .get("http://localhost:3000/saleid/"+this.custinfo.cus_id)
        .then((response) => {
          this.saleId = response.data[0].sale_id;
          console.log("sale_id:", this.saleId);
          this.addSaleDetails()
        })
        .catch((err) => {
          console.log(err);
        });
    },
    addSaleDetails() {
      this.cart.forEach(c => {
        axios
        .post("http://localhost:3000/details", {
          unit: c.unit,
          price: c.sale_price,
          sale_id: this.saleId,
          menu_id: c.menu_id
        })
        .then(() => {
          console.log('Add detail success')
        })
        .catch((e) => console.log(e.response.data));
      });
    },
  },
};
</script>
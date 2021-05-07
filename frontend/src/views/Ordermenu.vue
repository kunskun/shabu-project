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
                          <div
                            class="icon is-size-4"
                            @click="addToOrder(item.menu_id)"
                          >
                            <i
                              class="fa fa-shopping-cart has-text-success mr-4"
                            ></i>
                            {{ item.sale_price }}.-
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
      <div class="column is-4 pt-6 pl-0 pr-5">
        <div style="display: flex; justify-content: space-between">
          <!-- <label class="icon is-size-6"><i class="fa fa-folder-open has-text-info">ดูรายละเอียดการสั่งง</i></label> -->
          <span v-if="!detail" class="is-size-4 mb-4 has-text-dark">
            ออร์เดอร์ตอนนี้ {{ totalOrder }} รายการ
          </span>
          <a v-if="!detail" class="is-primary mb-4 button" @click="seeDetail()"
            >ดูที่สั่งไปแล้ว</a
          >
          <span v-if="detail" class="is-size-4 mb-4 has-text-dark">
            ทั้งหมด {{ totalDetail }} รายการ
          </span>
          <a
            v-if="detail"
            class="is-primary-light mb-4 button"
            @click="seeDetail()"
            >ปิดที่ออร์เดอร์สั่งไปแล้ว</a
          >
        </div>
        <!-- Card element start here ------------------------------------------>
        <div class="card mb-2">
          <div v-if="!detail" class="card-content p-0">
            <div class="columns" v-for="item in menus" :key="item.id">
              <template v-if="item.unit">
                <div class="column is-half">
                  <img class="image is-fullwidth" :src="item.image" alt="" />
                </div>
                <div class="column">
                  <div class="has-text-left">
                    <div class="columns mt-2">
                      <div class="column-is-2">
                        <p class="title is-4">{{ item.menu_name }}</p>
                        <p class="has-text-dark ">
                          ราคา {{ item.sale_price }} ฿
                        </p>
                        <p class="has-text-danger">x{{ item.unit }}</p>
                      </div>
                    </div>
                  </div>
                </div>
              </template>
            </div>
            <div class="field" v-if="cart.length">
              <p class="has-text-dark is-size-5">ราคารวมตอนนี้ : {{ sumPrice }} บาท</p>
            </div>
            <div class="field" v-if="cart.length">
              <button
                @click="orderFood()"
                class="button is-success is-right"
                style="width: 100%"
              >
                สั่งอาหาร
              </button>
            </div>
          </div>
        </div>
        <div class="card" v-if="detail">
          <header class="card-header">
            <p class="card-header-title">ออร์เดอร์หมายเลข {{ this.saleId }}</p>
            <p class="has-text-info"></p>
          </header>
          <div class="card-content" id="conditon" style="padding: 2px">
            <div class="content">
              <table class="table is-bordered">
                <thead>
                  <tr>
                    <th>จำนวน</th>
                    <th>รายการ</th>
                    <th>ราคา</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="order in orders" :key="order.id">
                    <td>{{ order.unit }}</td>
                    <td>{{ order.menu_name }}</td>
                    <td>{{ order.price * order.unit }}</td>
                  </tr>
                  <tr>
                    <td colspan="1"></td>
                    <th>ราคารวมทั้งหมด</th>
                    <td>{{ sumDetail.toFixed(2) }} บาท</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <footer v-if="orders.length != 0" class="card-footer">
            <a
              v-if="orders[0].status == 'Pending'"
              @click="confirmPay(orders[0].sale_id)"
              class="card-footer-item"
              >ยืนยันการชำระเงิน</a
            >
            <a
              v-if="orders[0].status == 'Waiting'"
              @click="confirmServ(orders[0].sale_id)"
              class="card-footer-item"
              >ทำการเสิรฟ์อาหาร</a
            >
          </footer>
        </div>
      </div>
    </div>
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
      orders: [],
      custinfo: {},
      userId: 0,
      saleId: 0,
      detail: false,
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
    sumDetail() {
      let sum = 0;
      this.orders.map((a) => {
        sum += a.sale_price * a.unit;
      });
      return sum;
    },
    totalDetail() {
      let sum = 0;
      this.orders.map((a) => {
        sum += a.unit;
      });
      return sum;
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
          console.log("ลบแล้ว");
          this.menus.forEach((e) => {
            e.unit = 0;
          });
        } else {
          console.log("ยกเลิกการลบ");
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
    ///เรียกรายละเอียดออเดอร์
    getDetail(id) {
      console.log(id);
      axios
        .get("http://localhost:3000/pos/" + id)
        .then((response) => {
          this.orders = response.data;
          console.log("Get detail", this.orders);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    ///กดสั่งอาหาร
    orderFood() {
      if (this.saleId == 0) {
        this.sales();
      } else {
        this.addSaleDetails();
        this.seeDetail();
      }
    },
    seeDetail() {
      if (this.saleId != 0) {
        this.getDetail(this.saleId);
        this.detail = !this.detail;
      } else {
        alert("ยังไม่มีการสั่งอาหาร");
      }
    },
    //เพิ่มรายการการซื้อ
    sales() {
      axios
        .post("http://localhost:3000/ordermenu", {
          income: this.sumPrice,
          emp_id: 2,
          cus_id: this.custinfo.cus_id,
        })
        .then(() => {
          this.getSaleId();
        })
        .catch((e) => console.log(e.response.data));
    },
    getSaleId() {
      axios
        .get("http://localhost:3000/saleid/" + this.custinfo.cus_id)
        .then((response) => {
          this.saleId = response.data[0].sale_id;
          console.log("sale_id:", this.saleId);
          this.addSaleDetails();
        })
        .catch((err) => {
          console.log(err);
        });
    },
    addSaleDetails() {
      this.cart.forEach((c) => {
        axios
          .post("http://localhost:3000/details", {
            unit: c.unit,
            price: c.sale_price,
            sale_id: this.saleId,
            menu_id: c.menu_id,
          })
          .then(() => {
            console.log("Add detail success");
          })
          .catch((e) => console.log(e.response.data));
      });
      alert("สั่งสำเร็จ");
      this.menus.forEach((e) => {
        e.unit = 0;
      });
      console.log("ล้างคลัง");
    },
  },
};
</script>
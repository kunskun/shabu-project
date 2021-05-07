<template>
  <div class="container is-widescreen">
    <div class="columns">
      <!-- Column แสดงสินค้า--------------------------------------------------------->
      <div class="column is-8 pt-6 mb-6 pb-2">
        <h1 class="is-size-3 mb-4 has-text-dark has-text-left">รายการเมนู</h1>
        <div class="container is-max-desktop" style="height: 600px; overflow-y: auto; overflow-x: hidden">
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
                            v-if="!detail"
                            class="icon is-size-4"
                            @click="addToOrder(item.menu_id)"
                          >
                            <i
                              class="fa fa-shopping-cart has-text-success mr-4"
                            ></i>
                            {{ item.sale_price }}.-
                          </div>
                          <div v-if="detail" class="icon is-size-4">
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
      <div class="column is-4 pt-6 pl-0 pr-5" >
        <!-- Card element start here ------------------------------------------>
        <div class="card mb-2">
          <header class="card-header" style="background-color: #31525b">
            <span v-if="detail" class="card-header-title has-text-light">
              ทั้งหมด {{ totalDetail }} รายการ
            </span>
            <template v-if="detail">
              <a 
                class="card-header-title is-light mt-1 button"
                @click="seeDetail()"
                >ปิดที่ออร์เดอร์สั่งไปแล้ว</a
              >
            </template>
            <span v-if="!detail" class="card-header-title has-text-light">
              ออร์เดอร์ตอนนี้ {{ totalOrder }} รายการ
            </span>
            <template v-if="!detail">
              <a
                class="card-header-title is-dark mt-4 button"
                @click="seeDetail()"
                >ดูที่สั่งไปแล้ว</a
              ><a
                class="is-primary mb-4 button is-danger mt-4"
                @click="deleteCart()"
                ><i class="fa fa-trash has-text-light is-size-3"></i
              ></a>
            </template>
          </header>
          <!-- style="height: 700px; overflow: auto" -->
          <div v-if="!detail" class="card-content p-0" style="height: 500px; overflow-y: auto; overflow-x: hidden">
            <div class="columns" v-for="item in menus" :key="item.id">
              <template v-if="item.unit">
                <div class="column is-half">
                  <img class="image is-fullwidth" :src="item.image" alt="" />
                </div>
                <div class="column">
                  <div class="has-text-left">
                    <div class="columns mt-2">
                      <div class="column-is-2">
                        <p class="title is-3">{{ item.menu_name }}</p>
                        <p class="has-text-dark is-size-5">
                          ราคา {{ item.sale_price }} ฿
                        </p>
                        <p class="has-text-dark is-size-5">
                          <i
                            @click="item.unit += 1"
                            class="fa fa-plus has-text-danger is-size-6 mr-3"
                          ></i>
                          {{ item.unit }}
                          <i
                            @click="item.unit -= 1"
                            class="fa fa-minus has-text-danger is-size-6 ml-3"
                          ></i>
                        </p>
                        <p class="is-size-6"></p>
                      </div>
                    </div>
                  </div>
                </div>
              </template>
            </div>
          </div>
          <div class="field" v-if="cart.length">
            <p class="has-text-dark is-size-5">
              ราคารวมตอนนี้ : {{ sumPrice }} บาท
            </p>
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
        <div class="card" v-if="detail">
          <header class="card-header">
            <p v-if="orders[0].status != 'Finished'" class="card-header-title">
              ออร์เดอร์หมายเลข {{ saleId }}
            </p>
            <p v-if="orders[0].status == 'Finished'" class="card-header-title">
              ใบเสร็จหมายเลข {{ saleId }}
            </p>
            <p
              @click="getDetail(saleId)"
              v-if="orders[0].status == 'Received'"
              class="card-header-title has-text-link"
            >
              รับอาหารครบแล้ว
            </p>
            <p
              @click="getDetail(saleId)"
              v-if="orders[0].status == 'Waiting'"
              class="card-header-title has-text-warning"
            >
              กำลังรออาหาร
            </p>
            <p
              @click="getDetail(saleId)"
              v-if="orders[0].status == 'Pending'"
              class="card-header-title has-text-primary"
            >
              กำลังตรวจสอบการชำระ
            </p>
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
              v-if="orders[0].status == 'Received'"
              @click="pending()"
              class="card-footer-item"
              >ยืนยันการชำระเงิน</a
            >
            <a v-if="orders[0].status == 'Finished'" class="card-footer-item"
              ><i class="fa fa-check has-text-success mr-4 is-size-4"
                >ชำระเงินเรียบร้อย</i
              ></a
            >
          </footer>
        </div>
      </div>
    </div>
  </div>
</template>



<script>
import axios from "axios";

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
    getProjects(url = "/api/departments") {
      this.tableData.draw++;
      axios
        .get(url, { params: this.tableData })
        .then((response) => {
          let data = response.data;
          if (this.tableData.draw == data.draw) {
            this.projects = data.data.data;
            this.configPagination(data.data);
          }
        })
        .catch((errors) => {
          console.log(errors);
        });
    },
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
        this.waiting();
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
    waiting() {
      axios
        .put("http://localhost:3000/waitingstatus/" + this.saleId, {
          status: "Waiting",
        })
        .then(() => {
          console.log("Update status success");
          this.getDetail(this.saleId);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    pending() {
      let check = confirm("คุณต้องการชำระเงินใช่ไหม?");
      if (check) {
        axios
          .put("http://localhost:3000/pendingstatus/" + this.saleId, {
            status: "Pending",
          })
          .then(() => {
            console.log("Pending success");
            this.getDetail(this.saleId);
          })
          .catch((err) => {
            console.log(err);
          });
      }
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
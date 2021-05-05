<template>
  <section class="section" id="app">
    <div class="container">
      <div class="columns">
        <!-- ข้อมูลลูกค้าแต่ละคน -->
        <div class="column is-8">
          <template v-if="!doing">
            <template v-if="finished">
            <div class="columns is-multiline">
              <div
                class="column is-3"
                v-for="(order, index) in custOder"
                :key="'order' + index"
              >
                <div class="card">
                  <header class="card-header" style="background-color: #31525b">
                    <p class="card-header-title has-text-light">
                      รหัสลูกค้า {{ order.cus_id }}
                    </p>
                  </header>
                  <div class="card-content" style="padding: 2px">
                    <div class="content">
                      <div class="box level py-3 my-1">
                        <span>ชื่อ: {{ order.cus_fname }}</span>
                      </div>
                      <div class="box level py-3 my-1">
                        <span> นามสกุล: {{ order.cus_lname }} </span>
                      </div>
                      <div class="box level py-3 my-1">
                        <span style="text-decoration: none">
                          status:
                          <a
                            v-if="
                              order.cus_id != '111' && order.cus_id != '110'
                            "
                            @click="getDetail(order.cus_id)"
                            class="has-text-warning"
                            >doing</a
                          >
                          <a
                            v-if="order.cus_id == '110'"
                            @click="getDetail(order.cus_id)"
                            class="has-text-info"
                            >receive</a
                          >
                          <a
                            v-if="order.cus_id == '111'"
                            @click="getDetail(order.cus_id)"
                            class="has-text-success"
                            >finished</a
                          >
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            </template>
          </template>
        </div>
        <div class="column is-4">
          <div class="card" style="margin-bottom: 10px">
            <header class="card-header" style="background-color: #31525b">
              <p class="card-header-title has-text-light">เงื่อนไขการแสดงผล</p>
            </header>
            <div class="card-content level-left">
              <div class="content">
                <div class="control">
                  <label class="checkbox"
                    ><input type="checkbox" v-model="doing" />
                    เฉพาะลูกค้าที่ยังได้อาหารไม่ครบ
                  </label>
                </div>
                <div class="control level-left">
                  <label class="checkbox"
                    ><input type="checkbox" v-model="finished"/>
                    เฉพาะลูกค้าที่ยังไม่ได้จ่ายเงิน
                  </label>
                </div>
              </div>
            </div>
          </div>
          <div class="card">
            <header class="card-header">
              <p class="card-header-title">รายละเอียดการสั่งอาหาร</p>
              <p v-if="orderDetail" class="has-text-info" id="odt"></p>
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
                    <tr v-for="order in orderDetail" :key="order.id">
                      <td>{{ order.unit }}</td>
                      <td>{{ order.menu_name }}</td>
                      <td>{{ order.price * order.unit }}</td>
                    </tr>
                    <tr>
                      <td colspan="1"></td>
                      <th>ราคารวมทั้งหมด</th>
                      <td>{{ sumSales }} บาท</td>
                    </tr>
                    <!-- <tr>
                      <td colspan="1"></td>
                      <th>เงินที่จ่าย</th>
                      <td>500.00 บาท</td>
                    </tr>
                    <tr>
                      <td colspan="1"></td>
                      <th>เงินทอนทั้งสิ้น</th>
                      <td>288.00 บาท</td>
                    </tr> -->
                  </tbody>
                </table>
                <!-- <div class="box level py-3 my-2">
                    <div class="control">
                      SELECT
                      cus_id,cus_fname,cus_lname,sale_id,menu_id,menu_name,unit
                      FROM shabu.customer join shabu.sales using(cus_id) join
                      sale_details using(sale_id) join menu using(menu_id) where
                      cus_id = 102 ;
                      <span> - เบค่อน</span><br />
                      <span> - Item1</span>
                    </div>
                    <div class="level-right">
                      <span style="text-decoration: none"></span><br />
                      <input type="checkbox" />
                    </div>
                  </div> -->
              </div>
            </div>
            <footer class="card-footer">
              <a href="#" class="card-footer-item">ยืนยันการชำระเงิน</a>
              <a href="#" class="card-footer-item">จบรายการอาหาร</a>
            </footer>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import axios from "axios";

export default {
  name: "manager",
  data() {
    return {
      custOder: [],
      orderDetail: [],
      doing: false,
      finished: true
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    getItems() {
      axios
        .get("http://localhost:3000/pos")
        .then((response) => {
          this.custOder = response.data;
          console.log(response);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getDetail(id) {
      console.log(id);
      axios
        .get("http://localhost:3000/pos/" + id)
        .then((response) => {
          this.orderDetail = response.data;
          console.log(response);
          this.setHeader();
        })
        .catch((err) => {
          console.log(err);
        });
    },
    setHeader() {
      var id = this.orderDetail[0].cus_id;
      var fname = this.orderDetail[0].cus_fname;
      var lname = this.orderDetail[0].cus_lname;
      document.getElementById("odt").innerHTML = id + " " + fname + " " + lname;
    },
  },
  computed: {
    sumSales() {
      var sum = 0;
      console.log("start");
      this.orderDetail.forEach((val) => (sum += val.price * val.unit));
      return sum.toFixed(2);
    },
  },
};
</script>

<style scoped>
.level {
  justify-content: left;
}
.card-content {
  padding: 0.75rem;
}
#odt {
  width: 150px;
  overflow: hidden;
  height: 50px;
  line-height: 50px;
}
</style>
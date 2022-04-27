<template>
  <section class="section" id="app">
    <div class="container">
      <div class="columns">
        <!-- ข้อมูลลูกค้าแต่ละคน -->
        <div class="column is-8" style="height: 600px; overflow-y: auto; overflow-x: hidden">
          <div class="columns is-multiline">
            <div
              class="column is-3"
              v-for="(order, index) in customer"
              :key="'order' + index"
            >
              <div class="card">
                <header :class="{
                  'card-header': true,
                  'has-text-black': true,
                  'has-background-success': order.status == 'Finished',
                  'has-background-warning-dark': order.status == 'Waiting',
                  'has-background-danger': order.status == 'Pending',
                  'has-background-link': order.status == 'Received'}"
                  >
                  <p class="has-text-light py-1 px-2">
                    <span
                      :class="{
                        'icon-text': order.status,
                      }"
                    >
                      <span>{{ order.sale_id }}</span>
                      <span class="icon">
                        <i
                          v-if="order.status == 'Waiting'"
                          class="fa fa-exclamation-triangle"
                        ></i>
                        <i
                          v-if="order.status == 'Finished'"
                          class="fa fa-check-square"
                        ></i>
                        <i
                          v-if="order.status == 'Pending'"
                          class="fa fa-arrow-right"
                        ></i>
                        <i
                          v-if="order.status == 'Received'"
                          class="fa fa-info-circle"
                        ></i>
                      </span>
                    </span>
                    รหัสลูกค้า {{ order.cus_id }}
                  </p>
                </header>
                <div class="card-content" style="padding: 2px">
                  <div class="content">
                    <div class="box level py-1 my-1">
                      <span>ชื่อ: {{ order.cus_fname }}</span>
                    </div>
                    <div class="box level py-1 my-1">
                      <span> นามสกุล: {{ order.cus_lname }} </span>
                    </div>
                    <div class="box level py-1 my-1">
                      <span> วันที่: {{ formatDate(order.date) }} </span>
                    </div>
                    <div class="box level py-1 my-1">
                      <span style="text-decoration: none">
                        status:
                        <a
                          @click="getDetail(order.sale_id)"
                          :class="{
                            '': order.status,
                            'has-text-success': order.status == 'Finished',
                            'has-text-warning-dark': order.status == 'Waiting',
                            'has-text-danger': order.status == 'Pending',
                            'has-text-link': order.status == 'Received',
                          }"
                          >{{ order.status }}</a
                        >
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column is-4">
          <div class="card" style="margin-bottom: 10px">
            <header class="card-header" style="background-color: #31525b">
              <p class="card-header-title has-text-light">เงื่อนไขการแสดงผล</p>
            </header>
            <div class="card-content level-left">
              <div class="content">
                <div class="control level-left">
                  <label class="checkbox"
                    ><input type="checkbox" v-model="finished" />
                    เฉพาะลูกค้าที่ยังไม่ได้ชำระเงิน
                  </label>
                </div>
                <div class="control level-left">
                  <label class="checkbox"
                    ><input type="checkbox" v-model="pending" />
                    เฉพาะลูกค้าที่ต้องการชำระเงิน
                  </label>
                </div>
                <div class="control level-left">
                  <label class="checkbox"
                    ><input type="checkbox" v-model="doing" />
                    เฉพาะลูกค้าที่กำลังรออาหาร
                  </label>
                </div>
                <div class="control level-left">
                  <label class="checkbox"
                    ><input type="checkbox" v-model="calendar" />
                    แสดงตัวเลือกวันที่
                  </label>
                  <label
                    v-if="calendar"
                    @click="(start_date = ''), (end_date = '')"
                    class="icon"
                    ><i class="fa fa-eraser"></i></label
                  ><span v-if="calendar">ล้างค่า</span>
                </div>
                <div class="control level-left" v-if="calendar">
                  หลังจาก:<input
                    type="date"
                    style="margin-left: 5px; margin-right: 2px"
                    v-model="start_date"
                  />
                  ถึง:<input
                    type="date"
                    style="margin-left: 5px"
                    v-model="end_date"
                  />
                </div>
                <div class="control level-left" v-if="end_date < start_date">
                  <label class="has-text-danger"
                    >*วันที่เริ่มต้องมาก่อนหรือเท่ากับวันที่สุดท้าย</label
                  >
                </div>
                <div
                  class="control level-left"
                  v-if="
                    (end_date == '' && start_date != '') ||
                    (end_date != '' && start_date == '')
                  "
                >
                  <label class="has-text-danger"
                    >*ต้องใส่เลือกทั้งวันที่เริ่มและวันสุดท้าย</label
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="card">
            <header class="card-header">
              <p class="card-header-title" id="odn">ออร์เดอร์หมายเลข</p>
              <p class="has-text-info" id="odt"></p>
            </header>
            <div
              v-if="orderDetail.length != 0"
              class="card-content"
              id="conditon"
              style="padding: 2px"
            >
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
                    <tr
                      v-if="
                        orderDetail[0].status == 'Received' ||
                        orderDetail[0].status == 'Waiting'
                      "
                    >
                      <td colspan="1"></td>
                      <th>ราคารวมตอนนี้</th>
                      <td>{{ sumSales }} บาท</td>
                    </tr>
                    <tr v-else>
                      <td colspan="1"></td>
                      <th>ราคารวมทั้งหมด</th>
                      <td>{{ sumSales }} บาท</td>
                    </tr>
                    <tr v-if="orderDetail[0].status == 'Pending'">
                      <td colspan="1"></td>
                      <th>แต้มสะสมรอบนี้</th>
                      <td>{{ parseInt(sumSales * 0.1) }} แต้ม</td>
                    </tr>
                    <tr v-if="orderDetail[0].status == 'Finished'">
                      <td colspan="1"></td>
                      <th>แต้มสะสมรวม</th>
                      <td>{{ orderDetail[0].point }} แต้ม</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <footer v-if="orderDetail.length != 0" class="card-footer">
              <a
                v-if="orderDetail[0].status == 'Pending'"
                @click="confirmPay(orderDetail[0].sale_id)"
                class="card-footer-item"
                >ยืนยันการชำระเงิน</a
              >
              <a
                v-if="orderDetail[0].status == 'Waiting'"
                @click="confirmServ(orderDetail[0].sale_id)"
                class="card-footer-item"
                >ทำการเสิรฟ์อาหาร</a
              >
            </footer>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  name: "manager",
  data() {
    return {
      custOder: [],
      orderDetail: [],
      doing: false,
      finished: false,
      pending: false,
      calendar: false,
      start_date: "",
      end_date: "",
    };
  },
  mounted() {
    this.getItems();
  },
  methods: {
    openModal() {
      this.$refs.modal.showModal();
    },
    formatDate(value) {
      if (value) {
        return moment(String(value)).format("DD/MM/YYYY");
      }
    },
    formatObj(value) {
      if (value) {
        return moment(String(value)).format("YYYY-MM-DDT17:00:00.000Z");
      }
    },
    getItems() {
      axios
        .get("http://localhost:3000/pos")
        .then((response) => {
          this.custOder = response.data;
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
          console.log("Get detail", response);
          this.setHeader();
          this.getItems();
        })
        .catch((err) => {
          console.log(err);
        });
    },
    setHeader() {
      var sale_id = this.orderDetail[0].sale_id;
      var id = this.orderDetail[0].cus_id;
      var fname = this.orderDetail[0].cus_fname;
      var lname = this.orderDetail[0].cus_lname;
      document.getElementById("odt").innerHTML = id + " " + fname + " " + lname;
      document.getElementById("odn").innerHTML = "ออร์เดอร์หมายเลข " + sale_id;
    },
    confirmPay(sid) {
      let con = confirm(
        "ออร์เดอร์ " +
          this.orderDetail[0].sale_id +
          " ลูกค้าหมายเลข" +
          this.orderDetail[0].cus_id +
          " ทำการชำระเงินเรียบร้อยแล้ว ? "
      );
      if (con) {
        axios
          .put("http://localhost:3000/confirm/" + sid, {
            income: this.sumSales,
          })
          .then(() => {
            console.log("Payment Success");
            this.updatePoint(this.orderDetail[0].cus_id);
            this.getItems();
            this.getDetail(sid);
          })
          .catch((err) => {
            console.log(err);
          });
      }
    },
    updatePoint(cid) {
      axios
        .put("http://localhost:3000/point/" + cid, {
          point: parseInt(this.sumSales * 0.1),
        })
        .then(() => {
          console.log("Update point success");
        })
        .catch((err) => {
          console.log(err);
        });
    },
    confirmServ(sid) {
      let con = confirm(
        "ออร์เดอร์ " +
          this.orderDetail[0].sale_id +
          " ลูกค้าหมายเลข" +
          this.orderDetail[0].cus_id +
          " ได้รับอาหารเรียบร้อยแล้ว ? "
      );
      if (con) {
        axios
          .put("http://localhost:3000/service/" + sid)
          .then(() => {
            console.log("Serv done");
            this.getItems();
            this.getDetail(sid);
          })
          .catch((err) => {
            console.log(err);
          });
      }
    },
  },
  computed: {
    sumSales() {
      var sum = 0;
      console.log("start");
      this.orderDetail.forEach((val) => (sum += val.price * val.unit));
      return sum.toFixed(2);
    },
    customer() {
      if (this.doing) {
        return this.custOder.filter((c) => {
          return c.status == "Waiting";
        });
      }
      if (this.pending) {
        return this.custOder.filter((c) => {
          return c.status == "Pending";
        });
      }
      if (this.finished) {
        return this.custOder.filter((c) => {
          return c.status != "Finished";
        });
      }
      if (this.end_date != "" && this.start_date != "") {
        return this.custOder.filter((c) => {
          return (
            c.date >= this.formatObj(this.start_date) &&
            c.date <= this.formatObj(this.end_date)
          );
        });
      }
      return this.custOder;
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
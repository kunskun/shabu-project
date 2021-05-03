<template>
  <div class="container is-widescreen">
    <section class="section" id="app">
      <div class="container">
        <div class="columns">
          <div class="column is-7">
            <div class="card" style="margin-bottom: 20px">
              <header class="card-header " style="background-color:#31525b;">
                <p class="card-header-title has-text-light">เงื่อนไขการแสดงผล</p>
                <p class="card-header-icon"></p>
              </header>
              <div class="card-content level-left">
                <div class="content">
                  <div class="control">
                    <label class="checkbox"><input type="checkbox" />
                      เฉพาะลูกค้าที่ยังไม่จบรายการอาหาร
                    </label>
                  </div>
                  <div class="control level-left">
                    <label class="checkbox"><input type="checkbox" />
                      เฉพาะลูกค้าที่ยังไม่ได้รับเมนู
                    </label>
                  </div>
                </div>
              </div>
            </div>
            <div class="card">
              <header class="card-header" style="background-color:#31525b;">
                <p class="card-header-title has-text-light">ลูกค้าในวันนี้</p>
              </header>
              <div class="card-content" style="padding: 2px;">
                <div class="content">
                  <div class="box level py-3 my-2" style="background-color:#75db5d;">
                    <div class="control">
                      <label class="checkbox has-text-light" >
                        <span style="text-decoration: none" 
                          >101 อำนวย สำราญ</span
                        >
                      </label>
                    </div>
                  </div>
                  <div class="box level py-3 my-2">
                    <div class="control">
                      <label class="checkbox">
                        <span style="text-decoration: none"
                          >102 ธนา งบน้อย </span
                        >
                      </label>
                    </div>
                  </div>
                  <div class="box level py-3 my-2">
                    <div class="control">
                      <label class="checkbox">
                        <span style="text-decoration: none"
                          >103 พอดี พี่งพิง (กำลังรออาหาร)</span
                        >
                      </label>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="column is-5">
            <div class="card">
              <header class="card-header">
                <p class="card-header-title">รายละเอียดการสั่งอาหาร</p>
                <p class="card-header">102 ธนา งบน้อย</p>
              </header>
              <div class="card-content" style="padding: 2px">
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
                      <tr>
                        <td>2</td>
                        <td>เนื้อลาย</td>
                        <td>70.00</td>
                      </tr>
                      <tr>
                        <td>3</td>
                        <td>เบค่อน</td>
                        <td>60.00</td>
                      </tr>
                      <tr>
                        <td>1</td>
                        <td>หอยเชลล์</td>
                        <td>43.00</td>
                      </tr>
                      <tr>
                        <td>1</td>
                        <td>เนื้อสันคอ</td>
                        <td>39.00</td>
                      </tr>
                      <tr>
                        <td colspan="1"></td>
                        <th>ราคารวมทั้งหมด</th>
                        <td>212.00 บาท</td>
                      </tr>
                      <tr>
                        <td colspan="1"></td>
                        <th>เงินที่จ่าย</th>
                        <td>500.00 บาท</td>
                      </tr>
                      <tr>
                        <td colspan="1"></td>
                        <th>เงินทอนทั้งสิ้น</th>
                        <td>288.00 บาท</td>
                      </tr>
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
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
};
</script>

<style scoped>
</style>
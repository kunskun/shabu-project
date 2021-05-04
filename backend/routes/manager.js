const express = require("express");
const path = require("path")
const pool = require("../config");
// const fs = require("fs");
// const multer = require("multer");

// const storage = multer.diskStorage({
//   destination: function (req, file, callback) {
//     callback(null, "./static/uploads");
//   },
//   filename: function (req, file, callback) {
//     callback(
//       null,
//       file.fieldname + "-" + Date.now() + path.extname(file.originalname)
//     );
//   },
// });
// const upload = multer({ storage: storage });

router = express.Router();

router.get("/manager/:item", async function (req, res, next) {
  console.log(req.params);
  try {
    if(req.params.item === 'orders'){
      const [rows, fields] = await pool.query(
        `SELECT * FROM orders join order_items using(order_id) join materials using(mats_id)`
      )
      return res.json(rows);
    }
    else if(req.params.item === 'supplier'){
      const [rows, fields] = await pool.query(
        `SELECT * FROM supplier s join orders o on(s.sup_id = o.supplier_id) join order_items using(order_id) join materials using(mats_id)`
      )
      return res.json(rows);
    }
    else{
      const [rows, fields] = await pool.query(
        `SELECT * from ` + req.params.item
      );
      return res.json(rows);
    }
  } catch (err) {
    return next(err)
  }
});

router.put("/manager/:item", async function (req, res, next) {  
  const id = req.body.sale_id
  const date = req.body.date
  const income = req.body.income
  console.log('Show ==> '+ id, date, income);

  const conn = await pool.getConnection()
  await conn.beginTransaction();

  try {
    // if(req.params.item === 'orders'){
    //   const [rows, fields] = await pool.query(
    //     `SELECT * FROM orders join order_items using(order_id) join materials using(mats_id)`
    //   )
    //   return res.json(rows);
    // }
    // else if(req.params.item === 'supplier'){
    //   const [rows, fields] = await pool.query(
    //     `SELECT * FROM supplier s join orders o on(s.sup_id = o.supplier_id) join order_items using(order_id) join materials using(mats_id)`
    //   )
    //   return res.json(rows);
    // }
    // else{
      let results = await conn.query(
        `UPDATE `+req.params.item+` SET date=?, income=? WHERE sale_id=?`,
        [date, income, id]
      )
      await conn.commit()
      res.send({id: id, date: date, income: income});
    // }
  } catch (err) {
    await conn.rollback();
    next(err);
  } finally {
    console.log('finally')
    conn.release();
  }
  return;
});

router.post("/manager/:item", async function (req, res, next) {
  
  const id = req.body.sale_id;
  const date = req.body.date;
  const income = req.body.income;

  // Begin transaction
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
    let results = await conn.query(
      "INSERT INTO sales(date, income) VALUES(?, ?);",
      [date, income]
    );
    // const saleId = results[0].insertId;
    
    // if(!file){
    //   req.files.forEach((file, index) => {
    //     let path = [blogId, file.path.substring(6), index == 0 ? 1 : 0];
    //     pathArray.push(path);
    //   });
    //   await conn.query(
    //     "INSERT INTO images(blog_id, file_path, main) VALUES ?;",
    //     [pathArray]
    //   );
    // }
    await conn.commit();
    res.send("success!");
  } catch (err) {
    await conn.rollback();
    return res.status(400).json(err);
  } finally {
    conn.release();
  }
});

router.get("/manager/:table/:id", async function (req, res, next) {
  console.log(req.params);
  try {  
    if(req.params.table === 'sales'){
      const [rows, fields] = await pool.query(
        `SELECT * from sale_details join menu using(menu_id) where sale_id=?`, [req.params.id]
      );
      return res.json(rows);
    }
    else if(req.params.table === 'orders'){
      const [rows, fields] = await pool.query(
        `SELECT * from order_items join materials using(mats_id) where order_id=?`, [req.params.id]
      );
      return res.json(rows);
    }
    
  } catch (err) {
    return next(err)
  }
});
exports.router = router;
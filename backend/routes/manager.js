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

exports.router = router;
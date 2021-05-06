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
    if(req.params.item === 'sales'){
      const [rows, fields] = await pool.query(
        `SELECT * FROM sales left outer join customer using(cus_id)`
      )
      return res.json(rows);
    }
    else if(req.params.item === 'orders'){
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
  const id = req.body.id
  const date = req.body.date
  const income = req.body.income
  const matName = req.body.name
  const unit = req.body.unit
  const mat_left = req.body.left
  const price = req.body.price
  const image = req.body.image
  const cost = req.body.cost
  const descript = req.body.descript
  const month = req.body.month
  const title = req.body.title
  const expense = req.body.expense
  const tip = req.body.tip
  const profit = req.body.profit
  const phone = req.body.phone
  const sup_name = req.body.sup_name
  const fname = req.body.fname
  const lname = req.body.lname
  const salary = req.body.salary
  const position = req.body.position
  const point = req.body.point
  const feedback = req.body.feedback

  console.log('Get: '+req.body.id);

  const conn = await pool.getConnection()
  await conn.beginTransaction();

  try {
    // if(req.params.item === 'sales'){
    //   let results = await conn.query(
    //     `UPDATE sales SET date=?, income=? WHERE sale_id=?`,
    //     [date, income, id]
    //   )
    //   await conn.commit()
    //   res.send({id: id, date: date, income: income});
    // }
    // else if(req.params.item === 'orders'){
    //   let results = await conn.query(
    //     `UPDATE orders SET buy_date=? WHERE order_id=?;
    //     UPDATE order_items SET unit=? WHERE order_id=?;
    //     UPDATE materials SET mats_name=? WHERE mats_id=(SELECT mats_id FROM order_items WHERE order_id=?); `,
    //     [date, id, parseInt(unit), id, matName, id]
    //   );
    //   await conn.commit()
    //   res.send({id: id, date: date, name: matName, unit: unit});
    // }
    // materials
    if(req.params.item === 'materials'){
      // console.log(matName, mat_left, price, id);
      let results = await conn.query(
        `UPDATE materials SET mats_name=?, mats_left=?, price=? WHERE mats_id=?`,
        [matName, mat_left, price, id]
      )
      await conn.commit()
      res.send({id: id, name: matName, mat_left: mat_left, price: price});
    }
    // day_account
    else if(req.params.item === 'day_account'){
      console.log(date, income, expense, tip, profit);
      let results = await conn.query(
        `UPDATE day_account SET acc_date=?, sale_income=?, mats_expense=?, tip=?, balance=? WHERE acc_id=?`,
        [date, income, expense, tip, profit, id]
      )
      await conn.commit()
      res.send({id: id, date: date, income: income, expense: expense, tip: tip, profit: profit, id});
    }
  } catch (err) {
    await conn.rollback();
    next(err);
  } finally {
    console.log('finally')
    conn.release();
  }
  return;
});

// not finish
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

router.delete("/manager/:table/:id", async function (req, res, next) {  
  const conn = await pool.getConnection();
  // Begin transaction
  await conn.beginTransaction();
  try {
    if(req.params.table === 'sales'){
        const [rows, fields] = await conn.query("DELETE FROM sale_details WHERE sale_id = ?", [req.params.id]);
        const [rows2, fields2] = await conn.query("DELETE FROM sales WHERE sale_id = ?", [req.params.id]);
        if (rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'orders'){
        const [rows, fields] = await conn.query("DELETE FROM order_items WHERE order_id = ?", [req.params.id]);
        const [rows2, fields2] = await conn.query("DELETE FROM orders WHERE order_id = ?", [req.params.id]);
        if (rows.affectedRows === 1 && rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'materials'){
        const [rows2, fields2] = await conn.query("DELETE FROM materials WHERE mats_id = ?", [req.params.id]);
        if (rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'day_account'){
        const [rows, fields] = await conn.query("DELETE FROM day_details WHERE acc_id = ?", [req.params.id]);
        const [rows2, fields2] = await conn.query("DELETE FROM day_account WHERE acc_id = ?", [req.params.id]);
        if (rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send("success");
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'month_account'){
        const [rows, fields] = await conn.query("DELETE FROM month_details WHERE acc_id = ?", [req.params.id]);
        const [rows2, fields2] = await conn.query("DELETE FROM month_account WHERE acc_id = ?", [req.params.id]);
        if (rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'menu'){
        const [rows2, fields2] = await conn.query("DELETE FROM menu WHERE `menu_id` = ?", [req.params.id]);
        if (rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'supplier'){
        const [rows2, fields2] = await conn.query("DELETE FROM supplier WHERE sup_id = ?", [req.params.id]);
        if (rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'customer'){
        const [rows, fields] = await conn.query("DELETE FROM customer WHERE cus_id = ?", [req.params.id]);
        if (rows.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'employees'){
        const [rows, fields] = await conn.query("DELETE FROM employees WHERE emp_id = ?", [req.params.id]);
        if (rows.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    }
    else if(req.params.table === 'feedback'){
        const [rows, fields] = await conn.query("DELETE FROM feedback WHERE record_id = ?", [req.params.id]);
      if (rows.affectedRows === 1) {
        await conn.commit();
        res.status(204).send();
      } else {
        throw "Cannot delete the selected blog";
      }
    }

  } catch (err) {
    console.log(err)
    await conn.rollback();
    return res.status(500).json(err);
  } finally {
    conn.release();
  }
});

// not finish
router.get("/manager/:table/:search", async function (req, res, next) {
  console.log(req.params);
  try {  
    if(req.params.table === 'sales'){
      const [rows, fields] = await pool.query(
        `SELECT * from sale_details left outer join menu using(menu_id) where sale_id=?`, [req.params.search]
      );
      return res.json(rows);
    }
    else if(req.params.table === 'orders'){
      const [rows, fields] = await pool.query(
        `SELECT * from order_items join materials using(mats_id) where order_id=?`, [req.params.search]
      );
      return res.json(rows);
    }
    else if(req.params.table === 'day_account'){
      const date = req.params.search.substring(0,10)
      console.log(date);
      const [rows, fields] = await pool.query(
        `SELECT *, DATE_FORMAT(date, '%Y-%m-%d')  from sales  where date=?`, [date]
      );
      console.log(rows);
      return res.json(rows);
    }
    
  } catch (err) {
    return next(err)
  }
});

exports.router = router;
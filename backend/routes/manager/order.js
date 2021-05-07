const express = require("express");
const path = require("path")
const pool = require("../../config");

router = express.Router();

router.get("/manager/orders", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            `SELECT * FROM orders join order_items using(order_id) join materials using(mats_id)`
        )
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.delete("/manager/orders/:id", async function (req, res, next) {  
    const conn = await pool.getConnection();
    // Begin transaction
    await conn.beginTransaction();
    try {
        const [rows, fields] = await conn.query("DELETE FROM order_items WHERE order_id = ?", [req.params.id]);
        const [rows2, fields2] = await conn.query("DELETE FROM orders WHERE order_id = ?", [req.params.id]);
        if (rows.affectedRows === 1 && rows2.affectedRows === 1) {
          await conn.commit();
          res.status(204).send();
        } else {
          throw "Cannot delete the selected blog";
        }
    } catch (err) {
        console.log(err)
        await conn.rollback();
        return res.status(500).json(err);
    } finally {
        conn.release();
    }
  });

router.get("/manager/orders/:id", async function (req, res, next) {
    console.log(req.params);
    try {  
        const [rows, fields] = await pool.query(
            `SELECT * from order_items join materials using(mats_id) where order_id=?`, [req.params.id]
        );
        console.log(rows);
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.get("/manager/supplier", async function (req, res, next) {
    try {  
        const [rows, fields] = await pool.query(
            `SELECT * from supplier`
        );
        console.log(rows);
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.post("/manager/orders", async function (req, res, next) {
    const date = req.body.date
    const name = req.body.name
    const unit = req.body.unit
    const price = req.body.price
    const supid = req.body.supid

    // Begin transaction
    const conn = await pool.getConnection();
    await conn.beginTransaction();
  
    try {
        const [rows, fields] = await pool.query(
            `SELECT max(order_id) id FROM orders`
        )
        let new_id = (rows[0].id)+1

        let results = await conn.query(
            "INSERT INTO orders(buy_date, total_price, supplier_id) VALUES(?, ?, ?);",
            [date, price*unit, supid]
        );
        let results2 = await conn.query(
            "INSERT INTO order_items(unit, price, order_id) VALUES(?, ?, ?);",
            [unit, price ,new_id]
        );
        await conn.commit();
        res.send("success!");
    } catch (err) {
        console.log(err);
        await conn.rollback();
        return res.status(400).json(err);
    } finally {
        conn.release();
    }
  });

exports.router = router;

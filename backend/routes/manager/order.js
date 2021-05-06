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
            `SELECT * from order_items join materials using(mats_id) where order_id=?`, [req.params.search]
        );
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

exports.router = router;

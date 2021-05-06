const express = require("express");
const path = require("path")
const pool = require("../../config");

router = express.Router();

router.get("/manager/day_account", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            `SELECT * from day_account`
          );
          return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.delete("/manager/day_account/:id", async function (req, res, next) {  
    const conn = await pool.getConnection();
    // Begin transaction
    await conn.beginTransaction();
    try {
        const [rows2, fields2] = await conn.query("DELETE FROM day_account WHERE acc_id = ?", [req.params.id]);
        if (rows2.affectedRows === 1) {
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

router.put("/manager/day_account/:id", async function (req, res, next) {
    console.log(req.params);
    const id = req.params.id
    const date = req.body.date
    const income = req.body.income
    const expense = req.body.expense
    const tip = req.body.tip
    const prof = req.body.prof

    try {  
        const [rows, fields] = await pool.query(
            `UPDATE day_account SET acc_date=?, sale_income=?, mats_expense=?, tip=?, balance=? WHERE acc_id=?`, 
            [date, income, expense, tip, prof, id]
        );
        console.log(rows);
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.get("/manager/day_account/:date", async function (req, res, next) {
    try {
        console.log(req.params);
        const [rows, fields] = await pool.query(
            `SELECT * from sales WHERE date=?`, [req.params.date]
          );
          return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

exports.router = router;

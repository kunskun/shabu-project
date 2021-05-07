const express = require("express");
const pool = require("../config");

router.get("/menu", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            `SELECT * from menu`
        );
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.get("/saleid/:id", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            `SELECT sale_id from sales where cus_id = ? order by sale_id desc limit 1`,
            [req.params.id]
        );
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.post('/ordermenu', async function (req, res, next) {
    console.log(req.body)
    const d = new Date();
    const fulldate = d.getFullYear() + "-" + (d.getMonth()+1)+ "-" + d.getDate()
    const income = req.body.income
    const emp_id = req.body.emp_id
    const cus_id = req.body.cus_id
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
        let results = await conn.query(
            "INSERT INTO sales(date,income,emp_id,cus_id) " +
            "VALUES(?, ?, ?, ?);",
            [fulldate, income, emp_id, cus_id]
        );
        await conn.commit();
        res.send("success!");
    } catch (err) {
        console.log(err)
        await conn.rollback();
        return res.status(400).json(err);
    } finally {
        conn.release();
    }
});
router.post('/details', async function (req, res, next) {
    console.log(req.body)
    const unit = req.body.unit
    const price = req.body.price
    const sale_id = req.body.sale_id
    const menu_id = req.body.menu_id
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
        let results = await conn.query(
            "INSERT INTO sale_details(unit,price,sale_id,menu_id) " +
            "VALUES(?, ?, ?, ?);",
            [unit, price, sale_id, menu_id]
        );
        await conn.commit();
        res.send("Add details success!");
    } catch (err) {
        console.log(err)
        await conn.rollback();
        return res.status(400).json(err);
    } finally {
        conn.release();
    }
});

exports.router = router;
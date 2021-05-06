const express = require("express");
const path = require("path")
const pool = require("../../config");

router = express.Router();

router.get("/manager/sales", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
        `SELECT * FROM sales left outer join customer using(cus_id)`        
        )
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.delete("/manager/sales/:id", async function (req, res, next) {  
    const conn = await pool.getConnection();
    // Begin transaction
    await conn.beginTransaction();
    try {
        const [rows, fields] = await conn.query("DELETE FROM sale_details WHERE sale_id = ?", [req.params.id]);
        const [rows2, fields2] = await conn.query("DELETE FROM sales WHERE sale_id = ?", [req.params.id]);
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

router.get("/manager/sales/:id", async function (req, res, next) {
    console.log(req.params);
    try {  
        const [rows, fields] = await pool.query(
            `SELECT * from sale_details left outer join menu using(menu_id) where sale_id=?`, [req.params.id]
        );
        return res.json(rows);

    } catch (err) {
        return next(err)
    }
});

exports.router = router;

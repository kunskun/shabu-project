const express = require("express");
const path = require("path")
const pool = require("../../config");

router = express.Router();


// // get supplier from db
// router.get("/manager/supplier", async function (req, res, next) {
//     try {
//         const [rows, fields] = await pool.query(
//             `SELECT phone FROM supplier` 
//         )
//         return res.json(rows);
//     } catch (err) {
//         return next(err)
//     }
// });


// delete supplier from db
router.delete("/manager/supplier/:id", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            `delete FROM supplier where sup_id = ?`,[req.params.id] 
        )
        res.send('delete supplier id:'+req.params.id);
    } catch (err) {
        return next(err)
    }
});


// insert supplier
router.post("/manager/supplier", async function (req, res, next) {
    console.log(req.body)
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
        const data = req.body
        let results = await conn.query(
            "INSERT INTO supplier(sup_name,phone) " +
            "VALUES(?, ?);",
            [data.name, data.phone]
        );
        await conn.commit();
        res.send("add new supplier success!");
    } catch (err) {
        console.log(err)
        await conn.rollback();
        return res.status(400).json(err);
    } finally {
        conn.release();
    }
});


exports.router = router;

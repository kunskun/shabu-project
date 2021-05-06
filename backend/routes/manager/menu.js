const express = require("express");
const path = require("path")
const pool = require("../../config");

router = express.Router();


// get menu from db
router.get("/manager/menu", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
        `SELECT * FROM menu`        
        )
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});



// delete menu from frontend
router.put("/manager/deletemenu", async function (req, res, next) {
    console.log(req.body)
    try {
        const [rows, fields] = await pool.query(
        `update menu set status = 'Deleted' where menu_id = ?`,[req.body.id]        
        )
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});


// update menu from db
router.put("/manager/menu", async function (req, res, next) {
    console.log(req.body)
    try {
        const [rows, fields] = await pool.query(
        `update menu set image = ?,menu_name = ?,sale_price = ?, mats_cost = ?, description = ? where menu_id = ?`,
        [req.body.image,req.body.editMat,req.body.price,req.body.cost,req.body.descrip,req.body.id]        
        )
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});



//insert new menu
router.post("/manager/menu", async function (req, res, next) {
    console.log(req.body)
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
        const data = req.body
        let results = await conn.query(
            "INSERT INTO menu(menu_name,image,sale_price,mats_cost,description) " +
            "VALUES(?, ?, ?, ?, ?);",
            [data.newMat, data.image, data.price, data.cost,data.descrip]
        );
        await conn.commit();
        res.send("add new menu success!");
    } catch (err) {
        console.log(err)
        await conn.rollback();
        return res.status(400).json(err);
    } finally {
        conn.release();
    }
});


exports.router = router;

const express = require("express");
const path = require("path")
const pool = require("../../config");

router = express.Router();

router.get("/manager/employee", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
        `SELECT * FROM employees`        
        )
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});



exports.router = router;
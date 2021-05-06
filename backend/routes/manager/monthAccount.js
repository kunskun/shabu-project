const express = require("express");
const path = require("path")
const pool = require("../../config");

router = express.Router();

router.get("/manager/month_account", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
        `SELECT * FROM month_account`        
        )
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});



exports.router = router;
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


exports.router = router;
const express = require("express");
const pool = require("../config");

router = express.Router();

router.get("/", async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query(
      `SELECT * from login`
    );
    return res.json(rows);
  } catch (err) {
    return next(err)
  }
});
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


const express = require("express");
const pool = require("../config");
router = express.Router();
router.get("/pos", async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query(
      `SELECT * FROM shabu.sales join customer using(cus_id)`
    );
    return res.json(rows);
  } catch (err) {
    return next(err)
  }
});
router.get("/pos/:id", async function (req, res, next) {
  console.log(req.params.date)
  try {
    const [rows, fields] = await pool.query(
      `SELECT *
      FROM shabu.sales join customer using(cus_id) join sale_details using(sale_id) join menu using(menu_id)
      where sale_id = ?`,
      [req.params.id]
    );
    return res.json(rows);
  } catch (err) {
    return next(err)
  }
});
exports.router = router;


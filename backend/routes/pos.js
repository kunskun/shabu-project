const express = require("express");
const pool = require("../config");
router = express.Router();
router.get("/pos", async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query(
      `SELECT cus_id,date,sum(income)'income',cus_fname,cus_lname FROM shabu.sales join customer using(cus_id)
      group by cus_id`
    );
    return res.json(rows);
  } catch (err) {
    return next(err)
  }
});
router.get("/pos/:id", async function (req, res, next) {

  try {
    const [rows, fields] = await pool.query(
      `SELECT sale_id,cus_id,cus_fname,cus_lname,unit,price,menu_name
      FROM shabu.sales join customer using(cus_id) join sale_details using(sale_id) join menu using(menu_id)
      where cus_id = ?`,
      [req.params.id]
    );
    return res.json(rows);
  } catch (err) {
    return next(err)
  }
});
exports.router = router;


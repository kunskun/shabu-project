const express = require("express");
const pool = require("../config");
const router = express.Router();

// Create new comment
router.post('/comment',async function(req, res, next){
    console.log(req.body)
  const name = req.body.name;
  const comment = req.body.comment;
  const d = new Date();
  const fulldate = d.getFullYear()+"-"+d.getMonth()+"-"+d.getDate()
 
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
    let results = await conn.query(
      "INSERT INTO feedback(name,comment,date) " +
      "VALUES(?, ?, ?);",
      [name, comment, fulldate]
    );
    await conn.commit();
    res.send("success!");
  }catch (err) {
    console.log(err)
    await conn.rollback();
    return res.status(400).json(err);
  } finally {
    conn.release();
  }

});



exports.router = router
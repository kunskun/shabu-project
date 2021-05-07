const express = require("express");
const pool = require("../../config");

router = express.Router();

router.get("/manager/userrole", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            `SELECT * from users`
          );
          console.log(rows);
          return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.delete("/manager/userrole/:id", async function (req, res, next) {  
    const conn = await pool.getConnection();
    // Begin transaction
    await conn.beginTransaction();
    try {
        const [rows2, fields2] = await conn.query("DELETE FROM users WHERE id = ?", [req.params.id]);
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

router.put("/manager/userrole/:id", async function (req, res, next) {
    console.log("start query");
    const role = req.body.role
    try {  
        const [rows, fields] = await pool.query(
            `UPDATE users SET role=? WHERE id=?`, 
            [role, req.params.id]
        );
        console.log(rows);
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

exports.router = router;

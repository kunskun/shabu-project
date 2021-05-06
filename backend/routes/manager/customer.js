const express = require("express");
const pool = require("../../config");

router = express.Router();

router.get("/manager/customer", async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            `SELECT * from customer`
          );
          return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

router.delete("/manager/customer/:id", async function (req, res, next) {  
    const conn = await pool.getConnection();
    // Begin transaction
    await conn.beginTransaction();
    try {
        const [rows2, fields2] = await conn.query("DELETE FROM customer WHERE cus_id = ?", [req.params.id]);
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

router.put("/manager/customer/:id", async function (req, res, next) {
    console.log(req.params);
    const fname = req.body.fname
    const lname = req.body.lname
    const point = req.body.point
    try {  
        const [rows, fields] = await pool.query(
            `UPDATE customer SET cus_fname=?, cus_lname=?, point=? WHERE cus_id=?`, 
            [fname, lname, point, req.params.id]
        );
        console.log(rows);
        return res.json(rows);
    } catch (err) {
        return next(err)
    }
});

// router.post("/manager/materials", async function (req, res, next) {
  
//     const name = req.body.name
//     const left = req.body.left
//     const price = req.body.price
//     console.log(name, left, price);

//     // Begin transaction
//     const conn = await pool.getConnection();
//     await conn.beginTransaction();
  
//     try {
//       let results = await conn.query(
//         "INSERT INTO materials(mats_name, mats_left, price) VALUES(?, ?, ?);",
//         [name, left, price]
//       );
//         console.log(results);
//       await conn.commit();
//       res.send("success!");
//     } catch (err) {
//       await conn.rollback();
//       return res.status(400).json(err);
//     } finally {
//       conn.release();
//     }
//   });

exports.router = router;

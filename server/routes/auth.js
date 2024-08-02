const express = require('express');

const authRouter = express.Router();

authRouter.post("/api/signup", (req, res) => {
    // console.log(req.body)
    const {name, email, password} = req.body;
    // post the data to database
    // return the data to user
})


module.exports = authRouter;
// authRouter.get("/user", (req, res) => {
//     res.json({
//         "message": "Sarthak"
//     })
// })
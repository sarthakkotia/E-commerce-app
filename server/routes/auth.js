const express = require('express');
const User = require('../models/user');
const bcryptjs = require("bcryptjs");

const authRouter = express.Router();


//SIGN UP
authRouter.post("/api/signup", async (req, res) => {
    // console.log(req.body)
try {
        const {name, email, password} = req.body;
        const existedUser = await User.findOne({email: email})
        if(existedUser){
            return res.status(400).json({message: "User with same email already eists"});
        }

        const hashedPassword = await bcryptjs.hash(password, 8);
        const user = await User.create({
            email,
            password: hashedPassword,
            name
        });
        return res.json({user})
} catch (error) {
    res.status(500).json({error: error.message})
}
})


module.exports = authRouter;
// authRouter.get("/user", (req, res) => {
//     res.json({
//         "message": "Sarthak"
//     })
// })
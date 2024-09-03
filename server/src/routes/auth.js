const express = require('express');
const User = require('../models/user');
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');


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

//SIGN IN
authRouter.post("/api/signin", async (req, res) => {
    try {
        const {email, password} = req.body;
        // console.log(req.body);
        const user = await User.findOne({email});
        if(!user){
            return res.status(404).json({message: "User Not Found"});
        }
        // console.log(email);
        // console.log(user.password);
        const existingPassword = user.password;
        const isPasswordValid = await bcryptjs.compare(password, existingPassword);
        // console.log(isPasswordValid);
        if(!isPasswordValid){
            return res.status(404).json({message: "Password Incorrect"});
        }


        const token = jwt.sign({id: user._id}, "passwordKey");
        // return res.json({message: "Success! User logged In!", token, ...user});
        return res.json({token, ...user._doc, message: "Success! User logged in successfully"});;
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// JWT check
authRouter.post("/isTokenValid", async (req,res) => {
    try {
        const token = req.header("x-auth-token");
        if(!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey")
        if(!verified) return res.json(false);
        // check if the user exists
        const user = User.findById(verified.id);
        if(!user) return res.json(false);
        res.json(true);
    } catch (error) {
        res.status(500).json({
            error: error.message
        })
    }
})

// get user data
// invoking middleware to know if user is signed in
authRouter.get("/", auth, async (req,res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
})

module.exports = authRouter;
// authRouter.get("/user", (req, res) => {
//     res.json({
//         "message": "Sarthak"
//     })
// })
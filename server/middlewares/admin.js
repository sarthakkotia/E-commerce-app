const jwt = require("jsonwebtoken")
const User = require("../models/user.js")

const admin = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if(!token) return res.status(401).json({
            message: "No Auth Token, access denied"
        })


        const verified = jwt.verify(token, "passwordKey");
        if(!verified) return res.status(401),json({
            message: "Token Verification failed, authorization denied"
        })
        const user = await User.findById(verified.id);
        if(user.type === "user" || user.type === "seller"){
            return res.status(401).json({message: "You are not an admin"})
        }
        //adding a new object
        req.user = verified.id;
        req.token = token;
        next();


    } catch (err) {
        res.status(500).json({
            error: err.message
        });
    }
}
module.exports = admin; 
const express = require("express");
const auth = require("../middlewares/auth.js");
const { Product } = require("../models/product.js");
const User = require("../models/user");
const userRouter = express.Router();


userRouter.post("/api/add-to-cart", auth, async (req, res)=>{
    try {
        const {id} = req.body;
        const product = await Product.findById({id})
        if(!product){
            res.status(404).json({message: "product not found"})
        }
        const user = User.findById(req.user);
        const cart = user.cart
        if(cart.length == 0){
            cart.push({product, quantity: 1});
        }else{
            let isProductfound = false;
            for(let i=0; i<cart.length; i++){
                if(cart[i].product._id.equals(product._id)){
                    isProductfound = true;
                    cart[i].product.quantity++;
                    break;
                }
            }
            if(!isProductfound) {
                cart.push({product, quantity: 1});
            }
        }
        await user.updateOne({
            "_id": req.user._id
        },{$set: {cart: cart}})
        req.json({user})
    } catch (error) {
        res.status(500).json({error: e.message})
    }
})

module.exports = userRouter
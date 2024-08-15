const express = require("express");
const auth = require("../middlewares/auth.js");
const { Product } = require("../models/product.js");
const User = require("../models/user");
const Order = require("../models/order.js");
const userRouter = express.Router();


userRouter.post("/api/add-to-cart", auth, async (req, res)=>{
    try {
        const {id} = req.body;
        const product = await Product.findById(id)
        if(!product){
            res.status(404).json({message: "product not found"})
        }
        const user = await User.findById(req.user);
        // console.log("found user")
        // console.log(user.cart)
        const cart = user.cart
        let mutableCart = cart
        // console.log(mutableCart)
        if(!mutableCart){
            mutableCart = []
        }
        if(mutableCart.length == 0){
            mutableCart.push({product, quantity: 1});
        }else{
            // console.log("in this condition")
            let isProductfound = false;
            for(let i=0; i<mutableCart.length; i++){
                if(mutableCart[i].product._id.equals(product._id)){
                    isProductfound = true;
                    mutableCart[i].quantity++;
                    // console.log(mutableCart)
                    break;
                }
            }
            if(!isProductfound) {
                mutableCart.push({product, quantity: 1});
            }
        }
        // console.log("cart added")
        // console.log(req.user)
        // console.log(mutableCart)
        // console.log(req.user)
        const changed = await User.findByIdAndUpdate(
            req.user, {
                $set: {cart: mutableCart}
            },{
                new: true
            }
        )
        res.json({changed})
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

//colon for params
userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res)=>{
    try {
        const {id} = req.params;
        // or req.params.id
        const product = await Product.findById(id)
        if(!product){
            res.status(404).json({message: "product not found"})
        }
        const user = await User.findById(req.user);
        // console.log("found user")
        // console.log(user.cart)
        const cart = user.cart
        let mutableCart = cart
        // console.log(mutableCart)
        for(let i=0; i<mutableCart.length; i++){
            if(mutableCart[i].product._id.equals(product._id)){
                mutableCart[i].quantity--;
                // wll use splice to delete the product
                if(mutableCart[i].quantity == 0){
                    mutableCart.splice(i,1);
                }
                // console.log(mutableCart)
                break;
            }
        }
        // console.log("cart added")
        // console.log(req.user)
        // console.log(mutableCart)
        // console.log(req.user)
        const changed = await User.findByIdAndUpdate(
            req.user, {
                $set: {cart: mutableCart}
            },{
                new: true
            }
        )
        res.json({changed})
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

userRouter.post("/api/save-user-address", auth, async (req, res) => {
    try {
        const {address} = req.body;
        if(!address){
            res.status(400).json({message: "User address not found"})
        }
        const user = await User.findByIdAndUpdate(
            req.user, {
                $set: {address}
            },{
                new: true
            }
        )
        res.json(user)
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})


userRouter.post("/api/order", auth, async (req, res) => {
    try {
        const {cart, totalPrice, address} = req.body;
        let products = []
        for(let i=0; i<cart.length; i++){
            let product = await Product.findById(cart[i].product._id);
            //qty check
            if(product.quantity >= cart[i].quantity){
                product.quantity -= cart[i].quantity;
                products.push({product, quantity: cart[i].quantity});
                await Product.findByIdAndUpdate(cart[i].product._id, {
                    quantity: product.quantity
                });    
            }else{
                return res.status(400).json({message: `${product.name} is out of stock` })
            }
        }

        let user = await User.findById(req.user);
        user.cart = []
        user = await User.findByIdAndUpdate(req.user, {
            cart: user.cart
        }, {
            new: true
        })

        const order = await Order.create({
            products,
            totalPrice,
            address,
            userId: req.user,
            orderedAt: new Date().getTime(),
        })
        // console.log(order)
        res.json(order);
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

userRouter.get("/api/orders/me", auth, async (req, res) => {
    try {
        const orders = await Order.find({
            userId: req.user
        })
        // console.log(orders[0]);
        res.json(orders)
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})


module.exports = userRouter
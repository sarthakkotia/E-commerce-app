const express = require("express");
const Product = require("../models/product");
const { default: mongoose } = require("mongoose");
const productRouter = express.Router();
const auth = require("../middlewares/auth.js")

// api/products?category=Essentials
productRouter.get("/api/products", auth, async (req, res)=>{
    try {   
        // user req.query.category for diff queries access 
        // for api/products:category=Essentials use req.params
        const products = await Product.find({
            category: req.query.category
        });
        // finds the document for a particular field but if no argument then would return all
        // console.log(products);
        res.json({products})
        
    } catch (error) {
        
        res.status(500).json({error: e.message})
    }
})


module.exports = productRouter
const express = require("express")
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Product = require("../models/product");

// Creating an admin middleware
adminRouter.post("/admin/add-product", admin, async (req, res)=>{
    try {
        const {name, description, images, category, price, quantity} = req.body;
        const product = await Product.create({
            name,
            description,
            images,
            quantity,
            price,
            category
        });
        res.json(product);  
    } catch (error) {
        res.status(500).json({error: e.message})
    }
})

module.exports = adminRouter
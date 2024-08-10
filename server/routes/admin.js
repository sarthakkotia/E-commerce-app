const express = require("express")
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const {Product} = require("../models/product");
const { default: mongoose } = require("mongoose");

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

adminRouter.get("/admin/get-products",admin, async (req, res)=>{
    try {   
        
        const products = await Product.find({});
        // finds the document for a particular field but if no argument then would return all
        // console.log(products);
        res.json({products})
        
    } catch (error) {
        
        res.status(500).json({error: e.message})
    }
})

// Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res)=>{
    try {
        // console.log("came into the function")
        const {id} = req.body;
        console.log(id)
        const response = await Product.findByIdAndDelete(id);
        console.log(response)
        if(!response)
            res.status(500).json({message: "An Error Occured, please try again"});
        res.json({message: "Product delted successfully"})
        // console.log("going out of the function")

    } catch (error) {
        // console.log("error came")
        res.status(500).json({error: error.message})
    }
})

module.exports = adminRouter
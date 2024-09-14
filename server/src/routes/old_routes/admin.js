const express = require("express")
const adminRouter = express.Router();
const admin = require("../../middlewares/admin");
const {Product} = require("../models/product");
const {Order} = require("../models/order");
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
        // console.log(id)
        const response = await Product.findByIdAndDelete(id);
        // console.log(response)
        if(!response)
            res.status(500).json({message: "An Error Occured, please try again"});
        res.json({message: "Product delted successfully"})
        // console.log("going out of the function")

    } catch (error) {
        // console.log("error came")
        res.status(500).json({error: error.message})
    }
})

adminRouter.get("/admin/get-orders", admin, async (_, res) => {
    try {
        const orders = await Order.find({})
        res.json({orders})
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
    try {
        const {id, status} = req.body
        const order = await Order.findByIdAndUpdate(
            id,
            {
                $set: {
                    status: status
                }
            }, {
                new: true
            }
        )
        console.log(order);
        res.json({order});
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

adminRouter.get("/admin/analytics", admin, async (req, res) => {
try {
    // get orders
    const orders = await Order.find({});
    let totalEarnings = 0
    // go through every order and it's every product andd add the earned amount
    // console.log(orders)
    for(let i = 0; i<orders.length; i++){
        const order = orders[i];
        // console.log(order)
        totalEarnings += order["totalPrice"]
    }
    //category search
    const mobilesEarnings = await fetchCategoryWiseEarnings("Mobiles")
    const essentialsEarnings = await fetchCategoryWiseEarnings("Essentials")
    const appliancesEarnings = await fetchCategoryWiseEarnings("Appliances")
    const booksEarnings = await fetchCategoryWiseEarnings("Books")
    const fashionEarnings = await fetchCategoryWiseEarnings("Fashion")

    const earnings = {
        totalEarnings,
        mobilesEarnings,
        essentialsEarnings,
        appliancesEarnings,
        booksEarnings,
        fashionEarnings
    }
    res.json({
        earnings
    })
} catch (error) {
    res.status(500).json({error: error.message})
}
})

async function fetchCategoryWiseEarnings(category){
    // console.log(category)
    let categoryOrders = await Order.find({
        "products.product.category": category
    });
    // console.log(categoryOrders)
    let earnings = 0
    for(let i=0; i<categoryOrders.length; i++){
        const order = categoryOrders[i];
        // console.log(order)
        const products = order.products;
        // console.log(products)
        for(let j=0; j<products.length; j++){
            if(products[j].product.category == category)
                earnings += products[j].quantity * products[j].product.price
        }
    }
    return earnings;
}

module.exports = adminRouter
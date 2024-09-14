const express = require("express");
const {Product} = require("../models/product");
const { default: mongoose } = require("mongoose");
const productRouter = express.Router();
const auth = require("../../middlewares/auth.js");

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

//api/products/search/iphone
// /api/products/search/:name
// /api/products/search/:name/:na

productRouter.get("/api/products/search/:name", auth, async (req, res)=>{
    try {   
        // user req.query.category for diff queries access 
        // for api/products:category=Essentials use req.params
        const products = await Product.find({
            name: {
                // for fuzzy search
                // i for case insensitivity
                //alternate approach could have been if we pass a exactly correct name
                $regex: req.params.name, $options: "i"
            }
        });
        // finds the document for a particular field but if no argument then would return all
        // console.log(products);
        res.json({products})
        
    } catch (error) {
        res.status(500).json({error: e.message})
    }
})

productRouter.post("/api/products/rate-product", auth, async (req, res) => {
    try {
        const {id, rating} = req.body;
        let product = await Product.findById(id);
        // console.log(product);
        // const isuserPresent = product.ratings.find((rate)=> {
        //     return rate.userId == id;
        // })
        for(let i =0; i<product.ratings.length; i++){
            if(product.ratings[i].userId == req.user){
                // splice is used to delete the entry
                product.ratings.splice(i, 1);
                break;
            }
        }
        const ratingSchema = {
            userId: req.user,
            rating
        }
        product.ratings.push(ratingSchema);
        product = await product.save();
        // if(!isuserPresent){
        //     const userRatings = product.ratings
        //     userRatings.push({
        //         userId: id,
        //         rating: rating
        //     })

        //     await Product.findByIdAndUpdate(
        //         id,
        //         {
        //             $set:{
        //                 ratings: userRatings
        //             }
        //         }
        //     )

        // }else{
        //     // console.log("testing")
        //     let idx = product.ratings.findIndex((rate) => {
        //         return rate.userId == id;
        //     })
        //     const userRatings = product.ratings
        //     // console.log(rating)
        //     userRatings[idx].rating = rating
        //     console.log(userRatings)
        //     await Product.findByIdAndUpdate(
        //         id,
        //         {
        //             $set:{
        //                 ratings: userRatings
        //             }
        //         }
        //     )
        // }
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
    try {
        let products = await Product.find({});
        // sort products wrt total rating in descending manner
        const sortedRatings = products.sort((a,b) => {
            let aSum = 0;
            let bSUm = 0;
            for(let i=0; i<a.ratings.length; i++){
                aSum += a.ratings[i];
            }
            for(let i=0; i<b.ratings.length; i++){
                bSUm += b.ratings[i];
            }
            return aSum > bSUm;
        })
        // console.log(sortedRatings);
        res.json({
            product: sortedRatings[0]
        });



    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

module.exports = productRouter
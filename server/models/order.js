const mongoose = require("mongoose");
const cartProductSchema = require("./cartProduct");
const { productSchema } = require("./product");

const orderSchema = new mongoose.Schema({
    products: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true
            }
        }
    ],
    totalPrice: {
        type: Number,
        required: true
    },
    address: {
        type: String, 
        required: true
    },
    userId: {
        type: String,
        required: true
    },
    status: {
        type: Number,
        default: 0
    },
    orderedAt: {
        type: Number,
        required: true
    }
}, {timestamps: true})

const Order = mongoose.model("Order", orderSchema);
module.exports = {Order};
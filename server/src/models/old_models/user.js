const mongoose = require('mongoose');
const {productSchema} = require('./product.js');

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Plase enter a valid email address"
        }
    },
    password: {
        required: true,
        type: String,
        validator: (value) => {
            return value.length > 6;
        },
        message: "Please enter a longer password"
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "user",
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true
            },
        }
    ],
}, {timestamps: true})

const User = mongoose.model("User", userSchema);
module.exports = User;
import mongoose from "mongoose";
import bcrypt from "bcrypt"

const validateEmail = function(email){
    const re =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    return value.match(re);
}

const validatePassword = function(password){
    return password.length > 6;
}

const userSchema = new mongoose.Schema({
    name: {
        type: String, 
        required: true,
        trim: true,
        index: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        index: true,
        validator: [validateEmail, "Please enter a valid email address"],
        isvalid: Boolean
    },
    password: {
        required: true,
        type: String,
        validator: [validatePassword, "Please enter a longer password"]
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        enum: ["user","seller"],
        default: "user"
    },
    // cart: 
    // refresh Token
}, {timestamps: true})

userSchema.pre("save", async function (next){
    if(!this.isModified("password")) return next();
    this.password = await bcrypt.hash(this.password)
    next()
})

export const User = mongoose.model("User", userSchema)
import { User } from "../models/user.model.js";
import { APIError } from "../utils/APIError.js";
import { asyncHandler } from "../utils/asyncHandler.js";

const register_user = asyncHandler(
    async (req, res) => {
        const {name, email, password, address} = req.body
        if(!name || !email || !password){
            return res.status(400),json({
                message: "please enter valid arguments"
            })
        }
        const existedUser = await User.find({email})
        if(existedUser){
            return res.status(400).json({
                message: "email already exists"
            })
        }
        const user = await User.create({
            name,
            email,
            password,
            type: "user",
            address: address ? address: ""
        })
        const createdUser = await User.findById(user._id).select(
            "-password"
        )
        if(!createdUser){
            throw APIError("Server error to create user, please try again")
        }
        return res.status(201).json({
            message: "User created successfully"
        })
    }
)
export {register_user}
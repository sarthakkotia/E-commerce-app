import { asyncHandler } from "../utils/asyncHandler.js";

// TODO: get name, email, password, address?, type
// TODO: validate all these values
// TODO: check if user already exists
// TODO: create user
// TODO: give response back

const register_user = asyncHandler(
    async (req, res) => {
        res.status(200).json({
            message: "OK"
        })
    }
)
export {register_user}
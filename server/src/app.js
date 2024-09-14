import express from "express";
import userRouter from "./routes/user.routes.js";
const app = express()

// this acts as a body parser for json ie accepting json data
// prepare express for accepting json data
app.use(express.json({
    limit: '16kb'
}))

// prepare express to accept url data
app.use(express.urlencoded({
    // to send objects into onjects
    extended: true,
    limit: '16kb'
}))


app.use("/api/user",userRouter)

export {app}
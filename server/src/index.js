// console.log("Hello, World!")
// Packages
import dotenv from "dotenv";
dotenv.config({
  path: "./env"
})
// import express from "express";
// import mongoose from "mongoose";
// from files
// const authRouter = require("./routes/auth.js");
// const adminRouter = require('./routes/admin.js');
// const productRouter = require('./routes/product.js');
// const userRouter = require('./routes/user.js');
import { connectDB } from "./db/db_connect.js";


connectDB()
const PORT = process.env.PORT || 3000;




// Initalization
// const app = express();
// // middleware
// app.use(express.json())
// app.use(authRouter);
// app.use(adminRouter);
// app.use(productRouter);
// app.use(userRouter)

// //connections
// mongoose.connect(DB).then(() => {
//   console.log("Connection Successful");
// }).catch((e) => {
//   console.log(`Error Occured ${e}`)
// })

// app.listen(PORT, "0.0.0.0" ,() => {
//     console.log(`Connected at port : ${PORT}`);
// } )

// app.get('/', function (req, res) { 
//   res.json({"name": "sarthak"});
// })

// app.get("/hello-world", (_, res) => {
//     res.send("Hello, World! 👋");
// })

// // app.listen(PORT, ()=>{
// //     console.log(`App is listening on port: ${PORT}`)
// // })
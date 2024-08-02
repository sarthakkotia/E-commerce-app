// console.log("Hello, World!")
// Packages
const express = require('express');
const mongoose = require('mongoose');
// from files
const authRouter = require("./routes/auth.js");


// Initalization
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://admin:admin@cluster0.vgqvht2.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
// middleware
app.use(express.json())
app.use(authRouter);

//connections
mongoose.connect(DB).then(() => {
  console.log("Connection Successful");
}).catch((e) => {
  console.log(`Error Occured ${e}`)
})

app.listen(PORT, "0.0.0.0" ,() => {
    console.log(`Connected at port : ${PORT}`);
} )

app.get('/', function (req, res) { 
  res.json({"name": "sarthak"});
})

// app.get("/hello-world", (_, res) => {
//     res.send("Hello, World! 👋");
// })

// // app.listen(PORT, ()=>{
// //     console.log(`App is listening on port: ${PORT}`)
// // })
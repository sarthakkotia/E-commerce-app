// console.log("Hello, World!")
// Packages
const express = require('express');

// from files
const authRouter = require("./routes/auth.js");


// Initalization
const app = express();
const PORT = 3000;

// middleware
app.use(authRouter);


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
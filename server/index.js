const e = require("express");
const express =require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const cors = require("cors");

const PORT = process.env.PORT | 3001;
const app = express();

app.use(cors());
app.use(express.json());
app.use(authRouter);

const DB = "mongodb+srv://khanh192:test123@cluster0.51wqxcb.mongodb.net/?retryWrites=true&w=majority";

mongoose.connect(DB).then(() => {
    console.log("Connected successfully!");
}).catch((err) =>{
    console.log(err);
});


app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});
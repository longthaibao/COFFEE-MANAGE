//import package
require("dotenv").config(); // For using process.env
const express = require("express");
const multer = require("multer");
const cors = require("cors");
const bodyParser = require("body-parser");

//import route object

const adminInfo = require('./routes/adminInfo')
const login = require('./routes/login');
const customer = require('./routes/customer');
const showInfoEmp = require('./routes/showInfoEmp');
const thutuc2 = require('./routes/thutuc2');
//init app object
const app = express();
// xác thực khi dùng APIs
app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE"],
  })
);
// các loại file truyền
var upload = multer();
app.use(upload.array());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));

// API dùng

app.use("/api/admin/adminInfo", adminInfo);
app.use("/api/login", login);
app.use('/api/admin/thutuc2', thutuc2);
app.use("/api/admin/showInfoEmp", showInfoEmp);
app.use('/api/admin/customer', customer);


app.listen(process.env.SV_PORT, "localhost", () => {
  console.log(`Example app listening on port ${process.env.SV_PORT}`);
});



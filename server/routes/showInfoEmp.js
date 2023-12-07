const express = require("express");
const router = express.Router();

const { ShowInfoEmp } = require("../BusinessLayer/ShowInfoEmp/ShowInfoEmp");

router.get("/getInfoEmp", ShowInfoEmp); //API: http://localhost:3001/api/admin/adminInfo/ShowInfoEmp sẽ gọi hàm ShowInfoEmp sử dụng HTTP GET
module.exports = router;

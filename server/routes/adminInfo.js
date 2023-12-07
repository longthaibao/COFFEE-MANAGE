const express = require("express");
const router = express.Router();

const {GetAdminInfo} = require("../BusinessLayer/AdminInfo/AdminInfo");

router.get('/GetAdminInfo', GetAdminInfo);//API: http://localhost:3001/api/admin/adminInfo/GetAdminInfo sẽ gọi hàm GetAdminInfo sử dụng HTTP GET
module.exports = router

const express = require("express");
const router = express.Router();
const { LoginState } = require("../BusinessLayer/Login/Login");

router.post('/Login', LoginState); //API: http://localhost:3001/api/login/Login sẽ gọi hàm LoginState sử dụng HTTP POST

module.exports = router;

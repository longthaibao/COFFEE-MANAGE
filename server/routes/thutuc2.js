const express = require("express");
const router = express.Router();
const {Thutuc2} = require("../BusinessLayer/Thutuc2/thutuc2");


router.post('/', Thutuc2);
module.exports = router

const express = require("express");
const router = express.Router();

const { GetCustomer, InsertCustomer, UpdateCustomer, DeleteCustomer } = require("../BusinessLayer/Customer/Customer");

router.get('/getCustomer', GetCustomer);//API: http://localhost:3001/api/admin/customer/getCustomer sẽ gọi hàm GetAdminInfo sử dụng HTTP GET

router.post('/insertCustomer', InsertCustomer);//API: http://localhost:3001/api/admin/customer/insertCustomer

router.put('/updateCustomer', UpdateCustomer);//API: http://localhost:3001/api/admin/customer/updateCustomer

router.delete('/deleteCustomer', DeleteCustomer);//API: http://localhost:3001/api/admin/customer/deleteCustomer

module.exports = router
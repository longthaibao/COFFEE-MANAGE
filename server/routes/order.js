const express = require("express");
const router = express.Router();

const { InsertCustomer, UpdateCustomer, DeleteOrder, GetOrder, ViewOrder } = require("../BusinessLayer/Order/order");

router.get('/getOrder', GetOrder);//API: http://localhost:3001/api/admin/customer/getCustomer sẽ gọi hàm GetAdminInfo sử dụng HTTP GET

router.post('/insertOrder', InsertCustomer);//API: http://localhost:3001/api/admin/customer/insertCustomer

router.put('/updateCustomer', UpdateCustomer);//API: http://localhost:3001/api/admin/customer/updateCustomer

router.delete('/deleteOrder', DeleteOrder);//API: http://localhost:3001/api/admin/customer/deleteCustomer

router.get('/viewOrder', ViewOrder);


module.exports = router
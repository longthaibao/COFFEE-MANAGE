const express = require("express");
const router = express.Router();

const { ShowInfoEmp } = require("../BusinessLayer/ShowInfoEmp/ShowInfoEmp");
const {
  CreateEmployee,
  DeleteEmployee,
  UpdateEmployee,
} = require("../BusinessLayer/ShowInfoEmp/ShowInfoEmp");

router.post("/getInfoEmp", ShowInfoEmp); //API: http://localhost:3001/api/admin/adminInfo/ShowInfoEmp sẽ gọi hàm ShowInfoEmp sử dụng HTTP GET
router.post("/create/employee", CreateEmployee);
router.post("/delete/employee", DeleteEmployee);
router.post("/update/employee", UpdateEmployee);
module.exports = router;

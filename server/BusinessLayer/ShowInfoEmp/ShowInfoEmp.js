const {
  showInfoEmp,
  createEmployee,
  deleteEmployee,
  updateEmployee,
} = require("../../PersistenceLayer/ShowInfoEmp");

const ShowInfoEmp = async (req, res) => {
  let data = await showInfoEmp(req.body.job_type);
  return res.status(200).json(data[0]);
};

const CreateEmployee = async (req, res) => {
  try {
    let employee_name = req.body.employee_name;
    let employee_gender = req.body.employee_gender;
    let employee_email = req.body.employee_email;
    let job_type = req.body.job_type;
    let job_id = 1;
    if (job_type === "Thu ngân") job_id = 2;
    else if (job_type === "Pha chế") job_id = 3;
    else if (job_type === "Bảo vệ") job_id = 4;
    else if (job_type === "Tạp vụ") job_id = 5;
    let data = await createEmployee(
      employee_name,
      employee_gender,
      employee_email,
      job_id
    );
    if (data.error) {
      return res
        .status(500)
        .json({ success: false, message: "Failed to insert customer" });
    }
    if (data) {
      return res.status(200).json({
        success: true,
        message: "Customer inserted successfully",
        job_id: job_id,
        job_type: job_type,
      });
    } else {
      return res
        .status(500)
        .json({ success: false, message: "Failed to insert customer" });
    }
  } catch (error) {
    console.error("Error in InsertCustomer route:", error);
    console.log(error.code);
  }
};
const DeleteEmployee = async (req, res) => {
  let data = await deleteEmployee(req.body.ID);
  return res.status(200).json(data[0]);
};
const UpdateEmployee = async (req, res) => {
  let data = await updateEmployee(
    req.body.ID,
    req.body.employee_name,
    req.body.employee_gender,
    req.body.employee_email
  );
  return res.status(200).json(data[0]);
};

module.exports = {
  ShowInfoEmp,
  CreateEmployee,
  DeleteEmployee,
  UpdateEmployee,
};

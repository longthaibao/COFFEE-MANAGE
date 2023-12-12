const connection = require("./DataBase");

const showInfoEmp = async (job_type) => {
  const query = `CALL showNv(?);`;
  const [result, fields] = await connection.query(query, [job_type]);
  return result;
};
const createEmployee = async (
  employee_name,
  employee_gender,
  employee_email,
  job_id
) => {
  try {
    const emailCheckQuery =
      "SELECT COUNT(*) AS emailCount FROM employee WHERE employee_email = ?";
    const [emailCheckResult] = await connection.query(emailCheckQuery, [
      employee_email,
    ]);

    if (emailCheckResult[0].emailCount > 0) {
      console.error("Email đã tồn tại trong cơ sở dữ liệu.");
      return { error: "Email đã tồn tại trong cơ sở dữ liệu." };
    }
    const query = `CALL insertEmployee(?,?,?,?);`;
    const [result, fields] = await connection.query(query, [
      employee_name,
      employee_gender,
      employee_email,
      job_id,
    ]);
    return result;
  } catch (error) {
    console.error("Lỗi khi thực hiện truy vấn:", error);
    throw error;
  }
};
const deleteEmployee = async (ID) => {
  const query = `CALL deleteEmployee(?);`;
  const [result, fields] = await connection.query(query, [ID]);
  return result;
};
const updateEmployee = async (
  ID,
  employee_name,
  employee_gender,
  employee_email
) => {
  const query = `CALL updateEmployee(?,?,?,?);`;
  const [result, fields] = await connection.query(query, [
    ID,
    employee_name,
    employee_gender,
    employee_email,
  ]);
  return result;
};

module.exports = {
  showInfoEmp,
  createEmployee,
  deleteEmployee,
  updateEmployee,
};

const connection = require("./DataBase");

const showInfoEmp = async (job_type) => {
  const query = `CALL showNv(?);`;
  const [result, fields] = await connection.query(query, [job_type]);
  return result;
};

module.exports = { showInfoEmp };

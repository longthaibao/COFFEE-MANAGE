const { showInfoEmp } = require("../../PersistenceLayer/ShowInfoEmp");

const ShowInfoEmp = async (req, res) => {
  let data = await showInfoEmp(req.body.job_type);
  return res.status(200).json(data[0]);
};

module.exports = { ShowInfoEmp };

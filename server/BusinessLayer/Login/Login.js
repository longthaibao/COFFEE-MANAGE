const { login } = require("../../PersistenceLayer/LoginDAO");

const LoginState = async (req, res) => {
  let id = req.body.id;
  let pass = req.body.pass;
  let data = await login(id, pass);
  return res.status(200).json(data[0]);
};

module.exports = { LoginState };

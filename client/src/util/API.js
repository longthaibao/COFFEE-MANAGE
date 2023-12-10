const localhost = "http://localhost:3001/api";


//! API chính 
const APILogin = localhost + "/login";//đăng nhập
const APIadminThutuc2 = localhost + "/admin/thutuc2";//lấy thông tin chủ tài khoản

const APIs = {APILogin, APIadminThutuc2};
export default APIs;
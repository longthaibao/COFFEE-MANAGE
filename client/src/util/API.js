const localhost = "http://localhost:3001/api";


//! API chính 
const APIadminGetInfo = localhost + "/admin/adminInfo";//lấy thông tin chủ tài khoản
const APILogin = localhost + "/login";//đăng nhập

const APIs = {APILogin, APIadminGetInfo};
export default APIs;
import { Link } from "react-router-dom";
import React, { useState } from "react";
import {
  ProSidebar,
  Menu,
  MenuItem,
  SidebarHeader,
  SidebarFooter,
  SidebarContent,
} from "react-pro-sidebar";
import "react-pro-sidebar/dist/css/styles.css";
import { HiPencilAlt, HiOutlineCheck } from "react-icons/hi";
import { HiOutlineBuildingStorefront } from "react-icons/hi2";
import { FiHome, FiLogOut, FiUsers } from "react-icons/fi";
const SideBar = () => {
  //create initial menuCollapse state using useState hook
  const [menuCollapse, setMenuCollapse] = useState(false);
  const [active, setActive] = useState(false);
  //create a custom function that will change menucollapse state from false to true and true to false
  const menuIconClick = () => {
    //condition checking to change state from true to false and vice versa
    menuCollapse ? setMenuCollapse(false) : setMenuCollapse(true);
  };
  // handle change the state active
  const handleMenuActive = () => {
    active ? setActive(true) : setActive(false);
  };
  const logout = async () => {
    const expirationTime = new Date(Date.now() - 60 * 1000);
    document.cookie = `admin_cookie_id=null; expires=${expirationTime.toUTCString()}; path=/`;
    window.location.href = "http://localhost:3000/login";
  };
  return (
    <>
      <div id="header">
        <ProSidebar collapsed={menuCollapse}>
          <SidebarHeader>
            <div className="logotext">
              <img src="/logo.png" alt="" />
            </div>
          </SidebarHeader>
          <SidebarContent>
            <Menu iconShape="square">
              <MenuItem icon={<FiHome />}>
                <Link to="/admin/test_laythongtincanhantubangemployee">
                  Trang chủ
                </Link>
              </MenuItem>
              <MenuItem icon={<HiOutlineBuildingStorefront />}>
                <Link to="/admin/store">Cửa hàng</Link>
              </MenuItem>
              <MenuItem icon={<FiUsers />}>
                <Link to="/admin/themxoasua">Danh sách khách hàng</Link>
              </MenuItem>
              <MenuItem icon={<HiPencilAlt />}>
                <Link to="/admin/thutuc1"> Danh sách nhân viên</Link>
              </MenuItem>
              <MenuItem icon={<HiOutlineCheck />}>
                <Link to="/admin/thutuc2">Thống kê CTKM</Link>
              </MenuItem>
              <MenuItem icon={<HiOutlineCheck />}>
                <Link to="/admin/hoadon">Quản lý hóa đơn</Link>
              </MenuItem>
            </Menu>
          </SidebarContent>
          <SidebarFooter>
            <Menu iconShape="square">
              <MenuItem icon={<FiLogOut />}>
                <Link onClick={logout}>Đăng xuất</Link>
              </MenuItem>
            </Menu>
          </SidebarFooter>
        </ProSidebar>
      </div>
    </>
  );
};

export default SideBar;

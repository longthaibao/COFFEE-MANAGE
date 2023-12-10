import { Link } from "react-router-dom";
//import useState hook to create menu collapse state
import React, { useState } from "react";

//import react pro sidebar components
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
import {
  FiHome,
  FiLogOut,
  FiArrowLeftCircle,
  FiArrowRightCircle,
  FiUsers,
} from "react-icons/fi";

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

  return (
    <>
      <div id="header">
        <ProSidebar collapsed={menuCollapse}>
          <SidebarHeader>
            <div className="logotext">
              <img
                src="https://svn.apache.org/repos/asf/lucene.net/branches/3.0.3/branding/logo/lucene-net-icon-512x256.png"
                alt=""
              />
            </div>
          </SidebarHeader>
          <SidebarContent>
            <Menu iconShape="square">
              <MenuItem icon={<FiHome />}>
                <Link to="/admin/test_laythongtincanhantubangemployee">
                  Trang chủ
                </Link>
              </MenuItem>
              <MenuItem icon={<FiUsers />}>
                <Link to="/admin/themxoasua">Danh sách khách hàng</Link>
              </MenuItem>
              <MenuItem icon={<HiPencilAlt />}>
                <Link to="/admin/thutuc1"> Danh sách nhân viên</Link>
              </MenuItem>
              <MenuItem icon={<HiOutlineCheck />}>
                <Link to="/admin/thutuc2">Validation Congés</Link>
              </MenuItem>
              {/* <MenuItem icon={<BiCog />}>Settings</MenuItem> */}
            </Menu>
          </SidebarContent>
          <SidebarFooter>
            <Menu iconShape="square">
              <MenuItem icon={<FiLogOut />}>
                <Link to={"/logout"}>Logout</Link>
              </MenuItem>
            </Menu>
          </SidebarFooter>
        </ProSidebar>
      </div>
    </>
  );
};

export default SideBar;

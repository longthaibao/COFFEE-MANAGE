import React, { Fragment } from "react";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import { Navbar, Typography, IconButton } from "@material-tailwind/react";
import { faRightFromBracket } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

export default function Header() {
  const [openNav, setOpenNav] = React.useState(false);
  const navigate = useNavigate();
  const logout = async () => {
    const expirationTime = new Date(Date.now() - 60 * 1000);
    document.cookie = `admin_cookie_id=null; expires=${expirationTime.toUTCString()}; path=/`;
    window.location.href = "http://localhost:3000/login";
  };
  React.useEffect(() => {
    window.addEventListener(
      "resize",
      () => window.innerWidth >= 960 && setOpenNav(false)
    );
  }, []);
  const actionList = (
    <ul className="mt-2 mb-4 flex flex-col gap-2 lg:mb-0 lg:mt-0 lg:flex-row lg:items-center lg:gap-6">
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal hover:cursor-pointer"
      >
        <img src="/flag.jpeg" alt=""></img>
      </Typography>
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal"
        style={{
          color: "#666666",
          fontWeight: "bold",
        }}
      >
        <Link onClick={logout} className="flex items-center m-4">
          <p className="m-2">Log out</p>
          <FontAwesomeIcon icon={faRightFromBracket}></FontAwesomeIcon>
        </Link>
      </Typography>
    </ul>
  );
  const navList = (
    <ul className="mt-2 mb-4 flex flex-col gap-2 lg:mb-0 lg:mt-0 lg:flex-row lg:items-center lg:gap-6">
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal hover:bg-orange-900 hover:rounded-lg  "
      >
        <Link
          to="/admin/test_laythongtincanhantubangemployee"
          className="flex items-center  "
          style={{ color: "white", fontWeight: "bold" }}
        >
          PROFILE
        </Link>
      </Typography>
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal hover:bg-orange-900 hover:rounded-lg "
        style={{ color: "white", fontWeight: "bold" }}
      >
        <Link to="/admin/store" className="flex items-center">
          STORE
        </Link>
      </Typography>
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal hover:bg-orange-900 hover:rounded-lg "
        style={{ color: "white", fontWeight: "bold" }}
      >
        <Link to="/admin/themxoasua" className="flex items-center">
          CUSTOMERS
        </Link>
      </Typography>
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal hover:bg-orange-900 hover:rounded-lg "
        style={{ color: "white", fontWeight: "bold" }}
      >
        <Link to="/admin/thutuc1" className="flex items-center">
          EMPLOYEES
        </Link>
      </Typography>
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal hover:bg-orange-900 hover:rounded-lg "
        style={{ color: "white", fontWeight: "bold" }}
      >
        <Link to="/admin/thutuc2" className="flex items-center">
          DISCOUNTS
        </Link>
      </Typography>
      <Typography
        as="li"
        variant="small"
        color="blue-gray"
        className="p-1 font-normal hover:bg-orange-900 hover:rounded-lg "
        style={{ color: "white", fontWeight: "bold" }}
      >
        <Link to="/admin/hoadon" className="flex items-center">
          BILLS
        </Link>
      </Typography>
    </ul>
  );
  return (
    <>
      <div className="-m-6 max-h-[768px] w-[calc(100%+48px)] overflow-scroll">
        <Navbar className="bg-red-300 sticky top-0 z-10 h-max max-w-full rounded-none px-4 py-2 lg:px-8 lg:py-4 text-black">
          <div className="flex items-center justify-between text-blue-gray-900">
            <Typography
              as="a"
              href="/admin/test_laythongtincanhantubangemployee"
              className="mr-4 cursor-pointer py-1.5 font-medium"
            >
              <img className="h-20 m-2" src="/logo.png" alt="logo"></img>
            </Typography>
            <div className="flex items-center gap-4">
              <div className="mr-4 hidden lg:block">{navList}</div>
            </div>
            <div className="flex items-center gap-4">
              <div className="mr-4 hidden lg:block">{actionList}</div>
            </div>
          </div>
        </Navbar>
      </div>
    </>
  );
}

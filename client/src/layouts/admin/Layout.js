import React, { useEffect } from "react";
import { Outlet } from "react-router-dom";
import SideBar from "./Sidebar";
import Header from "./Header";
import Footer from "./Footer";

export default function Layout() {
  const [currentBackground, setCurrentBackground] = React.useState(0);

  const backgrounds = [
    "/cafe.png",
    "/cafe2.png",
    "/cafe3.png",
    // Thêm các đường dẫn hình ảnh nền khác nếu cần
  ];
  useEffect(() => {
    const intervalId = setInterval(() => {
      // Xoay giữa các hình ảnh nền
      setCurrentBackground((prev) => (prev + 1) % backgrounds.length);
    }, 4000); // Thay đổi mỗi 5 giây (đơn vị là milliseconds)

    return () => clearInterval(intervalId);
  }, []); // Chạy chỉ một lần sau khi component được render
  return (
    <>
      <div
        className="h-screen w-screen overflow-hidden flex flex-row"
        style={{
          backgroundImage: `url(${process.env.PUBLIC_URL}${backgrounds[currentBackground]})`,
          backgroundSize: "fit",
          transition: "background-image 2s ease-in-out", // Hiệu ứng chuyển động
        }}
      >
        {/* <SideBar /> */}
        <div
          className="flex flex-col flex-1"
          style={{
            fontFamily: "Jetbrains Mono",
          }}
        >
          <Header />
          <div className="flex-1 p-4 min-h-0 overflow-auto">
            <Outlet />
          </div>
          <Footer />
        </div>
      </div>
    </>
  );
}

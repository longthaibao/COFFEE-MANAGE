import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Login from "./pages/login/login";
import LayoutAdmin from "./layouts/admin/Layout";
import Testlaythongtincanhan from "./pages/admin/testlaythongtincanhan";
import Thutuc1 from "./pages/admin/thutuc1";
import Thutuc2 from "./pages/admin/thutuc2";
import Themxoasua from "./pages/admin/themxoasua";
import Home from "./pages/home/home";
import StoreRevenue from "./pages/admin/store";
import Hoadon from "./pages/admin/hoadon";
export default function App() {
  return (
    <>
      <Routes>
        <Route path="/admin/" element={<LayoutAdmin />}>
          <Route index element={<homeAdmin />} />
          <Route path="test_laythongtincanhantubangemployee" element={<Testlaythongtincanhan />} />
          <Route  path="store" element={<StoreRevenue/>}/>
          <Route path="themxoasua" element={<Themxoasua />} />
          <Route path="thutuc1" element={<Thutuc1 />} />
          <Route path="thutuc2" element={<Thutuc2 />} />
          <Route path="hoadon" element={< Hoadon/>} />
        </Route>
        <Route path="login" element={<Login />} />
        <Route path="/" element={<Home />} />
      </Routes>
    </>
  );
}
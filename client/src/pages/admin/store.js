import React from "react";
import axios from "axios";
import { FaCoffee } from "react-icons/fa";
import { useState, useEffect } from "react";
import moment from "moment-timezone";
import ProRevTable from "../../components/ProductStore";

const API_URL = "http://localhost:3001/api/admin";

const api = axios.create({
  baseURL: API_URL,
});

const storeCookie = document.cookie
  .split("; ")
  .find((cookie) => cookie.startsWith(`storeID=`));

// Check if storeCookie is defined before trying to split and access values
const storeID = storeCookie ? storeCookie.split("=")[1] : null;
export default function StoreRevenue() {
  const storeName = () => {
    if (storeID == 1) return "Cửa hàng Lý Thường Kiệt";
    return "Cửa hàng Tạ Quang Bửu";
  };
  const nameStyle = {
    display: "flex",
    fontWeight: "bold",
    fontSize: "35px",
    marginLeft: "30px",
    alignItems: "start",
  };
  const [selectedStartDate, setSelectedStartDate] = useState(new Date());

  const handleStartDateChange = (event) => {
    const newDate = new Date(event.target.value);
    setSelectedStartDate(newDate);
  };

  const [selectedEndDate, setSelectedEndDate] = useState(new Date());
  const handleEndDateChange = (event) => {
    const newDate = new Date(event.target.value);
    setSelectedEndDate(newDate);
  };

  const [totalRevenue, settotalRevenue] = useState(0);
  const [totalProduct, settotalProduct] = useState(0);
  const [bestsellerID, setbestsellerID] = useState(0);
  const [producFromTable, setproductFromTable] = useState([]);

  const handleData = (data) => {
    setproductFromTable(data);
  };

  const formatStart = moment(selectedStartDate).format("YYYY-MM-DD");
  const formatEnd = moment(selectedEndDate).format("YYYY-MM-DD");
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await api.post("/getProRev/totalrevenue", {
          store: storeID,
          start: formatStart,
          end: formatEnd,
        });
        if (response.status == 200) {
          settotalRevenue(response.data.data);
        }
      } catch (error) {
        console.error("Error fetching customers:", error);
        throw error;
      }
    };
    fetchData();

    const fetchData2 = async () => {
      try {
        const response = await api.post("/getProRev/totalproduct", {
          store: storeID,
          start: formatStart,
          end: formatEnd,
        });
        if (response.status == 200) {
          settotalProduct(response.data.data);
        }
      } catch (error) {
        console.error("Error fetching customers:", error);
        throw error;
      }
    };
    fetchData2();

    const fetchData3 = async () => {
      try {
        const response = await api.post("/getProRev/bestseller", {
          store: storeID,
          start: formatStart,
          end: formatEnd,
        });
        if (response.status == 200) {
          setbestsellerID(response.data.data);
        }
      } catch (error) {
        console.error("Error fetching customers:", error);
        throw error;
      }
    };
    fetchData3();
  }, [formatStart, formatEnd]);

  return (
    <>
      <div>
        <div style={{ fontFamily: "Montserrat", display: "flex" }}>
          <div
            style={{
              width: "33.3333%",
              height: "160px",
              border: "1px solid black",
              marginTop: "20px",
              marginLeft: "50px",
            }}
          >
            <div style={nameStyle}>
              <FaCoffee
                style={{
                  marginRight: "10px",
                  fontSize: "65px",
                  marginTop: "20px",
                }}
              />
              <p
                style={{
                  display: "inline-block",
                  marginTop: "20px",
                  borderBottom: "4px double black",
                }}
              >
                PLACY COFFEE
              </p>
            </div>
            <p
              style={{
                fontWeight: "normal",
                fontSize: "20px",
                marginLeft: "110px",
              }}
            >
              {storeName()}
            </p>
          </div>
          <div
            style={{
              marginLeft: "300px",
              marginTop: "20px",
              fontWeight: "bold",
            }}
          >
            <div className="flex">
              <p style={{ marginRight: "16px" }}>Từ ngày: </p>
              <div>
                <input
                  type="date"
                  id="date"
                  name="date"
                  value={selectedStartDate.toISOString().split("T")[0]}
                  onChange={handleStartDateChange}
                  style={{
                    border: "1px solid",
                    borderRadius: "4px",
                    background: "#e3cd8e",
                    color: "#0c0ee3",
                  }}
                />
              </div>
            </div>
            <div className="flex" style={{ marginTop: "10px" }}>
              <p style={{ marginRight: "10px" }}>Đến ngày:</p>
              <div>
                <input
                  type="date"
                  id="date"
                  name="date"
                  value={selectedEndDate.toISOString().split("T")[0]}
                  onChange={handleEndDateChange}
                  style={{
                    border: "1px solid",
                    borderRadius: "4px",
                    background: "#e3cd8e",
                    color: "#0c0ee3",
                  }}
                />
              </div>
            </div>
            <div className="flex" style={{ marginTop: "10px" }}>
              <p style={{ marginRight: "10px" }}>Tổng doanh thu:</p>
              <p style={{ color: "#0c0ee3" }}>{totalRevenue}</p>
            </div>
            <div className="flex" style={{ marginTop: "10px" }}>
              <p style={{ marginRight: "10px" }}>Tổng sản phẩm:</p>
              <p style={{ color: "#0c0ee3" }}>{totalProduct}</p>
            </div>
            <div className="flex" style={{ marginTop: "10px" }}>
              <p style={{ marginRight: "10px" }}>Sản phẩm bán chạy:</p>
              {producFromTable
                .filter((item) => item.product_ID === bestsellerID)
                .map((filteredItem) => (
                  <div
                    style={{ color: "#0c0ee3" }}
                    key={filteredItem.product_ID}
                  >
                    <p>
                      {filteredItem.product_name} - {filteredItem.product_size}{" "}
                      -{filteredItem.total_quantity_sold}{" "}
                    </p>
                  </div>
                ))}
            </div>
          </div>
        </div>
        {/* table */}
        <div>
          <ProRevTable
            startDate={selectedStartDate}
            endDate={selectedEndDate}
            onDataFromChild={handleData}
          />
        </div>
      </div>
    </>
  );
}

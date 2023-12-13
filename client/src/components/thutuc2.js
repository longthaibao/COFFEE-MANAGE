import React, { useState, useEffect } from 'react';
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import { Button } from "@mui/material";
import axios from 'axios';
import APIs from '../util/API';
export default function Thutuc2() {
    const [data, setData] = useState([]);
    const [formData, setFormData] = useState(0);
    const [selectedYear, setSelectedYear] = useState(0);
    const [headers, setHeaders] = useState([]);
    const handleInputChange = (e) => {
        setFormData(e.target.value);
    };

    const handleYearChange = (e) => {
        setSelectedYear(e.target.value);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (formData === "" || parseFloat(formData) < 0) {
          // Show an alert if the field is blank
            window.alert("Doanh thu không được để trống và phải từ 0 trở lên");
            return;
        }
        try {
            const response = await axios.post(APIs.APIadminThutuc2, {
                revenue: formData,
                year: selectedYear
            });

            setData(response.data);

            // Update headers based on the first item in the data array
            if (response.data.length > 0) {
                const newHeaders = Object.keys(response.data[0]);
                setHeaders(newHeaders);
            } else {
                setHeaders([]);
            }
            const tableElement = document.getElementById("resultTable");
            if (tableElement) {
              tableElement.scrollIntoView({ behavior: 'smooth' });
            }
        } catch (error) {
            console.error('Error submitting form:', error);
        }
    };

    const handleClearTable = () => {
        setData([]);
        setHeaders([]);
    };

   
    return (
        <div className="w-full flex justify-center items-center bg-cover">
            <div className="w-full h-222 bg-white rounded-2xl flex items-center flex-col p-4">
                <h1 className="text-gray-700 text-2xl font-bold">Thống kê các chương trình khuyến mãi có Doanh thu (VNĐ) lớn hơn hoặc bằng R theo năm và hiển thị kèm thông tin của Khách hàng đã chi nhiều nhất trong CTKM đó</h1>
                <Box
                  component="form"
                  sx={{
                    "& .MuiTextField-root": { m: 1, width: "25ch" },
                  }}
                  noValidate
                  autoComplete="off"
                  encType="multipart/form-data"
                  onSubmit={(e) => {
                    e.preventDefault(); // Prevent the default form submission
                    handleSubmit(e); // Your custom form submission logic
                    const tableElement = document.getElementById("resultTable");
                    if (tableElement) {
                      tableElement.scrollIntoView({ behavior: 'smooth' });
                    }
                  }}
                >
                  <div>
                      <TextField
                          id="year"
                          name="year"
                          select
                          onChange={handleYearChange}
                          label="Chọn năm"
                          value={selectedYear}
                          SelectProps={{
                              native: true,
                          }}
                          variant="standard"
                          size="large"
                      >
                          {[...Array(new Date().getFullYear() - 2020)].map((_, index) => {
                              const year = 2021 + index;
                              return (
                                  <option key={year} value={year}>
                                      {year}
                                  </option>
                              );
                          })}
                          <option value={0}>Tất cả các năm</option>
                      </TextField>
                  </div>
                  <div className="mb-3">
                      <TextField
                          label="Nhập R (VNĐ)"
                          type="number"
                          id="revenue"
                          name="revenue"
                          required
                          min={0}
                          placeholder="Nhập mức doanh thu"
                          helperText="Hệ thống sẽ lọc ra các CTKM có doanh thu lớn hơn hoặc bằng giá trị bạn chọn"
                          value={formData}
                          onChange={handleInputChange}
                      />
                  </div>
                  <Button
                      style={{
                      backgroundColor: "#1dc1ff",
                      color: "#FFFFFF",
                      fontFamily: "sans-serif",
                      border: "1px solid #1899D6",
                      fontWeight: 700,
                      outline: "none",
                      borderWidth: "0 0 4px",
                      borderRadius: "16px",
                      }}
                      variant="contained"
                      onClick={handleSubmit}
                  >
                      Tìm kiếm
                  </Button>
                </Box>
                <div className="mb-4 text-gray-600 text-sm text-red-500">
                    NOTE:
                    <p>Điều kiện áp dụng là số lớn hơn 1000 là điều kiện áp dụng đối với Khuyến mãi theo hóa đơn (Đơn vị: VNĐ)</p>
                    <p>Điều kiện áp dụng là số nhỏ là điều kiện áp dụng đối với Khuyến mãi theo sản phẩm</p>
                </div>
                {headers.length > 0 && (
                    <div id="resultTable" className="wrapper m-7">
                    <TableContainer component={Paper}>
                      <Table sx={{ minWidth: 650 }} size="small" aria-label="a dense table">
                        <TableHead>
                          <TableRow>
                            {headers.map((header, index) => (
                              <TableCell
                                key={index}
                                align="center"
                                style={{
                                  color: index % 2 === 0 ? "#ffffff" : "#ffffff",
                                  backgroundColor: index % 2 === 0 ? "#324960" : "#4FC3A1",
                                }}
                              >
                                {header}
                              </TableCell>
                            ))}
                          </TableRow>
                        </TableHead>
                        <TableBody>
                          {data.map((item, rowIndex) => (
                            <TableRow key={rowIndex}>
                              {headers.map((header, colIndex) => (
                                <TableCell
                                  key={colIndex}
                                  align="center"
                                  style={{
                                    color: colIndex % 2 === 0 ? "#000000" : "#000000",
                                    backgroundColor: colIndex % 2 === 0 ? "#ffffff" : "#ffffff",
                                  }}
                                >
                                  {item[header]}
                                </TableCell>
                              ))}
                            </TableRow>
                          ))}
                        </TableBody>
                      </Table>
                    </TableContainer>
                  </div>
                )}
            </div>
        </div>
    );
}

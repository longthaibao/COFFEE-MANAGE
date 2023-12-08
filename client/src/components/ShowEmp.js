import * as React from "react";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Table from "@mui/material/Table";
import { red } from "@mui/material/colors";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import { Button } from "@mui/material";
import axios from "axios";
const custom = red[100];
const currencies = [
  {
    value: "Quản lý",
    label: "Quản lý",
  },
  {
    value: "Thu ngân",
    label: "Thu ngân",
  },
  {
    value: "Pha chế",
    label: "Pha chế",
  },
  {
    value: "Bảo vệ",
    label: "Bảo vệ",
  },
  {
    value: "Tạp vụ",
    label: "Tạp vụ",
  },
];
var newjob_type = "";
function ShowEmp() {
  const [job_type, setJobType] = React.useState("Quản lý");
  const [job_typeOnClick, setJob_TypeOnClick] = React.useState("Quản lý");
  const [arrayOfEmp, setArrayOfEmp] = React.useState([]);
  const handleSubmit = () => {
    axios
      .post("http://localhost:3001/api/admin/showInfoEmp/getInfoEmp", {
        job_type,
      })
      .then((respone) => {
        setArrayOfEmp(respone.data);
        setJob_TypeOnClick(job_type);
      })
      .catch((error) => {
        console.log(error);
      });
  };
  return (
    <div className="wrapper m-7">
      <h3
        style={{
          fontSize: "70px",
          fontWeight: "600",
          backgroundImage: "linear-gradient(to left, #553c9a, #b393d3)",
          backgroundClip: "text",
          textShadow:
            "0px 0px 5px #b393d3, 0px 0px 10px #b393d3, 0px 0px 10px #b393d3,0px 0px 20px #b393d3",
        }}
      >
        Employee
      </h3>
      <Box
        className="m-8"
        component="form"
        sx={{
          "& .MuiTextField-root": { m: 1, width: "25ch" },
        }}
        noValidate
        autoComplete="off"
        encType="multipart/form-data"
      >
        <div>
          <TextField
            id="standard-select-currency-native"
            select
            onChange={(e) => setJobType(e.target.value)}
            label="Job position"
            defaultValue="EUR"
            SelectProps={{
              native: true,
            }}
            helperText="Please select job position"
            variant="standard"
            size="large"
          >
            {currencies.map((option) => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </TextField>
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
      <TableContainer component={Paper}>
        <Table sx={{ minWidth: 650 }} size="small" aria-label="a dense table">
          <TableHead>
            <TableRow>
              <TableCell
                style={{ color: "#ffffff", backgroundColor: "#324960" }}
              >
                Loại công việc
              </TableCell>
              <TableCell
                align="center"
                style={{ color: "#ffffff", backgroundColor: "#4FC3A1" }}
              >
                ID
              </TableCell>
              <TableCell
                align="center"
                style={{ color: "#ffffff", backgroundColor: "#324960" }}
              >
                Name
              </TableCell>
              <TableCell
                align="center"
                style={{ color: "#ffffff", backgroundColor: "#4FC3A1" }}
              >
                Gender
              </TableCell>
              <TableCell
                align="center"
                style={{ color: "#ffffff", backgroundColor: "#324960" }}
              >
                Email
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {arrayOfEmp.map((row, index) => (
              <TableRow
                key={index}
                sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
              >
                <TableCell>{job_typeOnClick}</TableCell>
                <TableCell align="center">{row.ID}</TableCell>
                <TableCell align="center">{row.employee_name}</TableCell>
                <TableCell align="center">{row.employee_gender}</TableCell>
                <TableCell align="center">{row.employee_email}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </div>
  );
}

export default ShowEmp;
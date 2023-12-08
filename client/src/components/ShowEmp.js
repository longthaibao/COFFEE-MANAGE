import * as React from "react";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import MenuItem from "@mui/material/MenuItem";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import { Button } from "@mui/material";
import axios from "axios";
const currencies = [
  {
    value: "Manager",
    label: "Manager",
  },
  {
    value: "Cashier",
    label: "Cashier",
  },
  {
    value: "Salesperson",
    label: "Salesperson",
  },
];
var newjob_type = "";
function ShowEmp() {
  const [job_type, setJobType] = React.useState("Manager");
  const [job_typeOnClick, setJob_TypeOnClick] = React.useState("Manager");
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
      <h3>Chọn một vị trí công việc</h3>
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
        <Button color="primary" variant="outlined" onClick={handleSubmit}>
          Tìm kiếm
        </Button>
      </Box>
      <TableContainer component={Paper}>
        <Table sx={{ minWidth: 650 }} size="small" aria-label="a dense table">
          <TableHead>
            <TableRow>
              <TableCell>Loại công việc</TableCell>
              <TableCell align="right">ID</TableCell>
              <TableCell align="right">Name</TableCell>
              <TableCell align="right">Gender</TableCell>
              <TableCell align="right">Email</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {arrayOfEmp.map((row, index) => (
              <TableRow
                key={index}
                sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
              >
                <TableCell>{job_typeOnClick}</TableCell>
                <TableCell align="right">{row.ID}</TableCell>
                <TableCell align="right">{row.employee_name}</TableCell>
                <TableCell align="right">{row.employee_gender}</TableCell>
                <TableCell align="right">{row.employee_email}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </div>
  );
}

export default ShowEmp;

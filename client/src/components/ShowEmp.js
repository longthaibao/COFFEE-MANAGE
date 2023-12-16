import * as React from "react";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TablePagination from "@mui/material/TablePagination";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import { Button } from "@mui/material";
import axios from "axios";
import Tippy from "@tippyjs/react/headless";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faTrash, faPenToSquare } from "@fortawesome/free-solid-svg-icons";
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
function ShowEmp() {
  const [job_type, setJobType] = React.useState("Quản lý");
  const [job_typeInsertEmploy, setjob_typeInsertEmploy] =
    React.useState("Quản lý");
  const [job_typeOnClick, setJob_TypeOnClick] = React.useState("Quản lý");
  const [employee_name, setEmployeeName] = React.useState("");
  const [employee_gender, setEmployeeGender] = React.useState("Nam");
  const [employee_email, setEmployeeEmail] = React.useState("");
  const [arrayOfEmp, setArrayOfEmp] = React.useState([]);
  const [isShowInput, setIsShowInput] = React.useState(false);
  const [editStates, setEditStates] = React.useState({});
  const [rowsPerPage, setRowsPerPage] = React.useState(5);
  const [displayedData, setDisplayedData] = React.useState([]);
  const [page, setPage] = React.useState(0);
  const handleEditButtonClick = (ID) => {
    setEditStates((prev) => ({
      ...prev,
      [ID]: !prev[ID],
    }));
  };

  const handleShowCreateInput = () => {
    setIsShowInput((pre) => !pre);
  };
  const handleChangePage = (event, newPage) => {
    const startIndex = newPage * rowsPerPage;
    const endIndex = startIndex + rowsPerPage;
    setDisplayedData(arrayOfEmp.slice(startIndex, endIndex));
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    const newRowsPerPage = parseInt(event.target.value, 10);
    const newPage = Math.floor((page * rowsPerPage) / newRowsPerPage);
    const startIndex = newPage * newRowsPerPage;
    const endIndex = startIndex + newRowsPerPage;
    setDisplayedData(arrayOfEmp.slice(startIndex, endIndex));
    setRowsPerPage(newRowsPerPage);
    setPage(newPage);
  };
  const fetchData = async () => {
    try {
      const respone = await axios.post(
        "http://localhost:3001/api/admin/showInfoEmp/getInfoEmp",
        { job_type }
      );
      setArrayOfEmp(respone.data);
      setJob_TypeOnClick(job_type);
      setDisplayedData(respone.data.slice(0, rowsPerPage));
      console.log(displayedData);
    } catch (error) {
      console.log(error);
    }
  };
  const handleSubmitCreateEmploy = async () => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const isEmail = emailRegex.test(employee_email);
    if (isEmail === false) {
      const notify = () => toast.error("Vui lòng nhập đúng email");
      notify();
      setEmployeeName("");
      setEmployeeEmail("");
      return;
    }
    await axios
      .post("http://localhost:3001/api/admin/showInfoEmp/create/employee", {
        employee_name: employee_name,
        employee_gender: employee_gender,
        employee_email: employee_email,
        job_type: job_typeInsertEmploy,
      })
      .then((res) => {
        setIsShowInput(false);
        fetchData();
        const notify = () => toast.success("Tạo nhân viên thành công");
        notify();
        setEmployeeName("");
        setEmployeeEmail("");
      })
      .catch((err) => console.log(err));
  };
  const handleUpdateEmployee = async (
    ID,
    employee_name,
    employee_gender,
    employee_email
  ) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const isEmail = emailRegex.test(employee_email);
    if (isEmail === false) {
      const notify = () => toast.error("Vui lòng nhập đúng email");
      notify();
      setEmployeeName("");
      setEmployeeEmail("");
      return;
    }
    await axios
      .post("http://localhost:3001/api/admin/showInfoEmp/update/employee", {
        ID,
        employee_name,
        employee_gender,
        employee_email,
      })
      .then((res) => {
        console.log(res);
        setEditStates((prev) => ({
          ...prev,
          [ID]: !prev[ID],
        }));
        fetchData();
        const notify = () => toast.success("Cập nhật thành công");
        notify();
        setEmployeeName("");
        setEmployeeEmail("");
      })
      .catch((err) => console.log(err));
  };
  const handleDelete = async (ID) => {
    await axios
      .post("http://localhost:3001/api/admin/showInfoEmp/delete/employee", {
        ID,
      })
      .then((res) => {
        fetchData();
        const notify = () => toast.success("Xoá nhân viên thành công");
        notify();
      })
      .catch((err) => console.log(err));
  };
  const handleEdit = (ID) => {
    return (
      <div style={{ display: "flex" }}>
        <Box
          component="form"
          sx={{
            "& .MuiTextField-root": { m: 1, width: "25ch" },
          }}
          noValidate
          autoComplete="off"
        >
          <div
            style={{
              display: "flex",
              flexWrap: "wrap",
              maxHeight: "600px",
              maxWidth: "540px",
              backgroundColor: "white",
              zIndex: 999,
              padding: "50px",
              borderRadius: "2%",
              boxShadow:
                "rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px",
            }}
          >
            <TextField
              onChange={(e) => setEmployeeName(e.target.value)}
              required
              id="outlined-required"
              label="Tên nhân viên"
              placeholder="Tên nhân viên"
              value={employee_name}
            />
            <TextField
              id="standard-select-currency-native"
              select
              onChange={(e) => setEmployeeGender(e.target.value)}
              label="Giới tính"
              defaultValue="EUR"
              SelectProps={{
                native: true,
              }}
              helperText="Vui lòng chọn giới tính"
              variant="standard"
              size="large"
              style={{ position: "relative" }}
            >
              <option key={1} value="Nam">
                {"Nam"}
              </option>
              <option key={2} value="Nữ">
                {"Nữ"}
              </option>
            </TextField>
            <TextField
              onChange={(e) => setEmployeeEmail(e.target.value)}
              required
              id="outlined-required"
              label="Email"
              placeholder="Email"
              value={employee_email}
            />
            <TextField
              disabled
              required
              id="outlined-required"
              label="ID"
              value={ID}
            />
            <Button
              style={{
                minWidth: "100px",
                backgroundColor: "#1dc1ff",
                color: "#FFFFFF",
                fontFamily: "sans-serif",
                border: "1px solid #1899D6",
                fontWeight: 700,
                outline: "none",
                margin: "20px",
                borderWidth: "0 0 4px",
                borderRadius: "16px",
              }}
              variant="contained"
              onClick={() =>
                handleUpdateEmployee(
                  ID,
                  employee_name,
                  employee_gender,
                  employee_email
                )
              }
            >
              Cập nhật
            </Button>
          </div>
        </Box>
      </div>
    );
  };
  const renderInput = () => {
    return (
      <div style={{ display: "flex" }}>
        <Box
          component="form"
          sx={{
            "& .MuiTextField-root": { m: 1, width: "25ch" },
          }}
          noValidate
          autoComplete="off"
        >
          <div
            style={{
              display: "flex",
              flexWrap: "wrap",
              maxHeight: "1000px",
              maxWidth: "700px",
              backgroundColor: "white",
              zIndex: 999,
              padding: "50px",
              borderRadius: "2%",
              boxShadow:
                "rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px",
            }}
          >
            <TextField
              onChange={(e) => setEmployeeName(e.target.value)}
              required
              id="outlined-required"
              label="Tên nhân viên"
              placeholder="Tên nhân viên"
              value={employee_name}
            />
            <TextField
              id="standard-select-currency-native"
              select
              onChange={(e) => setEmployeeGender(e.target.value)}
              label="Giới tính"
              defaultValue="EUR"
              SelectProps={{
                native: true,
              }}
              helperText="Vui lòng chọn giới tính"
              variant="standard"
              size="large"
              style={{ position: "relative" }}
            >
              <option key={1} value="Nam">
                {"Nam"}
              </option>
              <option key={2} value="Nữ">
                {"Nữ"}
              </option>
            </TextField>
            <TextField
              onChange={(e) => setEmployeeEmail(e.target.value)}
              required
              id="outlined-required"
              label="Email"
              placeholder="Email"
              value={employee_email}
            />
            <TextField
              id="standard-select-currency-native"
              select
              onChange={(e) => setjob_typeInsertEmploy(e.target.value)}
              label="Vị trí công việc"
              defaultValue="EUR"
              SelectProps={{
                native: true,
              }}
              helperText="Vui lòng chọn vị trí công việc"
              variant="standard"
              size="large"
              style={{ position: "relative" }}
            >
              {currencies.map((option) => (
                <option key={option.value} value={option.value}>
                  {option.label}
                </option>
              ))}
            </TextField>
            <Button
              style={{
                minWidth: "100px",
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
              onClick={handleSubmitCreateEmploy}
            >
              Tạo
            </Button>
          </div>
        </Box>
      </div>
    );
  };
  const handleSubmit = async () => {
    await axios
      .post("http://localhost:3001/api/admin/showInfoEmp/getInfoEmp", {
        job_type,
      })
      .then((respone) => {
        setArrayOfEmp(respone.data);
        setDisplayedData(respone.data);
        setJob_TypeOnClick(job_type);
        setPage(0);
      })
      .catch((error) => {
        console.log(error);
      });
  };
  return (
    <div className="wrapper m-7">
      <ToastContainer autoClose={1000} />
      <div
        style={{
          display: "flex",
          alignItems: "center",
          justifyContent: "space-around",
        }}
      >
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
              label="Vị trí công việc"
              defaultValue="EUR"
              SelectProps={{
                native: true,
              }}
              helperText="Vui lòng chọn vị trí công việc"
              variant="standard"
              size="large"
              style={{ position: "relative" }}
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
        <div
          style={{
            display: "flex",
            justifyContent: "center",
            alignItems: "flex-start",
          }}
        >
          <Tippy
            onClickOutside={() => setIsShowInput((pre) => !pre)}
            duration={[1050, 1050]}
            render={renderInput}
            interactive
            visible={isShowInput}
            placement="bottom-end"
            offset={[-2, 0]}
          >
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
                margin: "20px",
                right: "0",
              }}
              variant="contained"
              onClick={handleShowCreateInput}
            >
              Thêm nhân viên
            </Button>
          </Tippy>
        </div>
      </div>
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
                Tên
              </TableCell>
              <TableCell
                align="center"
                style={{ color: "#ffffff", backgroundColor: "#4FC3A1" }}
              >
                Giới tính
              </TableCell>
              <TableCell
                align="center"
                style={{ color: "#ffffff", backgroundColor: "#324960" }}
              >
                Email
              </TableCell>
              <TableCell
                align="center"
                style={{
                  color: "#ffffff",
                  backgroundColor: "#4FC3A1",
                }}
              >
                Chỉnh sửa
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {displayedData.map((row, index) => (
              <TableRow
                key={index}
                sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
              >
                <TableCell>{job_typeOnClick}</TableCell>
                <TableCell align="center">{row.ID}</TableCell>
                <TableCell align="center">{row.employee_name}</TableCell>
                <TableCell align="center">{row.employee_gender}</TableCell>
                <TableCell align="center">{row.employee_email}</TableCell>
                <TableCell align="center">
                  <button
                    onClick={() => handleDelete(row.ID)}
                    style={{ margin: "10px" }}
                  >
                    <FontAwesomeIcon icon={faTrash} />
                  </button>
                  <Tippy
                    onClickOutside={() => setEditStates(row.ID)}
                    interactive
                    render={() => handleEdit(row.ID)}
                    visible={editStates[row.ID] || false}
                    placement="bottom-end"
                  >
                    <button
                      onClick={() => handleEditButtonClick(row.ID)}
                      style={{ margin: "10px" }}
                    >
                      <FontAwesomeIcon icon={faPenToSquare} />
                    </button>
                  </Tippy>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
        <TablePagination
          rowsPerPageOptions={[5, 10, 25]}
          component="div"
          count={arrayOfEmp.length}
          rowsPerPage={rowsPerPage}
          page={page}
          onPageChange={handleChangePage}
          onRowsPerPageChange={handleChangeRowsPerPage}
        />
      </TableContainer>
    </div>
  );
}
export default ShowEmp;

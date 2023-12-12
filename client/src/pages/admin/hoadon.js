
import React, { useMemo, useState, useEffect } from 'react';
import './hoadon.css'
import {
	MRT_EditActionButtons,
	MaterialReactTable,
	useMaterialReactTable,
} from 'material-react-table';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper } from '@mui/material';
import Container from 'react-bootstrap/Container';
import {
	Box,
	Button,
	DialogActions,
	DialogContent,
	DialogTitle,
	IconButton,
	Tooltip,
	Dialog

} from '@mui/material';
import InfoIcon from '@mui/icons-material/Info';

import apiEndpoints from './../../components/Order.js'; // Assuming you store your hooks in an 'api.js' file

import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

const Hoadon = () => {
	const [validationErrors, setValidationErrors] = useState({});
	const [customer, setCustomer] = useState([]);
	const [editingPhone, setEditingPhone] = useState(null);

	const [selectedInvoice, setSelectedInvoice] = useState(null);
	const [billDetails, setBillDetails] = useState([]);

	const columns = useMemo(
		() => [
			{
				accessorKey: 'BID',
				header: 'Mã hóa đơn',
				muiEditTextFieldProps: {
					type: 'integer',
					required: true,
					error: !!validationErrors?.BID,
					helperText: validationErrors?.BID,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							BID: undefined,
						}),


				},
			},

			{
				accessorKey: 'state',
				header: 'Trạng thái',
				muiEditTextFieldProps: {
					type: 'integer',
					required: true,
					error: !!validationErrors?.state,
					helperText: validationErrors?.state,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							state: undefined,
						}),


				},
			},
			{
				accessorKey: 'bill_store',
				header: 'Mã cửa hàng',
				muiEditTextFieldProps: {
					type: 'number',
					required: true,
					error: !!validationErrors?.bill_date,
					helperText: validationErrors?.bill_date,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_date: undefined,
						}),
				},
			},

			{
				accessorKey: 'bill_date',
				header: 'Xuất ngày',
				muiEditTextFieldProps: {
					type: 'Date',
					required: true,
					error: !!validationErrors?.bill_date,
					helperText: validationErrors?.bill_date,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_date: undefined,
						}),
				},
			},
			{
				accessorKey: 'name',
				header: 'Tên khách hàng',
				muiEditTextFieldProps: {
					type: 'text',
					required: true,
					error: !!validationErrors?.bill_date,
					helperText: validationErrors?.bill_date,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_date: undefined,
						}),
				},
			},
			{
				accessorKey: 'phone',
				header: 'SĐT Khách hàng',
				muiEditTextFieldProps: {
					type: 'number',
					required: true,
					error: !!validationErrors?.phone,
					helperText: validationErrors?.bill_phone_cus,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_phone_cus: undefined,
						}),
				},
			},
			{
				accessorKey: 'bill_AID',
				header: 'Mã AID',
				muiEditTextFieldProps: {
					type: 'number',
					required: true,
					error: !!validationErrors?.bill_date,
					helperText: validationErrors?.bill_date,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_date: undefined,
						}),
				},
			},
			{
				accessorKey: 'coupoun_KID',
				header: 'Mã KID',
				muiEditTextFieldProps: {
					type: 'number',
					required: true,
					error: !!validationErrors?.bill_date,
					helperText: validationErrors?.bill_date,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_date: undefined,
						}),
				},
			},
			{
				accessorKey: 'discount_value',
				header: 'Giảm giá',
				muiEditTextFieldProps: {
					type: 'number',
					required: true,
					error: !!validationErrors?.bill_date,
					helperText: validationErrors?.bill_date,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_date: undefined,
						}),
				},
			},
			{
				accessorKey: 'bill_sum',
				header: 'Tổng',
				muiEditTextFieldProps: {
					type: 'number',
					required: true,
					error: !!validationErrors?.bill_sum,
					helperText: validationErrors?.bill_sum,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_sum: undefined,
						}),
				},
			},

		],
		[validationErrors]
	);

	useEffect(() => {
		const fetchData = async () => {
			try {
				const data = await apiEndpoints.getOrder();
				const updatedData = data.map(item => {
					return {
						...item,
						bill_date: item.bill_date.split('T')[0],
					};
				});

				const activeCustomers = updatedData.filter(customer => customer.deleted !== 1);
				setCustomer(activeCustomers);
				// setCustomer(data)
			} catch (error) {
				console.error('Error fetching data:', error);
			}
		};

		fetchData();
	}, []);

	const handleCreateUser = async ({ values, table }) => {
		if (values.phone.length !== 10) {
			setValidationErrors({
				...validationErrors,
				phone: 'Nhâp đúng số điện thoại!',
			});
			return;
		}
		const phoneExists = customer.some((existingCustomer) => existingCustomer.phone === values.phone);
		if (phoneExists) {
			setValidationErrors({
				...validationErrors,
				phone: 'Số điện thoại đã tồn tại.',
			});
			return;
		}
		setValidationErrors({});
		try {
			await apiEndpoints.insertCustomer(values);
			table.setCreatingRow(null);
			const updatedData = await apiEndpoints.getOrder();

			const activeCustomers = updatedData.filter(customer => customer.deleted !== 1);
			setCustomer(activeCustomers);
			window.alert('Đăng kí khách hàng thành công');
		} catch (error) {
			console.error('Error creating customer:', error);
			if (error.response && error.response.data) {
				setValidationErrors(error.response.data);
			}
		}
	};

	const handleSaveUser = async ({ values, table }) => {
		// if (values.phone.length !== 10) {
		// 	setValidationErrors({
		// 		...validationErrors,
		// 		phone: 'Nhâp đúng số điện thoại!',
		// 	});
		// 	return;
		// }
		if (isNaN(values.phone) || values.phone.length !== 10) {
			setValidationErrors({
				...validationErrors,
				phone: 'Số điện thoại phải là số và có đúng 10 chữ số!',
			});
			return;
		}
		const phoneExists = customer.some((existingCustomer) => existingCustomer.phone === values.phone);
		if (phoneExists) {
			setValidationErrors({
				...validationErrors,
				phone: 'Số điện thoại đã tồn tại.',
			});
			return;
		}


		setValidationErrors({});
		try {

			const data = {
				phone: editingPhone,
				newPhone: values.phone,
			}
			// console.log("Data:", data);
			await apiEndpoints.updateCustomer(data);
			table.setCreatingRow(null);
			const updatedData = await apiEndpoints.getOrder();
			setEditingPhone(null);
			const activeCustomers = updatedData.filter(customer => customer.deleted !== 1);
			setCustomer(activeCustomers);
			window.alert('Cập nhật số điện thoại khách hàng thành công');
			table.setEditingRow(null);
		} catch (error) {
			console.error('Error creating customer:', error);
			if (error.response && error.response.data) {
				setValidationErrors(error.response.data);
			}
		}
	};


	const handleInfoIconClick = async (row) => {
		try {
			console.log("BID", row.id);
			const data = await apiEndpoints.getDetailBill(row.id);
			setBillDetails(data);
			console.log("Details:", data)
		} catch (error) {
			console.error('Error fetching data:', error);
		}

		setSelectedInvoice(row.original);
	};


	const handleCloseModal = () => {
		setSelectedInvoice(null);
	};


	const table = useMaterialReactTable({
		onCreatingRowCancel: () => setValidationErrors({}),
		onCreatingRowSave: handleCreateUser,
		onEditingRowCancel: () => {
			// Clear the editing phone number when canceling the edit
			setEditingPhone(null);
			setValidationErrors({});
		},
		onEditingRowSave: handleSaveUser,
		columns,
		data: customer,
		createDisplayMode: 'modal',
		editDisplayMode: 'modal',
		enableEditing: true,
		getRowId: (row) => row.BID,
		initialState: { columnVisibility: { state: false, bill_store: false, bill_AID: false, coupoun_KID: false, discount_value: false } },

		muiTableContainerProps: {
			sx: {
				overflowX: 'auto',
				width: '100%',
			},
		},


		renderRowActions: ({ row, table }) => (
			<Box sx={{ display: 'flex', gap: '1rem' }}>
				<Tooltip title="Details">
					<IconButton onClick={() => handleInfoIconClick(row)}>
						<InfoIcon />
					</IconButton>
				</Tooltip>


			</Box>
		),
		renderTopToolbarCustomActions: ({ table }) => (
			<Button
				variant="contained"
				onClick={() => {
					table.setCreatingRow(true);
				}}
				sx={{ marginBottom: '16px' }}
			>
				Thêm hóa đơn
			</Button>

		),
		renderCreateRowDialogContent: ({ table, row, internalEditComponents }) => (
			<>
				<DialogTitle variant="h5">Tạo hóa đơn</DialogTitle>
				<DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
					{internalEditComponents}
				</DialogContent>
				<DialogActions>
					<MRT_EditActionButtons variant="text" table={table} row={row}
					/>
				</DialogActions>
			</>
		),
	});

	return (
		<Container>
			<Row>
				<h1 style={{ fontFamily: 'Montserrat', fontWeight: 'bold', fontSize: '30px', textAlign: 'center' }}>Quản lý thông tin hóa đơn</h1>
			</Row>
			<Row style={{ marginTop: '20px' }}>
				<div style={{
					overflowX: 'auto',
					width: '100%',
					padding: '16px',
					minWidth: '320px', // Set a minimum width if needed
				}} >
					<MaterialReactTable style={{ minWidth: '1000px' }} table={table} />
				</div>
			</Row>
			<Dialog open={!!selectedInvoice} onClose={handleCloseModal}>
				<DialogTitle variant="h4" style={{ textAlign: 'center', marginBottom: '20px' }} >Thông tin chi tiết của hóa đơn</DialogTitle>
				<DialogContent>
					{/* Render detailed information about the selected invoice */}
					<>
						<div style={{ display: 'flex', flexDirection: 'column', marginBottom: '10px', fontWeight: 'bold' }}>
							<div style={{ display: 'flex', marginBottom: '5px' }}>
								<p style={{ marginRight: '5px' }}>Tên hhách hàng:</p>
								<p> {selectedInvoice?.name}</p>
							</div>
							<div style={{ display: 'flex', marginBottom: '5px' }}>
								<p style={{ marginRight: '95px' }}>SĐT:</p>
								<p> {selectedInvoice?.phone}</p>
							</div>
							<div style={{ display: 'flex' }}>
								<p style={{ marginRight: '50px' }}>Xuất ngày:</p>
								<p> {selectedInvoice?.bill_date}</p>
							</div>


						</div>
						<div>-----------------------------------------------------------------------</div>
						{selectedInvoice && (
							<Row style={{ width: "100%", marginTop: "30px" }}>
								<TableContainer component={Paper} style={{ border: "3px solid grey" }}>
									<Table>
										<TableHead>
											<TableRow style={{ backgroundColor: '#EEEEEE', textAlign: 'center', padding: '2px' }}>
												<TableCell align="center">Tên sản phẩm</TableCell>
												<TableCell align="center">Kích cỡ</TableCell>
												<TableCell align="center">Số lượng</TableCell>
												<TableCell align="center">Giá</TableCell>
												<TableCell align="center">Tổng</TableCell>

											</TableRow>
										</TableHead>
										<TableBody>
											{billDetails.map((billDetails) => (
												<TableRow key={billDetails.product_name}>
													<TableCell style={{ padding: '5px' }} align="center">{billDetails.product_name}</TableCell>

													<TableCell style={{ padding: '5px' }} align="center">{billDetails.product_size}</TableCell>
													<TableCell style={{ padding: '5px' }} align="center">{billDetails.quantity}</TableCell>
													<TableCell style={{ padding: '5px' }} align="center">{billDetails.price}</TableCell>
													<TableCell style={{ padding: '5px' }} align="center">{billDetails.total}</TableCell>

												</TableRow>
											))}
										</TableBody>
									</Table>
								</TableContainer>
							</Row>)}
						<div style={{ marginTop: '30px' }}>-----------------------------------------------------------------------</div>

						<div style={{ marginTop: '10px', fontStyle: 'italic', display: 'flex', justifyContent: 'right' }} >
							<p style={{ marginRight: '30px' }} >Mã giảm giá: </p>
							<p > {selectedInvoice?.coupoun_KID}</p>
						</div>
						<div style={{ marginTop: '10px', fontStyle: 'italic', display: 'flex', justifyContent: 'right' }} >
							<p style={{ marginRight: '20px' }}>Giảm giá: </p>
							<p > {selectedInvoice?.discount_value}</p>
						</div>
						<div style={{ marginTop: '10px', fontStyle: 'italic', display: 'flex', justifyContent: 'right' }} >
							<p style={{ marginRight: '20px' }}>Tổng: </p>
							<p > {selectedInvoice?.bill_sum}</p>
						</div>


					</>

				</DialogContent>
				<DialogActions>
				</DialogActions>
			</Dialog>
		</Container >

	);
};

export default Hoadon;


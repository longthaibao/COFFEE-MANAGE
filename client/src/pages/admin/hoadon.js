
import React, { useMemo, useState, useEffect } from 'react';
import {
	MRT_EditActionButtons,
	MaterialReactTable,
	useMaterialReactTable,
} from 'material-react-table';

import Container from 'react-bootstrap/Container';
import {
	Box,
	Button,
	DialogActions,
	DialogContent,
	DialogTitle,
	IconButton,
	Tooltip,

} from '@mui/material';
import InfoIcon from '@mui/icons-material/Info';

import apiEndpoints from './../../components/Order.js'; // Assuming you store your hooks in an 'api.js' file

import Row from 'react-bootstrap/Row';

const Hoadon = () => {
	const [validationErrors, setValidationErrors] = useState({});
	const [customer, setCustomer] = useState([]);
	// const [isEditing, setIsEditing] = useState(false);
	const [editingPhone, setEditingPhone] = useState(null);

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
            {
				accessorKey: 'bill_phone_cus',
				header: 'Khách hàng',
				muiEditTextFieldProps: {
					type: 'number',
					required: true,
					error: !!validationErrors?.bill_phone_cus,
					helperText: validationErrors?.bill_phone_cus,
					onFocus: () =>
						setValidationErrors({
							...validationErrors,
							bill_phone_cus: undefined,
						}),
				},
			}
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


	const handleEditClick = (row) => {
		// Store the editing phone number when starting the edit
		setEditingPhone(row.original.phone);
        console.log("ahihi");
		// Trigger the editing of the row using the table's setEditingRow
		table.setEditingRow(row);
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
		getRowId: (row) => row.phone,
		muiTableContainerProps: {
			sx: {
				overflowX: 'auto',
				width: '100%',
			},
		},


		renderRowActions: ({ row, table }) => (
			<Box sx={{ display: 'flex', gap: '1rem' }}>
				<Tooltip title="Edit">
					<IconButton onClick={() => handleEditClick(row)}>
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
				<DialogTitle variant="h5">Thêm khách hàng</DialogTitle>
				<DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
					{internalEditComponents.slice(0, 2)}
				</DialogContent>
				<DialogActions>
					<MRT_EditActionButtons variant="text" table={table} row={row}
					/>
				</DialogActions>
			</>
		),
		// renderEditRowDialogContent: ({ table, row, internalEditComponents }) => (
		// 	<>
		// 		<DialogTitle variant="h5">Edit User</DialogTitle>
		// 		<DialogContent sx={{ display: 'flex', flexDirection: 'column', marginTop: '10px', gap: '1rem' }}>
		// 			{internalEditComponents.slice(0, 1)}
		// 		</DialogContent>
		// 		<DialogActions>
		// 			<MRT_EditActionButtons variant="text" table={table} row={row} />
		// 		</DialogActions>
		// 	</>
		// ),

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


		</Container>

	);
};

export default Hoadon;


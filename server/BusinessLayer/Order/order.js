const { getOrder, insertOrder, updateOrder, deleteOrder, viewOrder } = require('../../PersistenceLayer/Order');
const { getCustomer, insertCustomer, updateCustomer, deleteCustomer } = require('../../PersistenceLayer/Customer');
const GetOrder = async (req, res) => {
    let data = await getOrder(req.query.id);
    console.log(data);
    return res.status(200).json(data[0]);
}
const ViewOrder = async (req, res) => {
    let data = await viewOrder(req.query.id);
    console.log(data);
    return res.status(200).json(data[0]);
}
const InsertCustomer = async (req, res) => {
    try {
        let phone = req.body.phone;
        let name = req.body.name;
        let score = req.body.score;

        let data = await insertCustomer(phone, name, score);
        // return res.status(200).json(data[0]);


        if (data) {
            return res.status(200).json({ success: true, message: 'Customer inserted successfully' });
        } else {
            return res.status(500).json({ success: false, message: 'Failed to insert customer' });
        }
    } catch (error) {
        console.error('Error in InsertCustomer route:', error);
        console.log(error.code);
        if (error.code === 'ER_DUP_ENTRY') {
            return res.status(500).json({ success: false, message: 'Số điện thoại đã tồn tại!' });
        } else {
            return res.status(500).json({ success: false, message: 'Internal Server Error' });
        }
    }

}
const UpdateCustomer = async (req, res) => {
    try {

        let phone = req.body.phone;
        let newPhone = req.body.newPhone;

        let data = await updateCustomer(phone, newPhone);
        if (data) {
            return res.status(200).json({ success: true, message: 'Customer updated successfully', data: data[0] });
        } else {
            return res.status(404).json({ success: false, message: 'Customer not found or update failed' });
        }
    } catch (error) {
        console.error('Error in UpdateCustomer route:', error);
        return res.status(500).json({ success: false, message: 'Internal Server Error' });
    }

}
const DeleteOrder = async (req, res) => {
    try {
        console.log('Delete Order:', req.body.BID)

        let BID = req.body.BID;
        let data = await deleteOrder(BID);
        if (data) {
            return res.status(200).json({ success: true, message: 'Deleted successfully', data: data[0] });
        } else {
            return res.status(404).json({ success: false, message: 'Customer not found or deletion failed' });
        }
    } catch (error) {
        console.error('Error in DeleteCustomer route:', error);
        return res.status(500).json({ success: false, message: 'Internal Server Error' });
    }

}

module.exports = { GetOrder, InsertCustomer, UpdateCustomer, DeleteOrder, ViewOrder}
const connection = require('./DataBase');

const getOrder = async () => {
    try {
        const query = `CALL GetCustomerData();`;
        //console.log("Cuuuu",query);
        const [result, fields] = await connection.query(query)
        return result;
    } catch (error) {
        // Xử lý lỗi, đăng nhập nó, hoặc ném một lỗi tùy chỉnh
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};
const viewOrder = async () => {
    try {
        const query = `CALL GetCustomerData();`;
        //console.log("Cuuuu",query);
        const [result, fields] = await connection.query(query)
        return result;
    } catch (error) {
        // Xử lý lỗi, đăng nhập nó, hoặc ném một lỗi tùy chỉnh
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};

const getDetailBill = async (BID) => {
    try {

        const query = `CALL display_detail_bill(?);`;
        console.log("Cuuuu", query);
        const [result, fields] = await connection.query(query, BID)
        return result;
    } catch (error) {
        // Xử lý lỗi, đăng nhập nó, hoặc ném một lỗi tùy chỉnh
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};

const insertCustomer = async (phone, name) => {
    try {
        const deleted = false;
        const score = 0;
        const query = `CALL INSERTCUSTOMER(?,?,?,?);`
        const [result, fields] = await connection.query(query, [phone, name, score, deleted]);
        return result;
    } catch (error) {
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};
const updateCustomer = async (phone, newPhone) => {
    try {
        const query = `CALL UPDATECUSTOMER(?,?);`
        const [result, fields] = await connection.query(query, [phone, newPhone]);
        return result;
    } catch (error) {
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};

const deleteOrder = async (BID,) => {
    try {
        const query = `CALL DELETECUSTOMER(?);`
        const [result, fields] = await connection.query(query, BID);
        return result;
    } catch (error) {
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};


module.exports = { getOrder, insertCustomer, updateCustomer, deleteOrder, viewOrder, getDetailBill };
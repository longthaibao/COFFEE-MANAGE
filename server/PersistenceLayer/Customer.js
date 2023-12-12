const connection = require('./DataBase');

const getCustomer = async () => {
    try {
        const query = `CALL VIEWALLCUSTOMER();`;
        const [result, fields] = await connection.query(query)
        return result;
    } catch (error) {
        // Xử lý lỗi, đăng nhập nó, hoặc ném một lỗi tùy chỉnh
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};

const insertCustomer = async (phone, name) => {
    try {
        const query = `CALL INSERTCUSTOMER(?,?);`
        const [result, fields] = await connection.query(query, [phone, name]);
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

const deleteCustomer = async (phone,) => {
    try {
        const query = `CALL DELETECUSTOMER(?);`
        const [result, fields] = await connection.query(query, phone);
        return result;
    } catch (error) {
        console.error('Lỗi khi thực hiện truy vấn:', error);
        throw error;
    }
};


module.exports = { getCustomer, insertCustomer, updateCustomer, deleteCustomer };
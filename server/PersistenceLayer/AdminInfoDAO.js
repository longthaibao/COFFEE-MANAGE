const connection = require('./DataBase');

const getAdminInfo = async(id) => {
    const query = `CALL GetAdminInfo(?);`;
    const [result, fields] = await connection.query(query,[id])
    return result[0];
}

module.exports = {getAdminInfo};

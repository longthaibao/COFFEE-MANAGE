const connection = require('./DataBase');

const login = async (id,pass) =>
{
    let query = `CALL Login(?,?);`
    try {
        const [result, fields] = await connection.query(query,[id,pass])
        return result[0]
    }
    catch (e) {
        throw new Error(e)
    }
}

module.exports = {login};

const connection = require('./DataBase');

const thutuc2 = async(revenue,year) => {
    const query = `CALL getCoupounHavingRevenueGreaterThanInputInThisYear(?,?);`;
    const [result, fields] = await connection.query(query,[revenue,year])
    return result[0];
}

module.exports = {thutuc2};

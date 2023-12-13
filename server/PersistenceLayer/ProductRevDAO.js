const connection = require('./DataBase');

const productRev = async (store, start, end) =>
{
    let query = `CALL GetProduct(?, ?, ?);`
    try {
        const [result, fields] = await connection.query(query,[store, start, end])
        return result[0]
    }
    catch (e) {
        throw new Error(e)
    }
}

const totalRev = async (store, start, end) =>
{
    let query = `SELECT CalculateTotalRevenueAtStore(?, ?, ?) AS totalrev;`
    try {
        const [result, fields] = await connection.query(query,[store, start, end])
        return result
    }
    catch (e) {
        throw new Error(e)
    }
}

const totalPro = async (store, start, end) =>
{
    let query = `SELECT CalculateSumProductSales(?, ?, ?) AS totalpro;`
    try {
        const [result, fields] = await connection.query(query,[store, start, end])
        return result
    }
    catch (e) {
        throw new Error(e)
    }
}

const bestSel = async (store, start, end) =>
{
    let query = `SELECT GetBestSellingProduct(?, ?, ?) AS bestselID;`
    try {
        const [result, fields] = await connection.query(query,[store, start, end])
        return result
    }
    catch (e) {
        throw new Error(e)
    }
}

module.exports = {productRev, totalPro, totalRev, bestSel};
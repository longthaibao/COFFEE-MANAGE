const mysql = require('mysql2/promise');
const port = process.env.DB_PORT || 3306
const hostname = process.env.DB_HOST || 'localhost'
const username = process.env.DB_USER || 'root'
const password = process.env.DB_PASS || ''
const database = process.env.DB_NAME || 'SSPS'

const connection =  mysql.createPool({
  host     : hostname,
  user     : username,
  password : password,
  database: database,
  port: port,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  timezone: '+07:00', // Use the correct timezone offset for Vietnam
});


if(connection){
    console.log("Connect database succesfull")
}
else {
  console.log("Connect database failed")
  throw new Error("DB_ERROR")
}

module.exports = connection;
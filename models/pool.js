const mysql = require('mysql2/promise');
const dotenv = require('dotenv');
dotenv.config();

const pool = mysql.createPool({
  host: process.env.DB_USER_URL,
  port: process.env.DB_USER_PORT,
  user: process.env.DB_USER_USER,
  password: process.env.DB_USER_PASSWORD,
  database: process.env.DB_USER_DATABASE,
  connectionLimit: 10,
});
if (pool) console.log(`database connected...!`);


module.exports = pool;

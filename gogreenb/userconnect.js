const mysql = require('mysql');
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'ho'
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to the database!');
});

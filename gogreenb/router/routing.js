let e = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');

let routerr = e.Router();
routerr.use(bodyParser.json());
//let Lawfirm = require('../models/client_model')
//let data = require('../Data.json');
const mysql = require('mysql');
let un;
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'ho'
});
// Replace 'your_api_key' with your actual API key
const api_key = '579b464db66ec23bdd000001008f801bb46b446d4d5288ec59676582';
const api_url = `https://api.data.gov.in/resource/3b01bcb8-0b14-4abf-b6f2-c1bfd384ba69?api-key=${api_key}&format=json&offset=10&limit=1000`;

routerr.get('/',(req,res)=>{
    console.log('database connected');
  
})

    // routerr.get('/signup', async (req, res) => {
    //     //
    //     const { name, pno, aadhar_number, email, pass, address, city, state, pin_code } = req.body;
    //     const emailCheckQuery = 'SELECT email FROM users WHERE email = ?';
    //     await connection.query(emailCheckQuery, [email],(error, results,fields) => {
    //         res.json(results);
    //         if (results == []) {
    //             return res.status(409).send('Email already exists.');
    //           } else {
    //             const insertQuery = `
    //               INSERT INTO users (name, pno, aadhar_number, email, pass, address, city, state, pin_code) 
    //               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
    //             `;
    //             connection.query(insertQuery, [name, pno, aadhar_number, email, pass, address, city, state, pin_code], (insertError, insertResults) => {
    //               if (insertError) {
    //                 // Handle error
    //                 return res.status(500).send('Error inserting data');
    //               }
    //               // Send a success response
    //               res.status(200).send('User added successfully');
    //             });
    //           }
            
    //       });
    //         }            
    //         );
     
      
      
   
    
    routerr.post('/signin',async(req,res)=>{
        const { email, pass } = req.body;
        const insertQuery = `SELECT user_id FROM users WHERE (email = ?) AND (pass = ?)`;
     await   connection.query(insertQuery, [email, pass], (error, results,fields) => {
           //return res.json(results);
            if (results != 0 ) {
                return  res.status(200).send('Login Successful');
            }
            res.status(500).send('Check you id and password');
         
        });
    })
      

    routerr.get('/signup', async (req, res) => {
        const { name, pno, aadhar_number, email, pass, address, city, state } = req.body;
        const insertQuery = `INSERT INTO users(name, pno, aadhar_number, email, pass, address, city, state) VALUES (?,?, ?, ?, ?, ?, ?, ?);`;
        connection.query(insertQuery, [name, pno, aadhar_number, email, pass, address, city, state], (error, results,fields) => {
          if (error) {
            return res.status(500).send('Error inserting data');
          }
          res.status(200).send('User added successfully');
        });
      });

    routerr.get('/plant/:c', async (req, res) => {
    try {

        const city = req.params.c;
        if (!city) {
        return res.status(400).send('City is required as a query parameter');
        }
        const response = await axios.get(api_url);
        const records = response.data.records;
        const filteredRecords = records.filter(record => record.city === city);
        res.json(filteredRecords);
  
    } 
    catch (error) {
        console.error(error);
        res.status(500).send('An error occurred while fetching data');
  }
});


routerr.get('/uo',async(req,res)=>{
   
})

routerr.post('/io',async(req,res)=>{
  
  })

routerr.get('/do',async(req,res)=>{
    
})

routerr.get('/da',async(req,res)=>{
  
})

module.exports = routerr;
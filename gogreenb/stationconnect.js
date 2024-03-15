const api_key = '579b464db66ec23bdd000001008f801bb46b446d4d5288ec59676582';
const api_url = `https://api.data.gov.in/resource/3b01bcb8-0b14-4abf-b6f2-c1bfd384ba69?api-key=${api_key}&format=json&offset=10&limit=1000`;

app.get('/data', async (req, res) => {
  try {
    // Extract 'city' from query parameters
    const city = 'Ahmedabad';
    //req.query.city;x`
    if (!city) {
      return res.status(400).send('City is required as a query parameter');
    }

    // Fetch data from the API
    const response = await axios.get(api_url);
    const records = response.data.records;

    // Filter records by city
    const filteredRecords = records.filter(record => record.city === city);

    // Send the filtered data
    res.json(filteredRecords);
  } catch (error) {
    console.error(error);
    res.status(500).send('An error occurred while fetching data');
  }
});

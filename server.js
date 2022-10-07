require('dotenv').config();
const express = require('express');
const cors = require('cors');
const db = require('./db');

const morgan = require('morgan');

const app = express();

app.use(cors());
app.use(express.json());

// Get all Restaurants
app.get('/api/v1/restaurants', async (req, res) => {
  try {
    const result = await db.query('select * from restaurants');

    res.status(200).json({
      status: 'success',
      results: result.rowCount,
      data: {
        restaurants: result.rows,
      },
    });
  } catch (err) {
    console.log(err);
  }
});

const port = process.env.PORT || 3004;
app.listen(port, () => {
  console.log('Server running on port 3005');
});

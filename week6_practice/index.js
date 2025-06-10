import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import morgan from 'morgan';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(morgan('combined'));

const host = process.env.MONGO_HOST;
const username = process.env.MONGO_INITDB_ROOT_USERNAME;
const password = process.env.MONGO_INITDB_ROOT_PASSWORD;
const uri = `mongodb://${username}:${password}@${host}:27017/?authSource=admin`;

mongoose.connect(uri)
  .then(() => console.log('Connected to MongoDB via Mongoose'))
  .catch(err => console.error('Connection failed:', err));

app.get('/', (req, res) => {
  res.send('Hello from Docker + Mongoose + Docker-Compose!\n');
});

app.listen(port, () => {
  console.log(`App is running at http://localhost:${port}`);
});
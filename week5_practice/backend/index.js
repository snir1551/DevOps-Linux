import express from 'express';
import { sum, subtract } from './math.js';

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Math API is running!');
});

app.get('/sum', (req, res) => {
  const { a, b } = req.query;
  const result = sum(Number(a), Number(b));
  res.json({ result });
});

app.get('/subtract', (req, res) => {
  const { a, b } = req.query;
  const result = subtract(Number(a), Number(b));
  res.json({ result });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`🚀 Server listening on port ${port}`);
});
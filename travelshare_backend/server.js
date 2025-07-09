const express = require('express');
const http = require("http");
//const server = http.createServer(app);
const mongoose = require('mongoose');
const cors = require('cors');
const memoryRoutes = require('./routes/memoryRoutes');
require('dotenv').config();
//const session = require('express-session');
//const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());

app.post('/test', (req, res) => {
  console.log("/test にPOSTが届きました:", req.body);
  res.send('OK');
});

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => console.log("DB接続に成功しました"))
.catch((err) => console.log(err));

app.use('/api/memories', memoryRoutes);

const PORT = 5000;
app.listen(PORT, '0.0.0.0' ,() => console.log(`ポート${PORT}でサーバー起動中`));

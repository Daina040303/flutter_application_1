const mongoose = require('mongoose');

const memorySchema = new mongoose.Schema({
  lat: Number,
  lng: Number,
  title: String,
  description: String,
  date: String,
  createdBy: String
});

module.exports = mongoose.model('Memory', memorySchema, 'memories');

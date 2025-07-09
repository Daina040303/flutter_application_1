const express = require('express');
const router = express.Router();
const Memory = require('../models/memory');


// 新規メモリ登録
router.post('/', async (req, res) => {
  try {
    console.log("受信したリクエストボディ:", req.body);

    const memory = new Memory(req.body);
    await memory.save();
    console.log('保存しました');
    res.status(201).send(memory);
  } catch (err) {
    console.log('保存に失敗しました');
    res.status(400).send(err);
  }
});

// 全メモリ取得
router.get('/', async (req, res) => {
  try {
    const memories = await Memory.find();
    console.log('ピンの情報の取得をしました');
    res.send(memories);
  } catch (err) {
    res.status(500).send(err);
  }
});

module.exports = router;

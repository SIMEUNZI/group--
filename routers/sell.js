/* eslint-disable new-cap */
const express = require('express');
const router = express.Router();

const sellDAO = require('./../models/sellDAO'); 



// 판매 정보 조회 
router.get('/checkSells', (req, res, next) => {
  const body = req.body;

  sellDAO.getSellById(body, (resp) => {
    res.json(resp);
  })

});

// 판매 정보 추가 
router.post('/addSells', async (req, res) => {
  try {
    const sellData = req.body;
    await sellDAO.insertSell(sellData);
    res.status(200).json({ message: 'Sell created successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 판매 정보 수정 
router.put('/updateSells', async (req, res) => {
  try {
    const sellId = req.params.id;
    const sellData = req.body;
    await sellDAO.updateSell(sellId, sellData);
    res.json({ message: 'Sell updated successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 판매 정보 삭제 
router.delete('/deleteSells', async (req, res) => {
  try {
    const sellId = req.params.id;
    await sellDAO.deleteSell(sellId);
    res.json({ message: 'Sell deleted successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;

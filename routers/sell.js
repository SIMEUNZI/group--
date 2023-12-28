/* eslint-disable new-cap */
const express = require('express');
const router = express.Router();

const sellDAO = require('./../models/sellDAO'); 


router.get('/checkSell/:sell_id', async (req, res, next) => {
  try {
    const { sellId } = req.params;
    const resp = await sellDAO.getSellById(sellId);
    res.json(resp);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/addSell', async (req, res) => {
  try {
    const sellData = req.body;
    await sellDAO.insertSell(sellData);
    res.status(200).json({ message: 'Sell created successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.put('/updateSell/:sell_id', async (req, res) => {
  try {
    const { sellId } = req.params;
    const sellData = req.body;
    await sellDAO.updateSell(sellId, sellData);
    res.json({ message: 'Sell updated successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.delete('/deleteSell/:sell_id', async (req, res) => {
  try {
    const { sellId } = req.params;
    await sellDAO.deleteSell(sellId);
    res.json({ message: 'Sell deleted successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;



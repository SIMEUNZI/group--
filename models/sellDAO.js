const pool = require('./pool');

const sql = {
  getById: 'SELECT * FROM sell WHERE sell_id = ?',
  getAll: 'SELECT * FROM sell LIMIT ?, ?',
  insert: 'INSERT INTO sell(product_id, user_id, sell_date) VALUES (?, ?, ?)',
  update: 'UPDATE sell SET product_id = ?, user_id = ?, sell_date = ? WHERE sell_id = ?',
  remove: 'DELETE FROM sell WHERE sell_id = ?',
};

const sellDAO = {
  getSellById: async (sellId) => {
    try {
      const conn = await pool.getConnection();
      const [resp] = await conn.query(sql.getById, [sellId]);
      conn.release();
      return { status: 200, message: 'OK', data: resp[0] };
    } catch (error) {
      return { status: 500, message: '판매 정보 조회 실패', error: error };
    }
  },

  getAllSells: async (item) => {
    const no = Number(item.no) - 1 || 0;
    const size = Number(item.size) || 10;

    try {
      const conn = await pool.getConnection();
      const [resp] = await conn.query(sql.getAll, [no * size, size]);
      conn.release();
      return { status: 200, message: 'OK', data: resp };
    } catch (error) {
      return { status: 500, message: '판매 정보 리스트 조회 실패', error: error };
    }
  },

  insertSell: async (sellData) => {
    try {
      const conn = await pool.getConnection();
      const { productId, userId, sellDate } = sellData;
      const [resp] = await conn.query(sql.insert, [productId, userId, sellDate]);
      conn.release();
      return { status: 200, message: 'OK', data: resp };
    } catch (error) {
      return { status: 500, message: '판매 정보 추가 실패', error: error };
    }
  },

  updateSell: async (sellData) => {
    try {
      const conn = await pool.getConnection();
      const { sellId, productId, userId, sellDate } = sellData;
      const [resp] = await conn.query(sql.update, [productId, userId, sellDate, sellId]);
      conn.release();
      return { status: 200, message: 'OK', data: resp };
    } catch (error) {
      return { status: 500, message: '판매 정보 업데이트 실패', error: error };
    }
  },

  deleteSell: async (sellId) => {
    try {
      const conn = await pool.getConnection();
      const [resp] = await conn.query(sql.remove, [sellId]);
      conn.release();
      return { status: 200, message: 'OK', data: resp };
    } catch (error) {
      return { status: 500, message: '판매 정보 삭제 실패', error: error };
    }
  },
};

module.exports = sellDAO;

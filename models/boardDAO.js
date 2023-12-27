const pool = require('./pool')

const sql = {
  boardList: `SELECT b.id, u.name, title, DATE_FORMAT(b.createdAt, '%Y-%m-%d') as createdAt, cnt
    FROM user u INNER JOIN board b ON u.id = b.creatorAt
    ORDER BY b.id DESC
    LIMIT ?, ?`,
  board: `SELECT b.id, u.name, title, email, DATE_FORMAT(b.createdAt, '%Y-%m-%d') as createdAt, content, cnt
    FROM user u INNER JOIN board b ON u.id = b.creatorAt
    WHERE b.id = ?`,
  insert: 'INSERT INTO board(title, content, creatorAt) VALUES(?, ?, ?)',
  update: 'UPDATE board set title = ?, content = ?, updatedAt = NOW() WHERE id = ?',
  delete: 'DELETE FROM board WHERE id = ?',
  incCount: 'UPDATE board SET cnt = cnt + 1 WHERE id = ?',
  totalCount: 'SELECT COUNT(*) as cnt FROM board',
};

const boardDAO = {
  insert: async (item, callback) => {
    let conn = null;
    // console.log(item)
    try {
      conn = await pool.getConnection();
      conn.beginTransaction();

      const [resp] = await conn.query(sql.insert, [item.title, item.content, item.creatorAt]);
      conn.commit();
      callback({ status: 200, message: 'OK', data: resp });
    } catch (error) {
      conn.rollback();
      callback({ status: 500, message: '게시물 입력 실패', error: error });
    } finally {
      if (conn !== null) conn.release();
    }
  },
  update: async (item, callback) => {
    let conn = null;
    try {
      conn = await pool.getConnection();
      conn.beginTransaction();

      const [resp] = await conn.query(sql.update, [item.title, item.content, item.id]);
      conn.commit();

      callback({ status: 200, message: 'OK', data: resp });
    } catch (error) {
      conn.rollback();
      callback({ status: 500, message: '로그인 실패', error: error });
    } finally {
      if (conn !== null) conn.release();
    }
  },

  delete: async (item, callback) => {
    console.log(item)
    let conn = null;
    try {
      conn = await pool.getConnection();
      conn.beginTransaction();

      const [resp] = await conn.query(sql.delete, [Number(item.id)]);
      conn.commit();

      callback({ status: 200, message: 'OK', data: resp });
    } catch (error) {
      conn.rollback();
      callback({ status: 500, message: '게시물 삭제 실패', error: error });
    } finally {
      if (conn !== null) conn.release();
    }
  },

  boardList: async (item, callback) => {
    const no = Number(item.no) - 1 || 0;
    const size = Number(item.size) || 10;

    let conn = null;
    try {
      conn = await pool.getConnection();

      const [resp] = await conn.query(sql.boardList, [no * size, size]);
      const [cntResp] = await conn.query(sql.totalCount);

      const totalPage = Math.ceil(cntResp[0].cnt / size); // 81 => 81 / 10 => 8에 나머지 있으면 무조건 올림 => 9
      callback({
        status: 200, message: 'OK',
        pageno: no + 1, pagesize: size, total: cntResp[0].cnt, totalPage, data: resp
      });
    } catch (error) {
      callback({ status: 500, message: '게시물 리스트 조회 실패', error: error });
    } finally {
      if (conn !== null) conn.release();
    }
  },
  board: async (item, callback) => {
    let conn = null;
    try {
      conn = await pool.getConnection();
      conn.beginTransaction();

      const [resp] = await conn.query(sql.board, [item.id]);
      await conn.query(sql.incCount, [item.id]);

      conn.commit();
      callback({ status: 200, message: 'OK', data: resp[0] });
    } catch (error) {
      conn.rollback();
      callback({ status: 500, message: '게시물 조회 실패', error: error });
    } finally {
      if (conn !== null) conn.release();
    }
  },

  temp: async (item, callback) => {
    let conn = null;
    try {
      conn = await pool.getConnection();

      callback({ status: 200, message: 'OK' });
    } catch (error) {
      callback({ status: 500, message: '로그인 실패', error: error });
    } finally {
      if (conn !== null) conn.release();
    }
  },
}
module.exports = boardDAO;

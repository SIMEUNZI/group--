/* eslint-disable new-cap */
const express = require('express');
const router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

// router.get('/api/sells', (req, res, next) => {
//   const query = req.query;

//   sellDAO.getSellById(query, (resp) => {
//     res.json(resp);
//   })

// });

router.get('/api/get/nodejs-api', function(req, res){
   res.status(200).json({
       "message" : "hello get api nodejs-api"
        });
 });

router.get('/api/get/dog', function(req, res){
   res.status(200).json({
       "message" : "멍멍"
        });
 });

router.post('/api/post/nodejs-api',function(req, res){
	res.status(200).json({
    	"message" : "hello post api nodejs-api"
    });    
}); 

router.get('/api/get/form', function(req, res){
   res.status(200).json({
       "message" : "이잉?"

        });
 });



// ----------------------------------------------------------
// 데이터
const data = [
  { id: 1, name: 'John' },
  { id: 2, name: 'Alice' },
  // ... 더 많은 데이터
];

// GET 요청에 응답하는 엔드포인트
router.get('/api/data', (req, res) => {
  res.json(data); // 데이터를 JSON 형식으로 반환
});

// 서버 시작
// router.listen(8000, () => {
//   console.log('서버가 8000번 포트에서 실행 중입니다.');
// });

// ---------------------------------------------------------


module.exports = router;


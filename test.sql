-- Active: 1699575900904@@127.0.0.1@3306@mydb

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `nickname` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `point` INT NULL,
  `birthday` DATE NOT NULL,
  `tel` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `nickname_UNIQUE` (`nickname` ASC) VISIBLE);

-- -----------------------------------------------------
-- Table `mydb`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`board` (
  `board_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(1024) NOT NULL,
  `count` INT NULL DEFAULT 0,
  `createdAt` DATETIME NULL DEFAULT now(),
  `updatedAt` DATETIME NULL DEFAULT now(),
  `user_id` INT NULL COMMENT 'user table(user_id)',
  `board_no` INT NULL,
  PRIMARY KEY (`board_id`),
  INDEX `fk_board_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_board_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `comment_content` VARCHAR(1024) NOT NULL,
  `createdAt` DATETIME NULL DEFAULT now(),
  `comment_no` INT NULL,
  `board_id` INT NULL COMMENT 'board table(board_id)',
  `user_id` INT NULL COMMENT 'user table(user_id)',
  PRIMARY KEY (`comment_id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_board1_idx` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_board1`
    FOREIGN KEY (`board_id`)
    REFERENCES `mydb`.`board` (`board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `cost_price` INT NOT NULL,
  `sale_price` INT NOT NULL,
  `state` VARCHAR(50) NULL,
  `ex_date` VARCHAR(100) NOT NULL,
  `barcode` VARCHAR(100) NOT NULL,
  `info` VARCHAR(1000) NULL,
  `createdAt` DATETIME NULL DEFAULT now(),
  `like_cnt` INT NULL,
  `sale` INT NULL,
  `user_id` INT NULL COMMENT 'user table(user_id)',
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `barcode_UNIQUE` (`barcode` ASC) VISIBLE,
  CONSTRAINT `fk_product_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`sell`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sell` (
  `sell_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL COMMENT 'product table(product_id)',
  `user_id` INT NULL COMMENT 'user table(user_id)',
  `sell_date` DATE NOT NULL,
  PRIMARY KEY (`sell_id`),
  INDEX `fk_sell_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_sell_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_sell_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sell_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wishlist` (
  `wish_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL COMMENT 'product table(product_id)',
  `user_id` INT NULL COMMENT 'user table(user_id)',
  PRIMARY KEY (`wish_id`),
  INDEX `fk_wishlist_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_wishlist_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_wishlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wishlist_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

--------------------------------------


SELECT * FROM user;
SELECT * FROM board;
SELECT * FROM comment;
SELECT * FROM product;
SELECT * FROM sell;

SELECT sell_id, product_id, user_id  FROM sell;
INSERT INTO sell (product_id, user_id, sell_date) VALUES (1, 1, '2023-12-31');


SELECT sell_id, product_id, user_id, sell_date FROM sell WHERE sell_id = 2;


SELECT * FROM wishlist;

DROP TABLE IF EXISTS user, sell, product, board, comment, wishlist;



INSERT INTO user(name, nickname, email, password, updatedAt, point, birthday, tel) 
VALUES('홍길동', '길동닉', 'nolbu1@company.com', 'abc123', '2023-12-22', 30000, '2023-12-22', '010-5412-3456');

INSERT INTO board(title, content, count, `createdAt`, `updatedAt`, user_id, board_no) 
VALUES('제목', '정말어렵다 데이터베이스', 1, '2023-11-03', '2023-12-03', 1, 1);

INSERT INTO product(name, cost_price, sale_price, ex_date, barcode, user_id) 
VALUES('치킨', 35000, 31500, '2023-12-25','3346-6897-1285-4685', 1);

INSERT INTO product(name, cost_price, sale_price, ex_date, barcode, user_id) 
VALUES('족발', 35000, 53000, '2023-12-25','1155-2648-1285-4685', 1);

INSERT INTO product(name, cost_price, sale_price, ex_date, barcode, user_id, state) 
VALUES('초밥', 20000, 15000, '2023-12-25','9999-6666-1285-4685', 1, '판매완료');


INSERT INTO sell(sell_date,product_id, user_id) 
VALUES('2088-12-12', 1, 1);

UPDATE product SET state='판매완료' where product_id = 1

SELECT b.user_id, b.title, b.content
FROM user u INNER JOIN board b ON u.user_id = b.user_id;

-- 구매목록 가져오기
SELECT p.name, p.sale_price, s.sell_date, p.state
FROM product p INNER JOIN sell s ON p.user_id = s.user_id
WHERE p.state = '판매완료';

-- 판매목록 가져오기
SELECT p.name, p.sale_price, s.sell_date, p.state
FROM product p INNER JOIN sell s ON p.user_id = s.user_id
WHERE p.state = '판매중';

-- 판매상품을 판매완료했을때
UPDATE product
JOIN sell ON product.user_id = sell.user_id
SET product.state = '판매완료',
    sell.sell_date = '2023-12-25'
WHERE product.product_id = 1;


UPDATE product SET state='판매중' where product_id IN (1,2,3);
UPDATE product SET ='판매중' where product_id IN (1,2,3);



--------------------------------------

SELECT * FROM user;
INSERT INTO user(user_id, name, nickname, email, password, updatedAt, point, birthday, tel) VALUES(null, '3조', '프로젝트','project@company.com', 'abc123', '2023-12-25', '30000','1996-04-10','010-1234-5678');


-- INSERT INTO BOOK_MEMBER (memberId, memberPw, memberName, memberMail, memberAddr1, memberAddr2, memberAddr3, adminCk, regDate, money, point)
-- VALUES ('사용자 입력 값', '사용자 입력 값', '사용자 입력 값', '사용자 입력 값', '사용자 입력 값', '사용자 입력 값', '사용자 입력 값', 0, SYSDATE, 0, 0);


SELECT * FROM board;
INSERT INTO board(board_id, title, content, cnt, createdAt, updatedAt, user_id, board_no) VALUES(null,'게시판1','내용1','0','2023-12-25','2023-12-24',null,'112' );


-- board_no 삭제하는 구문
DELETE FROM board WHERE board_no = 119;


-- ALTER TABLE product CHANGE `like` like_cnt INT;  -> 컬럼명 변경 코드

SELECT * FROM product
WHERE product_id
ORDER BY like_cnt DESC
LIMIT 10;

INSERT INTO product(product_id, name, cost_price, sale_price, state, ex_date, bar_num, info, `createdAt`,like_cnt, sale, user_id) VALUES( );

INSERT INTO sell(sell_id, product_id, user_id, sell_date) VALUES(1,2,3,'2023-12-25');



SELECT * FROM sell;
SELECT * FROM wishlist;
SELECT * FROM comment;



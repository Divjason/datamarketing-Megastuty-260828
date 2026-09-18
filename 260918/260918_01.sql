# SQL

# DDL, DML, DCL, TCL
# DML >
# SELECT~FROM, WHERE, AS, LIMIT, DISTINCT, GROUP BY, ORDER BY
# wconcept : 데이터 출처 3개의 경우 발생
# Best Ranking 200 상품정보
# 각 상품별 리뷰정보
# 각 브랜드별 블로그 컨텐츠정보

# 상품의 리뷰, 상품 브랜드의 블로그 컨텐츠
# 1) 애초에 출처가 서로 다른 데이터를 1개의 테이블안에 모두 저장
# > 컬럼(열) 굉장히 길어질것 같음
# > 데이터의 중복이 발생

CREATE DATABASE IF NOT EXISTS sqlDB;

SHOW DATABASES;

USE sqlDB;

CREATE TABLE IF NOT EXISTS userTbl (
	userID TINYINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL,
    birthYear INT NOT NULL,
    address VARCHAR(50) NOT NULL,
    # 인자값으로 입력된 숫자만큼 문자열 사용하겠다는 선언,
    # 만약 해당 숫자만큼 사용하지 않았다면 다시 사용하지않은 만큼 메모리를 반환
    # 숫자만큼 사용!, 해당 숫자만큼 사용하지 않아도 반환 x
    mobile1 CHAR(3), 
    mobile2 CHAR(8),
    height TINYINT UNSIGNED,
    mDate DATE,
    INDEX idx_userTbl_name (name),
    INDEX idx_userTbl_address (address)
);

SHOW TABLES;

DESC userTbl;

CREATE TABLE IF NOT EXISTS buyTbl (
	no INT UNSIGNED NOT NULL,
    userID TINYINT UNSIGNED NOT NULL,
    product_name VARCHAR(20),
    category_name VARCHAR(20),
    price INT NOT NULL,
    amount TINYINT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

# 기본키 = PRIMARY KEY (주요한)
# 외래키 = FOREIGN KEY (외부)
# -> 현재 우리의 테이블을 외부의 테이블과 연결하려고할 때, 그 연결고리의 역할 맡을 키

SHOW TABLES;

DESC buyTbl;
DESC userTbl;

/*
	userID TINYINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL,
    birthYear INT NOT NULL,
    address VARCHAR(50) NOT NULL,
    mobile1 CHAR(3), 
    mobile2 CHAR(8),
    height TINYINT UNSIGNED,
    mDate DATE,
    INDEX idx_userTbl_name (name),
    INDEX idx_userTbl_address (address)
*/

INSERT INTO userTbl (
userID, name, birthYear, address, mobile1, mobile2, height, mDate)
VALUES(1, "아이유", 1993, "서울시", "010", "12345678", 163, "2026-9-18");

SELECT * FROM userTbl;

INSERT INTO buyTbl (
no, userID, product_name, category_name, price, amount)
VALUES(1, 1, "나이키운동화", "신발잡화", 30000, 2);

SELECT * FROM buyTbl;

SELECT name, product_name, price, amount
FROM userTbl U
JOIN buyTbl B ON B.userID = U.userID; 

/*
Error Code: 1452.
Cannot add or update a child row:
a foreign key constraint fails
(`sqldb`.`buytbl`, CONSTRAINT `buytbl_ibfk_1` FOREIGN KEY 
(`userID`) REFERENCES `usertbl` (`userID`))
부모요소와 자식요소의 테이블 관계 성립
userTbl, buyTbl

> 복수의 테이블을 생성 관리 (이유.목적.명분)
> 외래키를 생성 관리 -> 제약요소
> 1) 반드시 부모 생성 -> 자식요소 생성
> 2) 반드시 자녀 삭제 -> 부모요소 삭제
*/

DELETE FROM userTbl WHERE userID = 1;

/*
Error Code: 1451.
Cannot delete or update a parent row:
a foreign key constraint fails
(`sqldb`.`buytbl`, CONSTRAINT `buytbl_ibfk_1` FOREIGN KEY
(`userID`) REFERENCES `usertbl` (`userID`))
*/







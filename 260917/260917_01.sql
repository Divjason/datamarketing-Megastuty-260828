CREATE DATABASE IF NOT EXISTS customer_db;

USE customer_db;

SHOW DATABASES;

CREATE TABLE IF NOT EXISTS customer (
	no INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    age TINYINT UNSIGNED,
    phone VARCHAR(15),
    email VARCHAR(30) NOT NULL,
    address VARCHAR(100)
);


SHOW TABLES;

DESC customer;

DROP DATABASE IF EXISTS customer_db;

DROP TABLE IF EXISTS customer;

# ALTER : 이미 생성된 테이블 내 요소 변경.수정
# MODIFY : 특정 컬럼의 속성값을 변경
# CHANGE : 특정 컬럼의 단순 속성값 뿐만 아니라 컬럼의 이름 = 필드명까지 변경
ALTER TABLE customer MODIFY COLUMN
phone VARCHAR(20) NOT NULL;

ALTER TABLE customer CHANGE COLUMN
phone user_phone VARCHAR(15);

ALTER TABLE customer
	MODIFY COLUMN email VARCHAR(50) NOT NULL,
    CHANGE COLUMN address user_address VARCHAR(120);








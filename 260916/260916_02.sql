# DB생성
CREATE DATABASE IF NOT EXISTS dbname;

# 현재 내가 취급할 수 있는 DB조회
SHOW DATABASES;

# DB접속
USE dbname;

# TABLE 생성
CREATE TABLE mytable (
	id INT,
    name VARCHAR(10),
    PRIMARY KEY(id)
);

# TABLE 조회
SHOW TABLES;

# DB삭제
DROP DATABASE dbname;

# CRUD : Create Read Update Delete
# 일반적인 프로그래밍 학습 시, 최소한의 주요기능 = 생성, 읽기, 수정, 삭제

CREATE DATABASE dave;
USE dave;
CREATE TABLE history (
	name VARCHAR(10),
    age INT,
    job VARCHAR(20),
    birthday DATETIME
);

CREATE TABLE mytable (
	id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(50)
);

SHOW DATABASES;
SHOW TABLES;

# 생성된 테이블의 세부적인 구성 정보를 조회.확인
DESC history;
DESC mytable;

# 컬럼 : 정수 = 80~90% INT





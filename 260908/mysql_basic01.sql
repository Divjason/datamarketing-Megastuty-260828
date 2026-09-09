-- MySQL 명령어 실행방법 : ctrl + enter (*MAC = command)

-- 1) 신규 데이터베이스 생성하기
CREATE DATABASE yes24_260908;

-- 2) 생성된 데이터베이스 선택하기
USE yes24_260908;

-- 3) 생성된 데이터베이스 안에 테이블 생성하기
CREATE TABLE books (
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_title VARCHAR(100),
    author VARCHAR(100),
    publisher VARCHAR(30),
    publish_date VARCHAR(30),
    book_price INT
);

-- 4) 현재 생성된 데이터베이스 안에 있는 테이블 목록 조회
SHOW TABLES;

-- 5) 테이블 내부 값 조회
SELECT * FROM books;

-- 6) 최초 테이블 생성 시, 약속한 스키마 속성 조회
DESC books;

-- 7) 테이블 안에 값을 저장하는 방법
-- 데이터시간에는 자동으로 한 번에 복수의 값을 저장하는 방법 배울 예정 (python)
INSERT INTO books (
book_id, book_title, author, publisher, publish_date, book_price
) VALUES
	(1, "박곰희 연금 부자 수업", "박곰희", "인플루엔셜", "2025년 06월", 18900),
    (2, "ETF 투자의 모든 것", "문일호", "매일경제신문사", "2025년 08월", 18900),
    (3, "돈의 속성 400쇄 리커버", "김승호", "스노우폭스북스", "2020년 06월", 16020),
    (4, "돈. 뜨겁게 사랑하고 차갑게 다루어라", "앙드레 코스톨라니", "미래의창", "2023년 09월", 13500),
    (5, "듀얼 브레인", "이선 몰릭", "상상스퀘어", "2025년 03월", 18900);

SELECT
	book_title, book_price
FROM books
ORDER BY book_price DESC
LIMIT 3;

-- 8) 테이블 생성 후 수정.변경이 필요한 경우

-- 8-1) 해당 테이블 내 신규 열(컬럼) 필요한 경우
ALTER TABLE books ADD COLUMN rating FLOAT(3);

-- 8-2) 해당 테이블 내 기존 컬럼의 데이터 타입(스키마) 변경 필요한 경우
ALTER TABLE books MODIFY COLUMN author VARCHAR(150);

-- 8-3) 해당 테이블 내 컬럼(필드명) 이름 변경
ALTER TABLE books RENAME COLUMN book_title TO title;

-- 8-4) 해당 테이블 내 데이터 타입 & 컬럼 이름 동시 변경
ALTER TABLE books CHANGE COLUMN author book_author VARCHAR(200);

-- 8-5) 해당 테이블 내 컬럼 삭제
ALTER TABLE books DROP COLUMN rating;

-- 8-6) 해당 테이블 이름 변경
ALTER TABLE books RENAME TO yes24_books;








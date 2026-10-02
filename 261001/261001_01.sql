# 데이터베이스 생성
# 테이블 생성
# 스키마 적용
# 컬럼별 값을 삽입

CREATE DATABASE IF NOT EXISTS wconcept_db_261001
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

USE wconcept_db_261001;
CREATE TABLE brands;

DROP DATABASE IF EXISTS wconcept_db_261001;

USE wconcept_db_261001;

SHOW TABLES;

DESC products;

SELECT * FROM products;
SELECT * FROM brands;
SELECT * FROM crawl_runs;
SELECT * FROM blog_posts;
SELECT * FROM product_snapshots;
SELECT * FROM reviews;
SELECT * FROM review_evaluations;
SELECT * FROM review_images;
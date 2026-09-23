# 지금까지 공부해왔던 SQL 문법 : 의지만 있다면, 어렵지 않게 이해!
# 처음 적응을 힘들어하시는 분들이 조금씩 등장!!
# Subquery 개념

# JOIN을 활용해서 서로 다른 테이블간 관계 연결
# Subquery를 통해서 원래 서로 다른 테이블간 관계 연결
# Sub (보조) + Query (질의.질문.요청)
# Structured Query Language : DDL, DML, DTL
# 원래 메인 쿼리문이 존재 > 잘 사용하려고 하다보니 추가적인 쿼리문이 또 필요!
# 서브쿼리 = 쿼리문 안에 또다른 쿼리문 작성 구문
# 서브쿼리를 사용하는 방식 3개
# 1) 단일값 서브쿼리 = scalar subquery :
# WHERE절 안에 단일 값을 반환하기 위한 목적으로 서브쿼리 사용
# 2) 다중행 서브쿼리 :
# WHERE절 함께 사용, IN (서브쿼리 구문)
# 3) 상관 서브쿼리 = correlated subquery
# 서브쿼리 구문이 먼저 사용된 메인 쿼리문의 영향을 받음

# JOIN 구문 사용하는 경우, 80%
# 서브쿼리 익숙, 간단하게 조회

USE bestproducts;

SELECT title
FROM items LIMIT 5;

SELECT *
FROM ranking
WHERE sub_category = "여성신발"
LIMIT 5;

SELECT title
FROM items I
INNER JOIN ranking R USING(item_code)
WHERE sub_category = "여성신발";

SELECT title
FROM items
WHERE item_code IN (
	SELECT item_code FROM ranking
    WHERE sub_category = "여성신발"
);

# sakila DB
# 영화 카테고리 = 장르가 comedy인 영화의 고유한 장르 아이디를 조회
# 해당 장르 아이디보다 낮은 아이디를 갖고 있는 장르를 조회
# 조회한 각 장르별 영화 갯수를 검색
# 영화 1000편 => 100편 액션, 드라마 40편, 스포츠 30편
# 액션 = 1, 드라마 = 2, 스포츠 = 3, 코메디 = 4

USE sakila;
# 영화 장르 : category
SHOW TABLES;

SELECT * FROM category;
# 카테고리가 총 16개 -> 코메디 = Comedy = category_id = 5

SHOW TABLES; # film_category
SELECT * FROM film_category LIMIT 5;

# 각 카테고리 = 장르별 영화 갯수
# 코메디보다 값이 큰 아이디를 갖고 있는 장르에 한해서 조회
# 해당 장르별 영화 갯수를 조회

SELECT
	category_id,
    COUNT(*) film_count
FROM film_category F
WHERE F.category_id > (
	SELECT C.category_id FROM category C
	WHERE name = "Comedy")
GROUP BY F.category_id;

# bestproducts 데이터베이스 > 테이블 활용
# 할인 가격이 10만원 이상인 상품이 메인카테고리별로 몇 개나 있는지 조회
# 1) JOIN : inner join
# 2) SubQuery : scalar subquery

USE bestproducts;

SHOW TABLES;

DESC items;

SELECT * FROM items LIMIT 5;

SELECT
	R.main_category,
    COUNT(*) category_count
FROM ranking R
WHERE R.item_code IN (
	SELECT I.item_code FROM items I
    WHERE dis_price >= 100000	
)
GROUP BY R.main_category;

SELECT
	R.main_category,
    COUNT(*) category_count
FROM ranking R
JOIN items I USING(item_code)
WHERE I.dis_price >= 100000
GROUP BY R.main_category;

# 하지 말아야 할 것
# 코드 및 문법을 외우는 행위 -> 시험, 대기업 취업 시, 코테
# 코드를 작성하는 원리, 각 구문이 실행되는 기능
# 코드를 읽을 수 있는 능력








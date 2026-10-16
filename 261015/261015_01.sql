USE sakila;

SELECT * FROM film LIMIT 5; # film_id

SELECT * FROM inventory LIMIT 5; # film_id

SELECT film_id FROM film
UNION
SELECT film_id FROM inventory;

SELECT film_id FROM film
UNION ALL
SELECT film_id FROM inventory;

# SQL > 쿼리문을 열심히 학습!!
# GA4 (퍼포먼스 마케팅 // 그로스 마케팅)
# GA4 : 웹.앱 트래픽 데이터 조회.추정.인사이트 (기본)
# GA4 + GAds + MetaAds : 분석
# BigQuery : 쿼리문을 거의 80% 재사용

-- SELECT film_id FROM film
-- INTERSECT
-- SELECT film_id FROM inventory;

SELECT DISTINCT F.film_id
FROM film F
JOIN inventory I ON F.film_id = I.film_id;

SELECT film_id
FROM film
WHERE film_id IN (SELECT film_id FROM inventory);

-- SELECT film_id FROM film
-- EXCEPT
-- SELECT film_id FROM inventory;

SELECT F.film_id
FROM film F
LEFT JOIN inventory I ON I.film_id = F.film_id
WHERE I.film_id IS NULL;

SELECT film_id
FROM film
WHERE film_id NOT IN (
	SELECT film_id
    FROM inventory
);
# IN : 우항 (우측항을 목록화 인지 -> 목록가운데 좌항의 값이 존재)

SELECT F.film_id
FROM film F
WHERE NOT EXISTS (
	SELECT 1
    FROM inventory I
    WHERE F.film_id = I.film_id
);

# 목록 속에서 특정 요소를 찾는 방법 x
# T/F : 특정 요소가 존재하는가, 하지 않는가




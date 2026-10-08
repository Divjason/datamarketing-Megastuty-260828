# 복합서브쿼리 구문
# 각 고객들은 영화를 렌탈할 수 있습니다.
# 각 고객들이 렌탈했던 영화들은 각각의 영화마다의 영화재생길이
# 1 : 80, 2 : 90, ... 10 : 130
# 해당 렌탈 영화들의 평균 길이 => 100분
# 조회하고 싶은 결과 : 내가 그동안 렌탈했었던 영화의 재생길이가
# 내가 그동안 렌탈했었던 모든 영화들의 평균 재생길이보다 긴 영화들만
# 찾아서 해당 영화들의 제목만 조회

# 내가 = 고객들이 그동안 렌탈했었던 영화들의 재생시간 (A)
# 내가 = 고객들이 그동안 렌탈했었던 영화들의 평균 재생시간 (B)
# A > B 조건에 해당되는 영화들의 제목만 가져오면 됨

# 고객의 데이터
SELECT * FROM customer LIMIT 5; # customer_id, first_name, last_name

# 고객렌탈 데이터
SELECT * FROM rental LIMIT 5; # customer_id, rental_id, inventory_id

# 영화재고 데이터
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id

# 영화들의 재생시간
SELECT * FROM film LIMIT 5; # film_id, title, length

SELECT
	CONCAT(C.first_name, " ", C.last_name) full_name,
    COUNT(*) customer_count
--     F.title
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.length > (
	SELECT AVG(FIL.length)
    FROM film FIL
    JOIN inventory INV ON INV.film_id = FIL.film_id
    JOIN rental REN ON REN.inventory_id = INV.inventory_id
    WHERE REN.customer_id = C.customer_id
)
GROUP BY full_name
ORDER BY customer_count DESC;

SELECT
-- 	CONCAT(C.first_name, " ", C.last_name) full_name,
--     COUNT(*) customer_count
    F.title,
    COUNT(*) rental_count
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.length > (
	SELECT AVG(FIL.length)
    FROM film FIL
    JOIN inventory INV ON INV.film_id = FIL.film_id
    JOIN rental REN ON REN.inventory_id = INV.inventory_id
    WHERE REN.customer_id = C.customer_id
)
GROUP BY F.title
ORDER BY rental_count DESC;

# 영화 테이블이 존재
# 영화 테이블에는 영화 렌탈 시, 보증금을 입금하는데
# 해당 보증금 얼마인지 확인 컬럼 (replacement_cost)
# 보증금이 20달러 이상인 영화를 대여한 고객이 존재
# 해당 고객들의 이름을 조회 (단, 고객들의 이름을 소문자로)



# 고객 테이블
SELECT * FROM customer LIMIT 5; # customer_id, first_name, last_name

# 렌탈 테이블
SELECT * FROM rental LIMIT 5; # rental_id, customer_id, inventory_id

# 재고 테이블
SELECT * FROM inventory LIMIT 5; # film_id, inventory_id

# 영화 테이블
SELECT * FROM film LIMIT 5; # replacement_cost, film_id


SELECT
	DISTINCT LOWER(CONCAT(C.first_name, " ", C.last_name)) full_name
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.replacement_cost >= 20;





USE sakila;

SELECT SQRT(4);
SELECT SQRT(9);

SELECT
	ROUND(SQRT(length), 2) film_length_sqrt
FROM film
WHERE length >= 120;

# 고객의 이름을 출력
# 고객들이 영화를 렌탈하면서 지불한 결제 비용 존재
# 해당 결제 비용의 전체 평균
# 고객들의 전체 결제 총 비용의 평균값보다 큰 금액으로
# 결제한 고객들만 선별해서 출력

SELECT COUNT(*) FROM customer; # 599명

SELECT
	CONCAT(first_name, " ", last_name) full_name
FROM customer LIMIT 5;

SELECT * FROM payment LIMIT 5; # amount / customer_id
SELECT * FROM customer LIMIT 5; # customer_id

SELECT AVG(amount) FROM payment; # 4.201356

# 일반 서브쿼리 구문
# 거의 대부분 조건절에서 서브쿼리 구문 등장
# 평균 금액보다 더 높은 금액 지불한 고객 찾기
SELECT
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id IN (
	SELECT
		customer_id
    FROM payment
    WHERE amount > (
		SELECT AVG(amount)
        FROM payment
    )
);

# 고객별 지불한 횟수가 상이
# 현재 전체 고객 599명
# A고객 3년동안 10회, B고객 3년동안 50회
# 조건 : 전체 고객 599명을 기준, 평균 렌탈 횟수
# 전체 평균 렌탈 횟수 대비 그보다 더 많은 렌탈 횟수를 가지고 있는
# 고객만 선별해서 이름 조회
# ~별, ~당, ~의 : 고객별 그룹 => COUNT(*)
# GROUP BY
# 전체 평균 렌탈 횟수보다 높은 사람들만 조건식을 통해 선별 출력!

SELECT
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id IN (
	SELECT
		customer_id
    FROM payment
    WHERE amount > (
		SELECT AVG(amount)
        FROM payment
    )
);

# 고객별 렌탈 횟수 = 서비스 진행 기간 중 몇 번의 결제 진행 횟수
# 전체 총 렌탈 횟수 평균
# 고객별 렌탈 횟수 > 전체 총 렌탈 횟수 평균

SELECT * FROM payment LIMIT 5;

SELECT
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT AVG(payment_count)
		FROM (
			SELECT
				COUNT(*) payment_count
			FROM payment
			GROUP BY customer_id
		) payment_counts
    )
);

# 전체 599명 고객 가운데, 가장 많은 대여 횟수 기록을 갖고 있는 고객의
# 이름을 조회!!!

SELECT
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
    FROM (
		SELECT
			customer_id,
			COUNT(*) payment_count
		FROM payment
		GROUP BY customer_id
    ) payment_counts
    ORDER BY payment_count DESC
    LIMIT 1
);

# 상관서브쿼리

SELECT
	customer_id,
    amount,
    payment_date
FROM payment P
WHERE amount > (
	SELECT AVG(amount)
    FROM payment
    WHERE customer_id = P.customer_id
);

SELECT
	customer_id,
    amount,
    payment_date
FROM payment;

# 1번 고객, 0.99, 5.99, 2.99, 9.99

SELECT
	customer_id,
	AVG(amount) cutomer_avg
FROM payment
GROUP BY customer_id;

# 1번 고객, 평균 결제 금액 3.70
# 2번 고객, 평균 결제 금액 4.76

# 영화 테이블은 영화 관련 정보 데이터 저장
# 각 영화는 본인 영화마다 상영시간을 가지고 있습니다.
# 전체 총 영화들의 평균 상영시간보다 개별 영화들의 상영시간이 긴 영화들만 찾아서
# 해당 영화들의 제목만 출력하고 싶어요!

SELECT title FROM film
WHERE length > (
	SELECT
		AVG(length)
    FROM film
);

# 고객들은 저마다 렌탈 횟수를 가지고 있음
# 전체 고객들의 평균 렌탈 횟수보다 더 많은 렌탈 횟수 기록을 갖고 있는 고객들의
# 이름을 조회!!
# 조건 : 고객별 렌탈횟수 > 전체 고객 평균 렌탈횟수
# 이름

SELECT * FROM customer LIMIT 5;

SELECT
	CONCAT(first_name, " ", last_name) full_name,
    (
		SELECT COUNT(*) FROM rental R
		WHERE R.customer_id = C.customer_id
	) customer_count
FROM customer C
WHERE C.customer_id IN (
	SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT
			AVG(rental_count)
		FROM (
			SELECT
				customer_id,
				COUNT(*) rental_count
			FROM rental
			GROUP BY customer_id
		) rental_counts
    )
);









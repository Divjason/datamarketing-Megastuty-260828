USE sakila;

SELECT
	title,
    LENGTH(title) title_len
FROM film LIMIT 10;

SELECT
	title,
	LOWER(title) chagne_lower1,
    UPPER(LOWER(title)) chagne_lower2,
    LENGTH(title) title_len
FROM film LIMIT 10;

SELECT * FROM actor LIMIT 5;
SELECT
	first_name,
    last_name,
    CONCAT("Actor_Name : ", first_name, " / ", last_name) full_name
FROM actor LIMIT 5;

SELECT
	description,
    SUBSTRING(description, 3, 10) short_description
FROM film LIMIT 5;
# 파이썬 언어 & 대부분의 프로그래밍 언어 : 문자열의 인덱스 0부터 시작!

SELECT
	*
FROM film
WHERE LENGTH(title) = 15; # 122편

SELECT COUNT(*) FROM film; # 1000편

SELECT
	CONCAT(first_name, " ", last_name) full_name
FROM actor
WHERE LOWER(first_name) = "john";

# 영화 테이블에서 영화 설명 컬럼안에 있는 문장 가운데
# 3번째 문자부터 6개의 문자가 "Action"인 영화의 제목을 찾아서 조회!

SELECT
	title
FROM film
WHERE SUBSTRING(description, 3, 6) = "Action";

SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
SELECT NOW(), CURDATE(),CURTIME();

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY);
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 7 DAY);

SELECT * FROM rental LIMIT 5;

SELECT
	rental_date,
    DATE_ADD(rental_date, INTERVAL 9 DAY) 9day_plus,
    return_date
FROM rental
WHERE return_date > DATE_ADD(rental_date, INTERVAL 9 DAY);

SELECT
    COUNT(return_date) return_delay
FROM rental
WHERE return_date > DATE_ADD(rental_date, INTERVAL 9 DAY);

SELECT
	payment_date,
    EXTRACT(YEAR FROM payment_date) ext_year,
    EXTRACT(MONTH FROM payment_date) ext_month,
    EXTRACT(DAY FROM payment_date) ext_day,
    EXTRACT(HOUR FROM payment_date) ext_hour,
    EXTRACT(MINUTE FROM payment_date) ext_minute,
    EXTRACT(SECOND FROM payment_date) ext_second,
    YEAR(payment_date) ext_year,
    MONTH(payment_date) ext_month,
    DAY(payment_date) ext_day,
    HOUR(payment_date) ext_hour,
    MINUTE(payment_date) ext_minute,
    SECOND(payment_date) ext_second
FROM payment LIMIT 5;

SELECT
	DAYOFWEEK(payment_date) payment_dayofweek
FROM payment
LIMIT 5;

SELECT
	CASE DAYOFWEEK(payment_date)
		WHEN 1 THEN "일요일"
        WHEN 2 THEN "월요일"
        WHEN 3 THEN "화요일"
        WHEN 4 THEN "수요일"
        WHEN 5 THEN "목요일"
        WHEN 6 THEN "금요일"
        WHEN 7 THEN "토요일"
	END AS payment_dayname,
    COUNT(*) total_count
FROM payment
GROUP BY payment_dayname
ORDER BY total_count DESC;

SELECT
	rental_date,
    return_date,
    TIMESTAMPDIFF(DAY, rental_date, return_date) rental_days
FROM rental
WHERE return_date IS NOT NULL
ORDER BY rental_days DESC;

SELECT
	DATE_FORMAT(rental_date, "%Y-%m-%d") formatted_rental_date
FROM rental;

# rental 테이블에서 대여날짜가 2006년 1월 1일 이후(포함)인 모든 대여에
# 대해 예상 반납 날짜를 대여 날짜로부터 5일 뒤로 산정하여 출력시켜주세요

SELECT
	rental_date,
    DATE_ADD(rental_date, INTERVAL 5 DAY) return_day
FROM rental
WHERE rental_date >= "2006-01-01";

SELECT
	rental_date
FROM rental
WHERE YEAR(rental_date) >= "2006";

SELECT
	rental_date
FROM rental
WHERE EXTRACT(YEAR FROM rental_date) >= "2006";

SELECT ABS(-1);

SELECT
	ABS(-amount) absolute_amount,
    CEIL(amount) ceiling_amount,
    FLOOR(amount) flooring_amount,
    ROUND(amount, 2) rounding_amount
FROM payment;







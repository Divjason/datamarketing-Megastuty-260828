SET SQL_SAFE_UPDATES = 0;

SELECT * FROM customer LIMIT 5;

START TRANSACTION;

UPDATE customer SET first_name = "PARK";

ROLLBACK; # COMMIT 이 안된 상황!!!

# -----
START TRANSACTION;

UPDATE customer SET first_name = "MARY"
WHERE customer_id = 1;

SELECT * FROM customer LIMIT 5;

COMMIT;

ROLLBACK;

DESC customer;

CREATE VIEW ActorInfo AS
SELECT first_name, last_name
FROM actor
WHERE actor_id < 100;

CREATE OR REPLACE VIEW ActorInfo AS
SELECT first_name, last_name
FROM actor
WHERE actor_id < 100;

SELECT * FROM actor LIMIT 5;

SELECT * FROM ActorInfo;

SHOW FULL TABLES FROM sakila;

SHOW FULL TABLES FROM sakila
WHERE Table_type = "VIEW";

DROP VIEW Actor_Info;

DROP VIEW myview;

SELECT * FROM customer LIMIT 5;

CREATE OR REPLACE VIEW myview AS
SELECT * FROM customer
WHERE customer_id = 1;

SELECT * FROM myview;

UPDATE customer SET first_name = "PARK"
WHERE customer_id = 1;

SELECT * FROM customer LIMIT 5;

UPDATE myview SET first_name = "MARY"
WHERE customer_id = 1;


SELECT * FROM inventory LIMIT 5;

# 1) WITH 절을 통해서 별도의 테이블을 먼저 선언
WITH FilmInventory AS (
	SELECT DISTINCT film_id FROM inventory
)
SELECT
	F.film_id, F.title
FROM film F
JOIN FilmInventory FI ON FI.film_id = F.film_id;

# 2) 서브쿼리 구문을 통해서 테이블을 별도로 선언
SELECT
	F.film_id, F.title
FROM film F
JOIN (
	SELECT
		DISTINCT I.film_id 
    FROM inventory I
) FI ON FI.film_id = F.film_id;

SELECT
	MAX(rental_rate),
    AVG(rental_rate),
    MIN(rental_rate)
FROM film LIMIT 5;
# 데이터는 낱개로 펼쳐져있을 때, 밀집도를 분석하는데 유리
# 데이터는 군집화가 되어있을 때, 유형을 파악하는데 유리

SELECT title,
	CASE
		WHEN rental_rate < 1 THEN "Cheap"
        WHEN rental_rate BETWEEN 1 AND 3 THEN "Moderate"
        ELSE "Expensive"
	END AS PriceCategory
FROM film;

SELECT
	CASE
		WHEN rental_rate < 1 THEN "Cheap"
        WHEN rental_rate BETWEEN 1 AND 3 THEN "Moderate"
        ELSE "Expensive"
	END AS PriceCategory,
    COUNT(*)
FROM film
GROUP BY PriceCategory;

SELECT * FROM customer LIMIT 5; # customer_id
SELECT * FROM rental LIMIT 5; # customer_id, inventory_id
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id
SELECT * FROM film LIMIT 5; # film_id

SELECT
	C.customer_id,
    CONCAT(C.first_name, " ", C.last_name) customer_name,
    GROUP_CONCAT(F.title ORDER BY F.title ASC SEPARATOR " / ") rented_movies
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
GROUP BY C.customer_id;

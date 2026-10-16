/*
윈도우 함수 = Window Function
Window = 창문
Function = 기능
> 쿼리문을 작성해서 어떤 기능을 구현하려고 하는데,
마치 창문과 같은 기능을 구현하고 싶어서 사용함!!
> 어떤 공간 // 해당 공간 내부에 독립적인 작은 공간을 새롭게 만들어서
> 독립적인 공간을 들여다볼 수 있도록해놓은 설치 도구

예를 들어서 SUM() : 첫번째행부터 마지막번째행까지 모두 다 잡아서
합계를 계산

순위가 1 ~ 10등까지만 선별해서 SUM()
11 ~ 20등까지 선별해서 SUM()
*/

USE sakila;

SELECT * FROM film LIMIT 5;

SELECT
	title, length,
    RANK() OVER (ORDER BY length DESC) ranking,
    DENSE_RANK() OVER (ORDER BY length DESC) dense_ranking,
    ROW_NUMBER() OVER (ORDER BY length DESC) row_numbers
FROM film
ORDER BY length DESC; # ASC

SELECT * FROM customer LIMIT 5; # customer_id
SELECT * FROM payment LIMIT 5; # customer_id

SELECT
	C.customer_id,
    CONCAT(C.first_name, " ", C.last_name) customer_name,
    SUM(P.amount) total_amount,
    RANK() OVER (ORDER BY SUM(P.amount) DESC) ranking,
    DENSE_RANK() OVER (ORDER BY SUM(P.amount) DESC) dense_ranking,
    ROW_NUMBER() OVER (ORDER BY SUM(P.amount) DESC) row_numbers
FROM customer C
JOIN payment P ON P.customer_id = C.customer_id
GROUP BY C.customer_id
ORDER BY total_amount DESC;

SELECT * FROM rental LIMIT 5;

SELECT
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_rentals
FROM rental;

SELECT
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_rentals
FROM rental;

SELECT
	customer_id,
    rental_date,
     COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_rentals_01,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_rentals_02,
     COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) cumulative_rentals_03              
FROM rental;

SELECT * FROM payment LIMIT 5; # rental_id
SELECT * FROM rental LIMIT 5; # rental_id

SELECT
	R.customer_id,
    R.rental_date,
	P.amount,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount01,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_payment_amount02,
    AVG(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount03                 
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
ORDER BY R.customer_id;

SELECT
	R.customer_id,
    R.rental_date,
	P.amount,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY DATE(rental_date)
						RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount01,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY DATE(rental_date)
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount02                    
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
ORDER BY R.customer_id;

SELECT * FROM payment LIMIT 5; # rental_id
SELECT * FROM rental LIMIT 5; # rental_id, inventory_id
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id

SELECT
	I.film_id,
	P.amount,
    P.payment_date,
    SUM(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_revenue01,
	SUM(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_payment_revenue02,
	COUNT(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) cumulative_payment_revenue03,
	AVG(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_revenue04
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
JOIN inventory I ON I.inventory_id = R.inventory_id;











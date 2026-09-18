# 8) HAVING 절
# GROUP BY를 통해서 그룹의 대상이 된 요소의 조건을 따지고자 할 때
# 우리는 그동안 조건절 -> WHERE

USE sakila;

SELECT * FROM film LIMIT 10;

SELECT rating, COUNT(*) rating_count
FROM film
WHERE COUNT(*) >= 200
GROUP BY rating;

SELECT rating, COUNT(*) rating_count
FROM film
WHERE rental_rate >= 4.99
GROUP BY rating;
# WHERE 조건절은 반드시 그룹이 안된 대상만 활용!

SELECT rating, COUNT(*) rating_count
FROM film
GROUP BY rating
HAVING COUNT(*) >= 200;
# HAVING절은 그룹화가 된 대상으로 활용, 조건을 적용하고자 할 때,
# HAVING은 반드시 GROUP BY 뒤에 와야한다!

/*
작성순서
SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT

처리.실행순서
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
*/



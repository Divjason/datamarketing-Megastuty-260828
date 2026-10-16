# 1. 카테고리 테이블에서 코메디, 스포츠, 패밀리 카테고리의
# 카테고리 아이디를 카테고리명과 함께 조회해주세요.

SELECT * FROM category LIMIT 5;

SELECT category_id, name
FROM category
WHERE
	name = "Comedy" OR
    name = "Sports" OR
    name = "Family";
    
SELECT
	category_id, name
FROM category
WHERE name IN ("Comedy", "Sports", "Family");

/*
2. 카테고리가 코메디인 영화 갯수를 조회해주세요.
*/

SELECT * FROM category LIMIT 5;
SELECT * FROM film_category LIMIT 5;

SELECT
	C.name,
	COUNT(*) comedy_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
WHERE C.name = "Comedy";


/*
3. 카테고리에 포함되는 각각의 영화 갯수가 70이상인 카테고리명을 출력.
*/

SELECT * FROM category; # 16개의 카테고리 목록 존재
SELECT * FROM film_category LIMIT 5;

SELECT
	C.name,
    COUNT(*) category_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
GROUP BY C.category_id
HAVING category_count >= 70;

/*
4. 각 카테고리에 포함된 영화들의 렌탈 횟수 & 카테고리명 출력.
영화들은 특정 카테고리를 반드시 포함
해당 카테고리를 포함하고 있는 영화들을 찾아서 해당 영화들이 몇 번 렌탈 조회
해당 카테고리명 출력
*/

SELECT * FROM category LIMIT 5; # category_id
SELECT * FROM film_category LIMIT 5; # category_id, film_id
SELECT * FROM inventory LIMIT 5; # film_id, inventory_id
SELECT * FROM rental LIMIT 5; # inventory_id

SELECT
	C.name,
    COUNT(*) cateory_rental_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
JOIN inventory I ON I.film_id = F.film_id
JOIN rental R ON R.inventory_id = I.inventory_id
GROUP BY C.category_id;

/*
5. address 테이블에는 address_id가 존재하지만,
customer 테이블에는 address_id가 존재하지 않는 데이터 갯수를 출력해주세요!
*/

SELECT * FROM address LIMIT 5; # address_id
SELECT * FROM customer LIMIT 5; # address_id

SELECT COUNT(*) customer_only
FROM address A
LEFT OUTER JOIN customer C ON C.address_id = A.address_id
WHERE C.customer_id IS NULL;

SELECT COUNT(*) customer_only
FROM customer C
RIGHT OUTER JOIN address A ON C.address_id = A.address_id
WHERE C.customer_id IS NULL;

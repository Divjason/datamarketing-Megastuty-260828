USE bestproducts;

SHOW TABLES;

DESC items; # 6개 컬럼
-- item_code, title, ori_price, dis_price,
-- discount_percent, provider

DESC ranking; # 5개 컬럼
-- num, main_category, sub_category, item_ranking, item_code

SELECT item_code FROM items LIMIT 5;
SELECT item_code FROM ranking LIMIT 5;

SELECT title
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "ALL";

-- SELECT *
-- FROM items I
-- INNER JOIN ranking R USING(item_code);

SELECT
	I.provider,
    COUNT(*) provider_count
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "ALL"
GROUP BY I.provider
ORDER BY provider_count DESC
LIMIT 5;

# 메인 카테고리가 "패션의류"인 판매자 중 판매하고 있는 상품갯수가 5개 이상인
# 판매자만 조회해주세요. 단, 상위 5위안에 들어오는 판매자만 조회하세요.

SELECT
	I.provider,
    COUNT(*) provider_count
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "패션의류"
GROUP BY I.provider
HAVING provider_count >= 5
ORDER BY provider_count DESC
LIMIT 5;

# 메인카테고리가 "화장품/헤어"인 조건 하에
# 조회된 데이터 중 최대 할인 가격, 최소 할인 가격, 평균 할인 가격만 조회!
# AVG(), MAX(), MIN(), dis_price
# 위 값을 조회할 때, 소수점 2번째까지만 조회할 수 있도록해주세요
# ROUND()

SELECT
	ROUND(AVG(dis_price), 2),
    MAX(dis_price),
    MIN(dis_price)
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "화장품/헤어";

USE sakila;
SHOW TABLES; #customer, address
SELECT * FROM customer LIMIT 5;
-- customer_id, store_id, first, last_name, email, address_id
SELECT * FROM address LIMIT 5; # address_id

SELECT *
FROM customer C
LEFT OUTER JOIN address A
ON C.address_id = A.address_id
WHERE A.district IS NULL;

SELECT *
FROM customer C
RIGHT OUTER JOIN address A
ON C.address_id = A.address_id
WHERE C.customer_id IS NULL;
# customer > address
# 미용실, 매장 회원가입 -> 필수, 비필수







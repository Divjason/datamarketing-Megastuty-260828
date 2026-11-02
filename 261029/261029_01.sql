USE wconcept_db_261001;

SHOW TABLES;

SELECT * FROM products LIMIT 5;

DESC products;

SELECT * FROM brands LIMIT 5;

SELECT * FROM brands;

DESC brands;

USE api_db;

SELECT * FROM api_products LIMIT 5;

UPDATE brands
SET brand_id = 90
WHERE brand_id = 91;

ALTER TABLE brands AUTO_INCREMENT = 91;

SHOW TABLE STATUS LIKE 'brands';

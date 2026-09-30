CREATE DATABASE IF NOT EXISTS davelee;

USE davelee;

SHOW TABLES;

DESC teddyproducts;

SELECT * FROM teddyproducts;

SELECT
	category,
    COUNT(*) category_count
FROM teddyproducts
GROUP BY category;

SELECT * FROM teddyproducts
WHERE category = "행거도어";
# bestproducts > Gmarket에서 베스트 랭킹 상품을 크롤링 > sql DB 저장

DESC items; #item_code
DESC ranking; #item_code

SELECT * FROM items LIMIT 10;
SELECT * FROM ranking LIMIT 10;
SELECT COUNT(*) FROM ranking; # 11902

SELECT *
FROM items I
JOIN ranking R ON R.item_code = I.item_code;

# 마케터의 입장
# Gmarket 마케터 | MD
# 쇼핑몰 매출 = KPI
# 잘되고 있는 것을 더 잘되게 하자!
# 11000 등 이내에 최대한 많은 상품을 랭크시켜놓은 업체(바이어)잘 관리!!

# 100개 이상의 상품을 랭크시켜놓은 판매업체만 조회!
SELECT
	provider,
    COUNT(*) provider_count
FROM items
-- WHERE provider != ""
GROUP BY provider
HAVING provider_count >= 100 AND provider != "" 
ORDER BY provider_count DESC;





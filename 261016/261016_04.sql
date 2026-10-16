/*
캐나다 고객에게 CRM 마케팅의 일환으로서
이메일 마케팅 캠페인을 진행하고자 합니다.
캐나다 고객의 이름과 이메일주소 리스트를 출력해주세요.
*/

SELECT * FROM country
WHERE country = "Canada";

SELECT
	CONCAT(C.first_name, " ", C.last_name) customer_name,
    C.email
FROM customer C
JOIN address A ON A.address_id = C.address_id
JOIN city CI ON CI.city_id = A.city_id
JOIN country CO ON CO.country_id = CI.country_id
WHERE CO.country = "Canada";

/*
여러분들은 현재 넷플릭스의 그로스 마케터 입니다.
최근 패밀리 장르의 영화 매출이 성장추세에 있다는 것을 확인하였습니다. (크롤링)
그래서 이 분위기를 지속적으로 이어가고자 우리가 갖고 있는 패밀리 장르의
영화들을 확인한 후 마케팅 소재로 사용하고자 합니다.
따라서 현재 우리의 영화들 중 패밀리 = 가족 장르인 모든 영화 리스트를 조회해주세요.
*/

SELECT
	F.title,
    CA.name
FROM film F
JOIN film_category FC ON FC.film_id = F.film_id
JOIN category CA ON CA.category_id = FC.category_id
WHERE CA.name = "Family";






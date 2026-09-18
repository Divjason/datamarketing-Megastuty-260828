# ctrl + enter : 단문실행
# 윈도우 : "전체 드래그" + ctrl + shift + enter : 복문실행 (전체실행)
# 맥 : "전체 드래그" + command + shift + enter : 복문실행

# sakila + ecommerce : DML 문법 + TCL
# DDL, DCL -> 실습 한계
# 초급 + 중급 + 고급
# 수업 : SQLD : 2과목 : 1과목

USE sakila;
SHOW TABLES;

# EDA = Exploratory Data Analysis = 탐색적 데이터 분석
# EDA 데이터를 분석하는 기법 중 하나
# 데이터를 분석하려고 하는 담당자가 어떤 데이터를 부여받았을 때
# 해당 데이터가 어떤 목적으로 왜, 어떤 데이터를 가지고 있는지 등 파악
# ETL, LDA
# 현장에서는 누군가가 친절하게 해당 데이터를 하나씩 설명?

# ERD = Entity Relationship Diagram
# ERM = Entity Relationship Model

# 1) 데이터 조회 시, 행수 제한
SELECT * FROM film LIMIT 5;
# film 테이블 안에 값이 천만개
# 천만행을 조회해서 값을 찾아오겠다

# 별칭 = Alias

# 2) 전체 데이터가 몇개의 행으로 구성되어있는지 집계 = COUNT()
SELECT COUNT(*) AS film_count
FROM film;

# 3) AS, 특정 컬럼을 지칠할 때 사용하는 예약어 (생략 가능)
SELECT COUNT(*) film_count
FROM film;

# 4) DISTINCT : 별개의 // 한 컬럼 안에 중복해서 사용중인 값을 중복없이
# 1번만 출력하고자 할 때

USE sakila;

SHOW TABLES;

SELECT COUNT(*) FROM film; # 1000개의 행

SELECT * FROM film LIMIT 10; # rating 등급

SELECT DISTINCT rating FROM film; # 모든 영화는 5개 등급 중 하나

SELECT DISTINCT release_year FROM film; # 1000개의 영화는 모두 2006년 개봉작

# 5) 연산함수 : SUM(), AVG(), MAX(), MIN()
# 조회해야하는 값들이 수치화되어있는 정량데이터
# 결제 데이터 -> 수치화

SHOW TABLES;

SELECT COUNT(*) FROM customer; # 599명의 고객 데이터 존재
SELECT * FROM customer LIMIT 10;

SELECT COUNT(*) FROM payment; # 16044건의 결제 관련 데이터 존재
SELECT * FROM payment LIMIT 10;

SELECT
	SUM(amount) amount_sum,
    ROUND(AVG(amount), 2) amount_avg,
    MAX(amount) amount_max,
    MIN(amount) amount_min
FROM payment;

SELECT * FROM payment WHERE amount = 11.99;

# 6) GROUP BY
# 특정 컬럼값을 기준으로 그룹핑하는 방법
SELECT DISTINCT rating, COUNT(*) FROM film;
/*
Error Code: 1140.
In aggregated query without GROUP BY,
expression #1 of SELECT list contains nonaggregated column
'sakila.film.rating';
this is incompatible with sql_mode=only_full_group_by
*/

# 7) ORDER BY
# 특정 컬럼을 기준으로 정렬을 하고자 할 때 사용가능한 구문
# 정렬 : 오름차순 정렬 | 내림차순 정렬
# 아무런 정렬 명령어를 사용하지 않는다면, 기본적으로 오름차순 정렬 = default
# 일반적으로 내림차순 정렬 관련 명령어를 주로 사용한다
# 내림차순 : DESC // 오름차순 : ASC

SELECT
	rating,
    COUNT(*) rating_count
FROM film
GROUP BY rating
ORDER BY rating_count DESC;

# 입력순서
/*
SELECT
FROM
WHERE
GROUP BY
ORDER BY
LIMIT

FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY -> LIMIT

# film 테이블에서 release 연도가 2006 또는 2007이면서,
# 영화의 등급이 PG 또는 G 등급인 영화의 제목만 출력!!
*/

SELECT title FROM film
WHERE (release_year = 2006 OR release_year = 2007)
AND (rating = "PG" OR rating = "G");

SELECT COUNT(*) FROM film
WHERE (release_year = 2006 OR release_year = 2007)
AND (rating = "PG" OR rating = "G");

# film 테이블 참고
# 영화 등급별(rating) 영화갯수, 평균렌탈비용 조회
# 문법을 아는 것과 사용하는 것 다르다!!!
# 내가 이 문제를 해결하기 위해서 어떤 순서와 과정을 거칠 것인가?
# 논리적으로 설명
# 글로 작성

SELECT * FROM film LIMIT 10;

SELECT
	rating,
	COUNT(*) rating_count,
    ROUND(AVG(rental_rate), 2) rental_avg
FROM film
GROUP BY rating;
# ; 세미콜론은 반드시 쿼리구문이 종료되었다고 판단되는 지점 1군데에만 작성!

# Divide And Conquer
# 나누다 정복하다
# 복잡한 문제도 가장 작은 단위로 나눠서 정복하다 보면 반드시 문제는 풀린다







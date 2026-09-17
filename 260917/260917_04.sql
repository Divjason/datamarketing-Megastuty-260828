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

# 전체 데이터가 몇개의 행으로 구성되어있는지 집계 = COUNT()
SELECT COUNT(*) AS film_count
FROM film;

SELECT COUNT(*) film_count
FROM film;



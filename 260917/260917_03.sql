# DCL
# mysql은 현재 나의 mysql에 접근 가능한 사용자 목록을 보여줄 수 있는 내장객체
# user 속성을 사용하면 사용자 목록을 볼 수 있음
# host, user 컬럼 조회 가능

SELECT host, user FROM mysql.user;

# host : 권한
# user : 해당 권한을 부여받은 사용자의 name = id

# 현업, 실무자
# DB = Data = 회사 기밀 = 대외비
# 내부담당자 // 내부비담당자 => 조회.편집 권한 상이해야함
# DBA
# 로컬 vs 클라우드

CREATE USER "parksejin"@"localhost"
IDENTIFIED BY "1234";

SET PASSWORD FOR "parksejin"@"localhost" = "5678";

CREATE USER "megastudyglobal"@"%"
IDENTIFIED BY "1234";

DROP USER "parksejin@localhost";
DROP USER "davidGlobal";


# localhost : 내부에서만 = 내 컴퓨터 = 고유한 호스트 주소로만 접속이 가능한 제약요건
# host 네임이 127.0.0.1 = localhost인 저장소만 접속할 수 있게 허용

SHOW GRANTS FOR "megastudyglobal"@"%";
# *.* // 데이터베이스.테이블

GRANT SELECT ON sakila.actor TO "megastudyglobal"@"%";
GRANT SELECT ON sakila.payment TO "megastudyglobal"@"%";
GRANT SELECT, INSERT, UPDATE ON sakila.payment TO "megastudyglobal"@"%";
GRANT ALL ON *.* TO "megastudyglobal"@"%";
REVOKE ALL PRIVILEGES, GRANT OPTION FROM "megastudyglobal"@"%";
REVOKE SELECT ON sakila.payment FROM "megastudyglobal"@"%";




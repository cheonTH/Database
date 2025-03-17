-- DCL (데이터 제어어)
-- 데이터베이스에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 명령어

-- GRANT: 권한 부여
-- REVOKE: 권한 강탈

-- 계정 생성 방법
-- CREAT USER 계정명 IDENTIFIED BY 비밀번호

-- baby 계정이 사용할 저장소 생성
-- SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM DBA_TABLESPACES;

-- dba_tablespaces
-- Oracle 데이터베이스 내 모든 테이블 스페이스(논리적 저장소 단위)에 관한 정보를 제공하는 뷰
-- 테이블스페이스(논리적 저장소 단위) : 데이터베이스 객체(테이블, 인덱스 등)의 데이터를 저장하는 컨테이너 역할을 하며, 실제 데이터는 하나 이상의 데이터 파일에 저장
-- 테이블스페이스는 하나 이상의 데이터파일로 구성이 되고, 이 파일들을 물리적 저장소에 위치하며 실제 데이터를 저장
-- tablespace_name 테이블스페이스의 이름을 확인할 수 있음
-- status 테이블스페이스의 현재 상태를 나타냄
-- contents 테이블스페이스에 저장되는 데이터의 종류를 표시

--  SELECT FILE_NAME, TABLESPACE_NAME, AUTOEXTENSIBLE FROM DBA_DATA_FILES;
-- 오라클에서 사용되는 데이터 파일들의 세부정보를 제공하는 뷰
-- FILE_NAME 데이터 파일의 전체 경로와 파일명을 나타냄 실제 디스크 상에 존재하는 파일의 위치를 확인할 수 있음
-- TABLESPACE_NAME 해당 데이터파일이 소속된 테이블스페이스의 이름을 보여줌 이를 통해 논리적 저장단위와 물리적 파일 간의 관계를 파악할 수 있음
-- AUTOEXTENSIBLE 데이터 파일이 자동확장(AUTOEXTEND) 기능으로 설정되어 있는지 여부를 나타냄 
-- ㄴ>'YES' 또는 'NO'로 표기되며 'YES'인 경우 파일크기가 설정된 조건에 따라 자동으로 늘어남

-- 테이블스페이스의 생성
-- BABY라는 이름으로 200MB의 크기로 생성
-- 위치는 C:\ORACLEXE\APP\ORACLE\ORADATA\XE\ 폴더에 BABY.DBF로 생성
-- 데이터가 늘어나 테이블스페이스가 꽉찰 것을 대비해 5MB씩 자동으로 증가하는 옵션 추가
-- CREATE TABLESPACE 테이블스페이스명 DATAFILE '경로와 이름' SIZE 크기 AUTOEXTEND ON NEXT 크기 (MAXSIZE크기)

-- 계정 생성 권한주기
-- GRANT CREATE USER TO 대상;
-- SCOTT에 계정생성 권한주기
-- GRANT CREATE USER TO SCOTT;
-- 권한의 종류 
-- 1. 시스템 권한 : 데이터베이스 전체에 영향을 미치는 작업(사용자의 생성, 데이터베이스 구조 변경)
-- CREATE SESSION 데이터베이스에 접속할 수 있는 권한
-- CREATE TABLE 테이블을 생성할 수 있느 ㄴ권한
-- ALTER SYSTEM 시스템설정을 변경할 수 있는 권한
-- CREATE USER 사용자 계정을 생설할 수 있는 권한
-- 2. 객체 권한 : 특정 데이터베이스 객체(테이블, 뷰(가상의 테이블), 프로시저(사용자 정의 함수))에 대해 부여되는 권한
-- SELECT, INSERT, UPDATE, DELETE
-- EX) GRANT SELECT, INSERT, UPDATE ON 테이블 TO 대상;
-- 역할 : 한번에 여러 권한을 사용자에게 부여하거나 회수할 수 있도록 도움
-- CONNECT 기본적인 데이터 베이스 접속권한을 제공하는 역할
-- RESOURCE 테이블, 인덱스 등 객체를 생성할 수 있는 권한을 포함하는 역할
-- DBA 데이터베이스의 모든 관리 권한을 포함하는 최고 수준의 역할

-- 권한을 주거나 뺏는 것은 관리자 계정으로부터 해야함
-- BABY 계정의 기본 테이블 스페이스를 BABY로 지정하면서 무제한으로 사용을 할 것이다
-- ALTER USER BABY DEFAULT TABLESPACE BABY QUOTA UNLIMIT ON BABY;
-- QUOTA 사용자가 특정 테이블스페이스 내에서 사용할 수 있는 디스크 공간의 최대량을 지정하는데 사용


-- 인덱스(INDEX) 테이블에 저장된 데이터를 보다 빠르게 검색할 수 있도록 도와주는 자료구조
-- 장점: 
-- 빠른 검색: 인덱스를 사용하면 테이블 전체를 검색하지 않아도 되므로 데이터 검색 속도가 크게 향상됨
-- 효율적인 정렬: 이미 정렬된 형태로 인덱스가 저장되어 있어, 정렬 연산이 빠르게 수행됨
-- 단점
-- 추가 저장공간이 필요: 인덱스를 생성하면 별도의 저장공간이 필요
-- 데이터 수정비용 증가: INSERT, UPDATE, DELETE 작업시 인덱스도 함께 갱신이 되어야 하므로 성능이 저하될 수 있음

-- 언제 인덱스가 사용이 되는가?
-- WHERE절 : 쿼리에서 특정 조건을 만족하는 행을 찾을 때 조건에 사용된 컬럼에 인덱스가 있으면 DBMS가 전체 테이블을 스캔하는 대신 인데스를 통해 빠르게 해당 행의 위치를 찾아감

-- GROUP BY, ORDER BY 결과를 정렬 또는 그룹화 할 때도 인덱스가 사용됨

-- INDEX의 삭제
-- 조회 성능을 높이기 위해 만든 객체지만 저장공간을 많이 차지하며 DDL작업(INSERT, UPDATE, DELETE)시 부하가 많이 발생해 전체적인 데이터베이스 성능을 저하시킴
-- DBA는 주기적으로 INDEX를 검토하여 사용하지 않는 인덱스는 삭제하는 것이 데이터베이스 전체 성능을 향상시킬 수 있음
-- DROP INDEX 인덱스명;

-- INDEX를 REBUILD하기
-- INSERT, UPDATE, DELETE와 같은 작업이 발생하면 인덱스의 검색 속도를 저하시키고 전체 데이터베이스 성능에 영향을 미치므로 주기적으로 INDEX를 리빌딩하는 작업을 해줘야 함
-- ALTER INDEX 인덱스명 REBUILD;

-- 자동으로 만들어진 INDEX던, 수동으로 만든 INDEX던 조회할 때 사용이 되는거라면 잘 사용이 되고 있는지 확인을 해야할 필요가 있음
-- EXPLAIN PLAN FOR
-- ORACLE 데이터베이스에서 SQL쿼리가 실행될 때 어떤 경로로 수행되는지를 미리 확인할 수 있는 명령어
-- 주요 개념
-- 실행 계획(EXPLAIN PLAN)
-- SQL쿼리를 처리하기 위한 단계별 작업 순서를 나타냄.
-- 테이블 스캔, 인덱스 스캔, 조인 방식이 포함됨
-- 실제로 쿼리를 실행하지는 않고 쿼리의 실행 경로를 분석
-- 실행 계획을 통해 쿼리 성능 개선, 인덱스 활용 여부 병목 현상 등을 진단할 수 있음.
-- PLAN_TABLE
-- 실행 계획 정보는 기본적으로 PLAN_TABLE이라는 테이블에 저장됨
-- 이후 DBMS_XPLAN.DISPLAY함수를 이용하여 보기 쉽게 출력할 수 있음.

EXPLAIN PLAN FOR
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Smith';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

----------------------------------------------------------------------------------------------------------------------------------

SELECT FIRST_NAME,
	JOB_ID,
	SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
				FROM EMPLOYEES
				WHERE FIRST_NAME = 'Michael' AND JOB_ID = 'MK_MAN');

-- 사원이 150번인 사원의 급여와 같은 급여를 받는 사원들의 정보를 사번, 이름, 급여 순으로 출력
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY
				FROM EMPLOYEES
				WHERE EMPLOYEE_ID = 150);

-- 급여가 회사의 평균급여 이상인 사람들의 이름과 급여를 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY)
				FROM EMPLOYEES);

-- 사번이 111번인 사원과 직종이 같고, 사번이 159번인 사원의 급여보다 많이 받는 사원의 사번, 이름 직종 급여
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
				FROM EMPLOYEES
				WHERE EMPLOYEE_ID = 111)
	AND SALARY > (SELECT SALARY
				FROM EMPLOYEES
				WHERE EMPLOYEE_ID = 159);

-- 직종별 평균 급여가 BRUCE의  급여보다 큰 직종만 직종, 평균급여를 조회
SELECT JOB_ID,
		AVG(SALARY) AS AVG_SAL
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) > (SELECT SALARY
					FROM EMPLOYEES
					WHERE FIRST_NAME = 'Bruce');

SELECT *
FROM PLAYER;

-- PLAYER 테이블에서 TEML_ID가 'K01' 인 선수중 POSITION이 'GK'인 선수 찾기
SELECT *
FROM (SELECT *
	FROM PLAYER 
	WHERE TEAM_ID = 'K01')
WHERE "POSITION" = 'GK';

-- 내부 서브쿼리애서 TEAM_ID가 'K01'인 행을 먼저 선택
-- 그결과를 기반으로 외부 쿼리에서 'POSITION'이 'GK'이인 행을 추가로 필터링

-- FROM(INLINE VIEW): 쿼리문으로 출력되는 결과를 테이블처럼 사용
-- SELECT절(SCALAR): 하나의 컬럼처럼 사용되는 서브쿼리
-- WHERE절(SUB QUERY): 하나의 변수처럼 사용
	-- ㄴ>단일행 서브쿼리: 쿼리 결과가 단일행만 반환하는 서브쿼리
	-- ㄴ>다중행 서브쿼리: 쿼리 결과가 다중행을 리턴하는 서브쿼리
	-- ㄴ>다중 컬럼 서브쿼리: 쿼리 결과가 다중컬럼을 반환하는 서브쿼리 

-- PLAYER테이블에서 전체 평균키와 포지션별 평균키 구하기
SELECT "POSITION",
		ROUND(AVG(HEIGHT),1) AS "포지션별 평균키",
		(SELECT ROUND(AVG(HEIGHT),1)
			FROM PLAYER) AS "전체 평균키"
FROM PLAYER
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION";


-------------------------------------------------------------------------------------------------
-- PLAYER 테이블에서 NICKNAME 이 NULL인 선수들은 정태민 선수의 닉네임으로 바꾸기
UPDATE PLAYER SET NICKNAME = (SELECT NICKNAME
			 				FROM PLAYER 
			 				WHERE PLAYER_NAME = '정태민')
WHERE NICKNAME IS NULL;

SELECT * 
FROM PLAYER;

--EMPLOYEES 테이블에서 평균 급여보다 급여가 낮은 사원들의 급여를 10% 인상
UPDATE EMPLOYEES SET SALARY = (SALARY + (SALARY * (10/100))) 
WHERE SALARY < (SELECT AVG(SALARY)
				FROM EMPLOYEES);

SELECT *
FROM EMPLOYEES;

-- PLAY 테이블에서 평균키보다 큰 선수들을 삭제
DELETE FROM PLAYER
WHERE HEIGHT > (SELECT AVG(HEIGHT)
				FROM PLAYER);

SELECT PLAYER_NAME,
		HEIGHT
FROM PLAYER;

-- CONCATENATION(연결): ||
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME
FROM EMPLOYEES;
-- OO의 급여는 OO이다
SELECT FIRST_NAME||'의 급여는 '||SALARY||'이다' AS SAL
FROM EMPLOYEES;

-- 별칭(ALIAS)
-- SELECT절 : 1. AS 별칭 // 2. 컬럼명 뒤에 한칸 띄우고 작성
-- FROM절 : 테이블명 뒤에 한칸 띄우고 작성
-- 별칭의 특징 : 테이블에 별칭을 줘서 컬럼을 단순, 명확히 할 수 있음
-- 현재의 SELECT 문장에서만 유효
-- 테이블 별칭은 길이가 30자 까지 가능하나 짧을수록 좋음
-- FROM절에 테이블 별칭 설정시 해당 테이블 별칭은 SELECT문장에서 테이블 이름대신 사용할 수 있음
SELECT COUNT(SALARY) AS 개수,
		MAX(SALARY) AS 최대값,
		MIN(SALARY) AS 최소값,
		SUM(SALARY) AS 합계,
		AVG(SALARY) AS 평균
FROM EMPLOYEES;

-- 두개 이상의 테이블에서 각각의 컬럼을 조회하려고 할때 어떤 테이블에서 온 컬럼인지 확실하게 해야할 때가 있음
SELECT EMP.EMPLOYEE_ID,
		EMP.DEPARTMENT_ID ,
		DEPT.DEPARTMENT_ID ,
		DEPT.DEPARTMENT_NAME
FROM EMPLOYEES EMP,
	DEPARTMENTS DEPT;

-- JOIN
-- 사원 테이블에 부서명이 없음
-- 부서 테이블과 DEPARTMENT_ID로 연결
SELECT E.FIRST_NAME,
		D.DEPARTMENT_ID,
		D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 부서 테이블과 지역(LOCATIONS)로 부터 부서명과 CITY 조회하기
SELECT D.DEPARTMENT_NAME,
		L.CITY
FROM LOCATIONS L JOIN DEPARTMENTS D
ON D.LOCATION_ID = L.LOCATION_ID;

-- 지역(LOCATIONS), 나라(COUNTRIES)를 조회하여 도시명과 국가명을 조회하시오
SELECT L.CITY,
		C.COUNTRY_NAME
FROM LOCATIONS L JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID;

-- 사원 테이블과 JOBS 테이블을 이용하여 이름, 성, 직종번호, 직종 이름을 조회
SELECT E.FIRST_NAME || ' ' ||E.LAST_NAME AS NAME,
		J.JOB_ID,
		J.JOB_TITLE
FROM EMPLOYEES E JOIN JOBS J
ON E.JOB_ID = J.JOB_ID;

-- 사원 부서 지역 테이블로부터
-- 이름 이메일, 부서번호 부서명 지역 번호 도시명을 조회 도시가 'Seattle'인 경우
SELECT E.FIRST_NAME , E.EMAIL, D.DEPARTMENT_ID , D.DEPARTMENT_NAME, D.LOCATION_ID, L.CITY 
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
AND L.CITY = 'Seattle';

-- 1-1 SEL INNER JOIN
-- 하나의 테이블 내에서 다른 컬럼을 참조하기 위해 사용하는 '자기 자신과의 조인' 방법
-- 이를 통해 데이터베이스에서 한 테이블 내의 값을 다른 값과 연결할 수 있음.

-- SELECT A.컬럼1, B.컬럼1
-- FROM 테이블A A JOIN 테이블A B
-- ON A.열 = B.열;
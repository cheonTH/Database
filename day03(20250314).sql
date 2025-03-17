INSERT INTO PRODUCT_2  (NO, NAME, PRICE, P_DATE)
VALUES(1000, '컴퓨터', 100 , '2021-04-15');

INSERT INTO PRODUCT_2  (NO, NAME, PRICE, P_DATE)
VALUES(1002, '냉장고', 200 , '2021-03-29');


INSERT INTO PRODUCT_2  (NO, NAME, PRICE, P_DATE)
VALUES(1003, '에어컨', 300 , '2020-12-15');

INSERT INTO PRODUCT_2  (NO, NAME, PRICE, P_DATE)
VALUES(1004, '오디오', 20 , '2020-12-15');

INSERT INTO PRODUCT_2  (NO, NAME, PRICE, P_DATE)
VALUES(1005, '세탁기', 100 , '2021-04-15');

SELECT *
FROM  PRODUCT_2;

UPDATE PRODUCT_2 
SET PRICE = PRICE +20
WHERE "NO" = 1000;

DELETE FROM PRODUCT_2
WHERE NAME = '세탁기';

SELECT NAME, PRICE
FROM PRODUCT_2
ORDER BY NAME ASC;

-- 사원테이블에서 급여를 많이 받는 순 사번, 이름 ,급여 입사일 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE
FROM EMPLOYEES
ORDER BY SALARY DESC;

--부서번호가 빠른 순 부서 번호가 같다면 직종이 빠른 순 직종 까지 같다면 급여를 많이 받는 순 사번 이름 부서번호 직종 급여순
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		DEPARTMENT_ID,
		JOB_ID,
		SALARY
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID, JOB_ID, SALARY DESC; 

-- 급여 15000이상인 사원 사번, 이름 ,급여 입사일 입사가 빠른 순
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		SALARY,
		HIRE_DATE
FROM EMPLOYEES
WHERE SALARY >= 15000
ORDER BY HIRE_DATE;

-- ASCII('값') 지정된 문자의 아스키코드 값을 반환
SELECT ASCII('A') FROM DUAL;

-- CHR(숫자) 지정된 숫자와 일치하는 ASCII코드를 반환
SELECT CHR(65) FROM DUAL;

-- RPAD(데이터, 고정길이, 문자) 고정길이 안에 데이터를 왼쪽으로 몰아서 출력하고, 나머지 공간은 문자로 채움
SELECT RPAD(DEPARTMENT_NAME,10,'*')FROM DEPARTMENTS;

-- LPAD(데이터, 길이, 문자)

--TRIM() 앞뒤 문자열 공백을 제거
SELECT TRIM('     HELLO      ') FROM DUAL;

-- 컬럼이나 대상 문자열에서 특정문자가 첫번째나 마지막 위치에 있으면 해당 특정문자를 잘라낸 후 남은 문자열만 반환
SELECT TRIM('Z' FROM 'ZZZHELLOZZZ') FROM DUAL;

--RTRIM() 문자열 오른쪽 공백 문자 제거
SELECT RTRIM('HELLO    ') FROM DUAL;
--LTRIM() 문자열 왼쪽 공백 문자 제거
SELECT LTRIM('    HELLO') FROM DUAL;

--INSTR('문자열','문자') 특정 문자의 위치를 반환 DB는 1부터 시작
SELECT INSTR('HELLO', 'L') FROM DUAL;
-- 첫번째 위치부터 2번째 L을 찾는 방법
SELECT INSTR('HELLO', 'L' , 1, 2) FROM DUAL; 

-- 찾는 문자열이 없으면 0을 반환
SELECT INSTR('HELLO','Z') FROM DUAL;

-- INITCAP(데이터) 첫문자를 대문자로 변환하는 함수, 공백, / 를 구분자로 인식
SELECT INITCAP('hello') FROM DUAL;
SELECT INITCAP('good morning') FROM DUAL;
SELECT INITCAP('good/morning') FROM DUAL;

--LENGTH() 문자열의 길이를 반환
SELECT LENGTH('JOHN') FROM DUAL;

--CONCAT() 주어진 두 문자열을 연결
SELECT CONCAT('REPUBLIC OF', ' KOREA') FROM DUAL;

--SUBSTR(데이터,길이) 문자열의 시작위치부터 길이만큼 자른후 반환
SELECT SUBSTR('HELLO ORACLE', 2) CASE1,
	SUBSTR('HELLO ORACLE', 7,5) CASE2
FROM DUAL;

--LOWER() 문자열을 모두 소문자로 변환
SELECT LOWER('HELLO ORACLE') FROM DUAL;
--UPPER() 문자열을 모두 대문자로 변환
SELECT UPPER('hello oracle') FROM DUAL;

--REPLACE() 문자열중에서 특정문자를 다른문자로 치환
SELECT REPLACE('HELLO WORLD', 'WORLD', 'SQL') FROM DUAL;

-- 부서번호가 50번인 사원번호들의 이름을 출력하되 이름중 EL을 모두  **로 대체 조회
SELECT REPLACE(FIRST_NAME, 'el', '**') AS NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
ORDER BY NAME;

-- 문자열 '     ORACLE SQL PROGRAMMING    ' 에서 양쪽 공백을 제거한후 모든 문자를 대문자로 변환하고 최종 문자열의 길이를 반환
SELECT LENGTH(TRIM(UPPER('    Oracle SQL Programming   '))) 
FROM DUAL;

-- ' HELLO, ORACLE SQL!  ' 문자열에서 양쪽 공백 제거 앞글자 5글자, 마지막 5글자 추출, 각각 대문자로 변환 두 결과를 콜론:으로 연결
SELECT UPPER(CONCAT(CONCAT(SUBSTR(TRIM(' Hello, Oracle SQL!  '),1,5), ' : '),
		SUBSTR(TRIM(' Hello, Oracle SQL!  '),14))) AS "HELLO : SQL!"
FROM DUAL;

-- DATA 왼쪽에 -문자를 채워 총 10자리 문자열로 만들고 BASE를 오른쪽에 *문자를 채워 총 10자리 문자열로 만든 후, 이 두 결과를 반환하는 SQL문

SELECT CONCAT(LPAD('Data', 10 , '-'), RPAD('Base', 10, '*')) AS "-DATABASE*"
FROM DUAL;



-----------------------------------------------------------------------------------------
--숫자 관련 함수
--ABS() 절대값 반환
SELECT - 10 AS NUM, ABS(-10) AS "ABS_NUM"
FROM DUAL;

--ROUND(숫자, 자리수) 특정 자리수에서 반올림하여 반환
SELECT ROUND(1234.567, 1), ROUND(1234.567, -1), ROUND(1234.567)
FROM DUAL;

--FLOOR() 주어진 숫자보다 작거나 같은 수 중 최대값을 반환
SELECT FLOOR(2), FLOOR(2.1) 
FROM DUAL;

--TRUNC() 특정 자리수를 버리고 반환
SELECT TRUNC(1234.567, 1),TRUNC(1234.567, -1),TRUNC(1234.567)
FROM DUAL;

--SIGN() 주어진 값의 양수, 음수, 0인지 여부를 판단 음수는 -1 양수는 1 0은 0을 반환 NULL은 NULL을 반환
SELECT SIGN(10), SIGN(-10), SIGN(0),SIGN(NULL)
FROM DUAL;

--CEIL() 주어진 숫자보다 크거나 같은 정수중 최소값을 반환
SELECT CEIL(2),CEIL(2.1), CEIL(5.1)
FROM DUAL;

--MOD() 나누기 후 나머지를 반환
SELECT MOD(1,3), MOD(2,3), MOD(3,3), MOD(4,3), MOD(0,3)
FROM DUAL;

--POWER() 주어진 숫자의 지정된 수 만큼 제곱값을 반환
SELECT POWER(2,1), POWER(2,2), POWER(2,3), POWER(2,0)
FROM DUAL;

-- 이름이 6글자 이상인 사원의 사번과 이름 급여 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES 
WHERE LENGTH(FIRST_NAME) >= 6
ORDER BY FIRST_NAME;

-- 사원테이블에서 사원번호가 홀수이면 1 짝수이면 0을 출력
SELECT EMPLOYEE_ID, FIRST_NAME,
		MOD(EMPLOYEE_ID, 2) AS EMP
FROM EMPLOYEES;

-- 사원번호가 짝수인 사람들의 사번과 이름
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID, 2) = 0
ORDER BY EMPLOYEE_ID;

-- 사원테이블에서 이름 급여 급여의 1000당 ■ 개수로 채워서 조회

SELECT FIRST_NAME, SALARY, 
		(RPAD('*',(SALARY/1000),'*'))  AS SAL_S
FROM EMPLOYEES
ORDER BY SALARY;


--------------------------------------------------------------
--날짜 함수
--ADD_MONTHS() 특정날짜에 개월수를 더해줌
SELECT SYSDATE , ADD_MONTHS(SYSDATE,2)
FROM DUAL;

--MONTHS_BETWEEN(최근날짜, 오래된 날짜) 두 날짜 사이의 개월수
--모든 사원들이 입사일로 부터 몇개월이 경과했는지
SELECT SYSDATE, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEES;

--NEXT_DAY() 주어진 일자가 다음에 나타나는 지정요일의 날짜를 반환
--1: 일요일 ~ 7:토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE , '일요일')
FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE-7 , '일요일') --저번주 일요일
FROM DUAL;

--LAST_DAY() 
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;


-----------------------------------------------------
--형변환 함수
--TO_CHAR(날짜, 포맷)
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD'), TO_CHAR(SYSDATE, 'YYYY-MM-DD (DAY)'),TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS')
FROM DUAL;
--날짜  FORMATTING 형식
--SCC, CC : 세기
--YYYY, YY : 연도
--MM : 월
--DD : 일
--DAY : 요일
--MON: 월명(JAN, FEB..)
--HH, HH24 : 시간
--MI : 분
--SS : 초 

--TO_NUMBER() 잘 안쓰임 // 숫자모양으로 되어있는 문자열은 오라클이 암묵적으로 숫자취급을 함
-- 0: 숫자, 공백시 0으로 채움
-- 9: 숫자
-- ,: 쉼표 표기
-- L: 지역화폐 단위 표시
SELECT TO_CHAR(1234567, '9,999,999'),
TO_CHAR(1234567, 'L9,999,999')
FROM DUAL;

-- TO_DATE() 문자열을 형식에 맞춰 날짜형으로 변환
SELECT TO_DATE('2025.03.14'),
		TO_DATE('03.14.2055', 'MM.DD.YYYY'),
		TO_DATE('2025.03', 'YYYY.MM'), --일(DAY)를 입력하지 않으면 1일로 나옴
		TO_DATE('11', 'DD') --일(DAY)만 쓰면 해당월의 일(DAY)만 나옴
FROM DUAL;



-----------------------------------------------------------------
-- NULL 처리함수
-- NULL값을 다른 값으로 변경

--NVL(컬럼, 치환할 값) NULL 일때 치환할 값
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0)
FROM EMPLOYEES;

--NVL2(컬럼명, NULL이 아닐때 치환할 값, NULL 일때 치환할 값) NULL일때 치환할 값과 NULL이 아닐때 치환할 값을 지정
SELECT FIRST_NAME, NVL2(COMMISSION_PCT, 1 , 0)
FROM EMPLOYEES;

-----------------------------------------------------------------------
--순위함수
--RANK() OVER(ORDER BY 컬럼) 그룹내 순위를 계산하여 NUMBER타입으로 순위를 반환 중복 순위 계산
SELECT FIRST_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS RANK_SAL
FROM EMPLOYEES;

--DENSE_RANK() 중복 순위를 계산하지 않음
SELECT FIRST_NAME, SALARY, DENSE_RANK() OVER(ORDER BY EMPLOYEES.SALARY  DESC) AS RANK_SAL
FROM EMPLOYEES;

--------------------------------------------------------------------------
-- 집계함수: 여러 행들에 대한 연산의 결과를 하나의 행으로 반환

-- COUNT() 행의 개수를 카운트 // NULL값은 계산하지 않음
SELECT COUNT(*)
FROM EMPLOYEES;

SELECT COUNT(DISTINCT DEPARTMENT_ID) AS DEPT_ID  --DISTINCT: 중복되는 값을 제거
FROM EMPLOYEES;

--MIN() 최소값
SELECT MIN(SALARY)
FROM EMPLOYEES;

--MAX() 최대값
SELECT MAX(SALARY)
FROM EMPLOYEES;

--SUM() 총합
SELECT SUM(SALARY)
FROM EMPLOYEES;

--AVG() 평균
SELECT AVG(SALARY)
FROM EMPLOYEES;

-----집계함수는 -->일반적인 컬럼들이랑 일반적인 방법으로는 같이 사용할 수 없음 EX)이름과 급여를 호출할 수 없음


--그룹화 (GROUP BY)
--특정 테이블에서 소그룹을 만들어 결과를 분산시켜 얻고자하는 것을 더음

SELECT DEPARTMENT_ID,
	AVG(SALARY) AS AVG_SAL,
	SUM(SALARY) AS SUM_SAL
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 부서별 직종별로 그룹을 나눠 인원수를 출력하되 부서번호가 낮은 순으로 정렬
SELECT DEPARTMENT_ID,
		JOB_ID,
		COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- 사원테이블 80번 부서에 속하는 사원들의 급여의 평균을 소수점 두자리까지 반올림하여 출력
SELECT DEPARTMENT_ID,
	ROUND(AVG(SALARY),2) AS AVG_SAL
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID = 80;

-- 각 직종별 인원수
SELECT JOB_ID,
	COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID;

--각 직종별 급여의 합
SELECT JOB_ID,
		SUM(SALARY) AS SUM_SAL
FROM EMPLOYEES
GROUP BY JOB_ID;

--부서별로 가장 높은 급여 조회
SELECT DEPARTMENT_ID,
		FIRST_NAME,
		MAX(SALARY) AS MAX_SAL
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, FIRST_NAME
ORDER BY DEPARTMENT_ID;

--HAVING절 GROUP BY로 집계된 값 중 조건을 추가하는 것

--WHERE절과 HAVING절의 차이
--HAVING절은  GROUP BY와 함께 사용해야 하며 집계함수를 사용하여 조건절을 작성하거나 
--GROUP BY 컬럼만 조건절에 사용할 수 있음

--각 부서의 급여의 최대값, 최소값, 인원수를 조회하되 급여의 최대값이 8000이상인 결과만 조회
SELECT MAX(SALARY) AS MAX_SAL,
		MIN(SALARY) AS MIN_SAL,
		COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) >= 8000;

--각 부서별 인원수가 20명 이상인 부서의 정보를 부서 번호, 급여의 합, 급여의 평균, 인원수 순으로 출력
--급여의 평균은 소수점 둘째자리까지 반올림
SELECT DEPARTMENT_ID,
		SUM(SALARY) AS SUM_SAL,
		ROUND(AVG(SALARY),2) AS AVG_SAL,
		COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 20;


--부서별 직종별로 그룹화하여 부서번호 직종 인원수 순으로 조회, 직종이 MAN으로 끝나는 경우만 조회
SELECT DEPARTMENT_ID,
		JOB_ID,
		COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID, DEPARTMENT_ID
HAVING JOB_ID LIKE '%MAN';

--각 부서별 평균급여 소수점 한자리를 제외하고 버리기 평균급여 10000미만인 부서 부서번호 50이하
SELECT DEPARTMENT_ID,
	TRUNC(AVG(SALARY),1) AS AVG_SAL
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID 
HAVING AVG(SALARY) <10000 AND DEPARTMENT_ID <=50
ORDER BY DEPARTMENT_ID;

--그룹함수
CREATE TABLE 월별매출 (
    상품ID VARCHAR2(5),
    월 VARCHAR2(10),
    회사 VARCHAR2(10),
    매출액 INTEGER );
    
INSERT INTO  월별매출 VALUES ('P001', '2019.10', '삼성', 15000);
INSERT INTO  월별매출 VALUES ('P001', '2019.11', '삼성', 25000);
INSERT INTO  월별매출 VALUES ('P002', '2019.10', 'LG', 10000);
INSERT INTO  월별매출 VALUES ('P002', '2019.11', 'LG', 20000);
INSERT INTO  월별매출 VALUES ('P003', '2019.10', '애플', 15000);
INSERT INTO  월별매출 VALUES ('P003', '2019.11', '애플', 10000);

SELECT * FROM 월별매출;

--ROLLUP 계층적 그룹핑을 통해 점진적으로 소계와 총계를 계산
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY ROLLUP(상품ID, 월);

--CUBE(A, B) A,B 그룹핑/ A그룹핑 / B그룹핑 -> A소계, B소계/합계
--모든조합의 그룹핑 집합을 생성하여 모든 소계와 총계를 포함
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY CUBE(상품ID, 월);

--GROUPING SETS()
-- 사용자 정의 그룹핑 집합을 통해 원하는 조합만 선택적으로 집계할 수 있음
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY GROUPING SETS(상품ID, 월);
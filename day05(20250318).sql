-- CROSS INNER JOIN 
-- 두개 이상의 테이블에서 '모든 가능한 조합'을 만들어 결과를 반환하는 조인 방법
-- 이를 통해 두 개 이상의 테이블을 조합하여 새로운 테이블을 만들 수 있음
-- 두 테이블이 서로 연관이 없어도 조인이 가능
-- 단, 각 행의 모든 가능한 조합을 만들기 때문에 결과가 매우 큰 테이블이 될 수 있으므로 주위가 필요

CREATE TABLE 테이블A(
   A_id NUMBER,
   A_name varchar2(10)
);

CREATE TABLE 테이블B(
   B_id NUMBER,
   B_name varchar2(20)
);


INSERT INTO 테이블A values(1, 'John');
INSERT INTO 테이블A values(2, 'Jane');
INSERT INTO 테이블A values(3, 'Bob');

INSERT INTO 테이블B values(101, 'Apple');
INSERT INTO 테이블B values(102, 'Banana');

SELECT *
FROM 테이블A CROSS JOIN 테이블B;

-- OUTER JOIN
-- 두 테이블에서 '공톤된 값을 가지지 않는 행들'도 반환

-- LEFT OUTER JOIN
-- '왼쪽 테이블의 모든 행'과 '오른쪽 테이블과 왼쪽테이블이 공통적으로 가지는 값'을 반환
-- 교집합과 차집합의 연산 결과를 합친것과 같음
-- 만야 오른족 테이블에서 공통된 값을 가지고 있는 행이 없다면 NULL을 반환

--사원테이블과 부서 테이블의 LEFT OUTER JOIN을 이용하여 사원이 어느 부서에 있는지 조회
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 150;

SELECT *
FROM STADIUM s ;

SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM DEPARTMENTS D LEFT OUTER JOIN  EMPLOYEES E
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT *
FROM DEPARTMENTS;

-- RIGHT OUTER JOIN => LEFT OUTER JOIN과 반대
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- FULL OUTER JOIN
-- 두테이블에서 모든값을 반환
-- 서로 공통되지 않은 부분은 NULL로 반환
-- 합집합의 연산과 같음
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 부서번호, 사원명, 직업, 위치를 EMP와 DEPT테이블을 INNER JOIN
SELECT E.DEPTNO, E.ENAME, E.JOB, D.LOC
FROM EMP E INNER JOIN DEPT D
ON D.DEPTNO = E.DEPTNO;

--PLAYER 테이블, TEAM에서 송종국 선수가 속한 팀의 전화번호 조회
--TEAM ID, PLAYER_NAME, TEL
SELECT P.TEAM_ID, P.PLAYER_NAME, T.TEL
FROM PLAYER P INNER JOIN TEAM T
ON P.TEAM_ID = T.TEAM_ID AND P.PLAYER_NAME = '송종국';

-- JOBS테이블과 EMPLOYEES테이블에서 직종번호, 직종 이름, 이메일 ,이름과 성 연결 조회
SELECT J.JOB_ID, J.JOB_TITLE, E.EMAIL, E.FIRST_NAME||' '||E.LAST_NAME AS NAME
FROM JOBS J JOIN EMPLOYEES E
ON E.JOB_ID = J.JOB_ID;

-- 비등가 조인
-- 두 테이블을 결합할 때 부등호(>,<,>=,<=), BETWEEN, LIKE 등 다양한 비교 연산자들을 통해 조인 조건을 지정하는 방식
-- 특정 값이 일정 범위 내에 속하거나, 두 값 사이의 관계를 비교하여 행을 결합 할 때 유용
SELECT E.EMPNO, E.ENAME , S.GRADE, E.SAL
FROM SALGRADE s JOIN EMP E
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--USING() 중복되는 컬럼이 생길 시 맨 앞으로 출력하며 중복 컬럼을 한개만 출력
SELECT *
FROM EMP E JOIN DEPT D

-- DEPT 테이블의 LOC별 평균 SAL를 반올림한 값과 SAL의 총 합을 조회
SELECT D.DEPTNO, D.LOC, ROUND(AVG(E.SAL),1) AS AVG_SAL, SUM(E.SAL) AS SUM_SAL
FROM DEPT D LEFT OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO
GROUP BY D.DEPTNO, D.LOC
ORDER BY DEPTNO;

-- NATURAL JOIN 두 테이블간의 동일한 이름을 갖는 모든 컬럼들에 대해 등가조인을 수행
-- 컬럼 이름 뿐만 아니라 타입도 같아야함
-- 자동매칭 : 두 테이블에서 이름이 동일한 컬럼을 찾아서 해당 컬럼들이 값이 일치하는 행끼리 자동으로 결함
-- 중복 컬럼 제거 : 조인 결과에서 공통 컬럼은 한번만 표시
-- 명시적 조건 생략 ON절이나 USING절 없이 간단하게 조인할 수 있음

-- 단점
-- 의도하지 않은 결과가 나올 수 있음
-- 자동으로 공통 컬럼을 기준으로 조인하기 때문에 개발자가 어떤 컬럼을 기준으로 조인하는지 명확히 알기 어려울 수 있음

SELECT *
FROM EMP NATURAL JOIN DEPT ;

-----------------------------------------------------------------------------------------------------------------------------
-- 집합 연산자
-- JOIN과는 별개로 두 개의 테이블을 합치는 방법

-- 1. UNION
-- 두개의 테이블에서 '중복을 제거하고 합친 모든 행'을 반환
SELECT FIRST_NAME
FROM EMPLOYEES 
UNION
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS;

-- 2. UNION ALL
-- 중복을 제거하지 않고 모두 합친 행을 반환
SELECT FIRST_NAME
FROM EMPLOYEES 
UNION ALL
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS;

----------------------------------------------------------------------------------------------------------------------
-- VIEW
-- 하나 이상의 테이블이나 다른 뷰의 데이터를 볼 수 있게 해주는 데이터베이스의 객체
-- 쿼리 결과를 마치 하나의 테이블처럼 사용할 수 있도록 하는 가상 테이블
-- 실제 데이터는 저장하지 ㅇ낳고, VIEW를 참조할 때마다 미리 정의된 쿼리문이 실행되어 결과가 생성됨
-- 테이블 뿐만 아니라 다른 뷰를 참조해 새로운 뷰를 만들 수 있음

-- 사용 목적
-- 여러 테이블에서 필요한 정보를 사용할 때가 많음
-- VIEW에 저장하면 간단하게 호출할 수 있음

-- VIEW의 특징
-- 독립성
-- 테이블 구조가 변경 되어도 뷰를 사용하는 응용 프로그램은 변경하지 않아도 됨

-- 편리성
-- 복잡한 쿼리문을 VIEW로 생성함으로써 관련 쿼리를 단순하게 작성할 수 있음
-- 자주 사용하는 SQL문이면 VIEW에 저장하고 편리하게 사용할 수 있음

-- 보안성
-- 숨기고 싶은 정보가 존재한다면, VIEW를 생성할 때 해당 컬럼을 빼고 생성함으로써 사용자에게 정보를 감출 수 있음

-- VIEW의 생성
--CREATE VIEW 뷰이름 AS(
--	쿼리문
--)

-- VIEW의 수정
--OR REPLACE 옵션은 기존의 정의를 변경하는데 사용할 수 있음.
--CREATE OR REPLACE VIEW 뷰이름 AS(
--	쿼리문
--)

-- VIEW의 삭제
-- DROP VIEW 뷰이름 [PESTRICT 또는 CASCADE]
-- RESTRICT : 뷰를 다른곳에서 참조하고 있다면 삭제가 취소
-- CASCADE : 뷰를 참조하는 다른 뷰나 제약조건까지 모두 삭제

SELECT *
FROM PLAYER;
-- 선수의 이름과 나이를 조회
CREATE OR REPLACE VIEW PLAYER_AGE AS(
	SELECT 
		  ROUND((SYSDATE - BIRTH_DATE)/365) AS AGE,
		  P.*
	FROM PLAYER P
);

SELECT *
FROM PLAYER_AGE;

-- 30살이 넘은 선수를 조회
SELECT *
FROM PLAYER_AGE
WHERE AGE > 30;

-- 사원 이름과 상사 이름 조회
CREATE VIEW EMP_MANAGER AS (
	SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "ENAME",
			E2.FIRST_NAME || ' ' || E2.LAST_NAME AS "MANAGER_NAME"
	FROM EMPLOYEES E1 
	JOIN EMPLOYEES E2
	ON E1.MANAGER_ID = E2.EMPLOYEE_ID	   
);


SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "ENAME",
		E2.FIRST_NAME || ' ' || E2.LAST_NAME AS "MANAGER_NAME"
	FROM EMPLOYEES E1 
	JOIN EMPLOYEES E2
	ON E1.MANAGER_ID = E2.EMPLOYEE_ID; 

SELECT *
FROM EMP_MANAGER;

-- KING STEVEN의 부하직원이 몇명인지 조회
SELECT MANAGER_NAME,
	   COUNT(*) 
FROM EMP_MANAGER
GROUP BY MANAGER_NAME
HAVING MANAGER_NAME = 'Steven King';

-- PLAYER 테이블에 TEAM_NAME을 컬럼을 추가한 VIEW 만들기 VIEW 이름은 PLAYER_TEAM_NAME
CREATE VIEW PLAYER_TEAM_NAME AS (
	SELECT T.TEAM_NAME, 
		   P.* 
	FROM PLAYER P JOIN TEAM T
	ON P.TEAM_ID = T.TEAM_ID
);

SELECT *
FROM PLAYER_TEAM_NAME;

--  TEAM_NAME이 울산현대 인 선수들을 조회
SELECT *
FROM PLAYER_TEAM_NAME
WHERE TEAM_NAME = '울산현대';

-- HOMETEAM_ID , STADIUM_NAME, TEAM_NAME을 조회
-- HOMETEAM이 없는 경기장 이름도 나와야 함
CREATE VIEW STADIUM_INFO AS (
	SELECT S.HOMETEAM_ID, S.STADIUM_NAME, T.TEAM_NAME
	FROM STADIUM S LEFT OUTER JOIN TEAM T
	ON S.STADIUM_ID  = T.STADIUM_ID
);

SELECT *
FROM STADIUM_INFO
WHERE HOMETEAM_ID IS NULL;

-- 사원 테이블에서 급여, 급여를 많이 받는 순으로 순위를 조회
-- DATA_PLUS VIEW에 저장
CREATE OR REPLACE VIEW DATA_PLUS AS (
	SELECT FIRST_NAME,
			SALARY,
	   RANK() OVER (ORDER BY SALARY DESC) AS RANK_SAL
	FROM EMPLOYEES
);

SELECT *
FROM DATA_PLUS
WHERE RANK_SAL BETWEEN 1 AND 10;

------------------------------------------------------------------------------------------------------------------
-- TCL(Transaction Controll Languaage)
-- 트랜잭션 : 데이터베이스의 작업을 처리하는 논리적 연산 단위
-- SELECT, INSERT, UPDATE, DELETE문을 하나의 작업단위라고 함

--------------------------------------------------------------------------------------------------------------------
-- CASE문
-- 데이터의 값을 WHEN의 조건과 차례대로 비교한 후 일치하는 값을 찾아 THEN뒤에 있는 결과 값을 반환

SELECT ENAME,
		DEPTNO,
		CASE 
			WHEN DEPTNO = '10' THEN 'NEWYORK'
			WHEN DEPTNO = '20' THEN 'DALLAS'
			ELSE 'UNKNOW'
		END AS LOC_NAME
FROM EMP
WHERE JOB = 'MANAGER';

SELECT ROUND(AVG(CASE JOB_ID WHEN 'IT_PROG' THEN SALARY END),2) AS "평균 급여"
FROM EMPLOYEES;

-- WHERE 절에서의 CASE 사용
SELECT ENAME,
 	SAL,
 	CASE 
	 	WHEN SAL>= 2900 THEN '1등급'
	 	WHEN SAL>= 2700 THEN '2등급'
	 	WHEN SAL>= 2000 THEN '3등급'
		END AS SAL_GRADE
FROM EMP
WHERE JOB = 'MANAGER' AND ( CASE
				WHEN SAL>= 2900 THEN 1
	 			WHEN SAL>= 2700 THEN 2
	 			WHEN SAL>= 2000 THEN 3
				END
) = 1;

-- EMP 테이블에서 SAL이 3000 이상이면 HIGH 1000이상이면 MID 다 아니면 LOW를 ENAME, SAL, GRADE순으로 조회
SELECT ENAME,
	   SAL,
	   CASE 
		   	WHEN SAL >= 3000 THEN 'HIGH'
		   	WHEN SAL >= 1000 THEN 'MID'
		   	ELSE 'LOW'
	   END AS GRADE
FROM EMP;

-- CASE문의 특징과 활용

-- 표현식으로 사용
-- CASE문은 하나의 값이나 결과를 반환하는 표현식이기 때문에
-- SELECT, ORDER BY, GROUP BY 등의 구문 내에서 사용될 수 있음

-- 가독성 향상
-- 복잡한 조건에 따른 값을 한눈에 파악할 수 있게 도와주어, 쿼리의 가독성과 유지보수성이 높아짐

-- NULL 처리
-- 조건에 해당하지 않는 경우 ELSE절이 없으면 NULL이 반환

-- 중첩 사용 가능
-- CASE문 안에 CASE문을 중첩해서 사용할 수 있음

-- 표준 SQL지원 
-- 대부분의 주요 데이터베이스등에서 표준 SQL문법의 일부로 지원됨


-------------------------------------------------------------------------------------------------------------------
-- PL(Procedual Language)/SQL문
-- 원래 SQL문은 주로 데이터의 정의, 조작, 제어를 위한 언어
-- PL/SQL문은 여기에 조건, 반복문, 변수 선언, 예외처리와 같은 절차적 기능을 추가하여 복잡한 로직을 구현할 수 있게 해줌

-- PL/SQL문의 구조
-- 기본적으로 블록단위로 구성 // 하나의 블록은 세부분으로 이루어져 있음
-- 선언부(DECLARE): 변수, 상수, 사용자정의 타입을 선언
-- 실행부(BEGIN ... END): 실제 로직이 작성되는 부분
-- 예외처리부(EXCEPTION): 실제 도중 발생하는 오류를 처리하는 구문 작성
DECLARE 
	V_MESSAGE VARCHAR2(100); -- 변수 LET V_MESSAGE
BEGIN
	V_MESSAGE := 'HELLO, PL/SQL'; -- 변수에 대입
	DBMS_OUTPUT.PUT_LINE(V_MESSAGE); --CONSOLE.LOG()와 비슷
END;

-- 1. IF 조건 THEN 실행문;
-- 		END IF;
-- 2. IF 조건 THEN 실행문;
--		ELSE 실행문;
-- 		END IF;
-- 3. IF 조건 THEN 실행문;
--		ELSIF 조건 THEN 실행문;
--		ELSIF 조건 THEN 실행문;
--		ELSIF 조건 THEN 실행문;
-- 		END IF;

DECLARE
	SALARY NUMBER := 5000;
BEGIN
	IF SALARY < 3000 THEN
		DBMS_OUTPUT.PUT_LINE('급여가 낮습니다.');
	ELSIF SALARY BETWEEN 3000 AND 7000 THEN
		DBMS_OUTPUT.PUT_LINE('급여가 중간입니다.');
	ELSE DBMS_OUTPUT.PUT_LINE('급여가 높습니다.');
	END IF;
END;

-- SCORE 변수에 80을 대입하고 GRADE VARCHAR2(5)에 어떤 학점인지 대입하여 출력
-- 90 이상 A 80 이상 B 70 이상 C 60점 이상 D 그 이하는 F
DECLARE
	SCORE NUMBER := 80;
	GRADE VARCHAR2(5);
BEGIN
	IF SCORE >= 90 THEN GRADE := 'A';
	ELSIF SCORE >= 80 THEN GRADE := 'B';
	ELSIF SCORE >= 70 THEN GRADE := 'C';
	ELSIF SCORE >= 60 THEN GRADE := 'D';
	ELSE GRADE := 'F';
	END IF;
	DBMS_OUTPUT.PUT_LINE('당신의 점수 : ' ||SCORE||'점' ||CHR(10)||'학점: '||GRADE); -- CHR(10) => 줄바꿈
END;

-- FOR문
-- FOR 변수 IN 시작값 .. END값 LOOP
--		반복하고자 하는 명령;
-- END LOOP;

BEGIN
	FOR I IN REVERSE 1 .. 10 LOOP
		DBMS_OUTPUT.PUT_LINE('I의 값: ' ||I);
	END LOOP;	
END;

-- 1부터 10까지 X는 짝수 입니다 X는 홀수 입니다 출력

BEGIN
	FOR X IN 1 .. 10 LOOP 
		IF (MOD(X ,2) = 1) THEN DBMS_OUTPUT.PUT_LINE(X||'는 홀수');
		ELSE DBMS_OUTPUT.PUT_LINE(X||'는 짝수');
		END IF;
	END LOOP;	
END;

-- 쿼리 결과를 행 단위로 반복처리할 때 사용
DECLARE
	CURSOR EMP_CURSOR IS
		SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES ORDER BY EMPLOYEE_ID;
BEGIN
	FOR REC IN EMP_CURSOR LOOP
		DBMS_OUTPUT.PUT_LINE('EMPLOYEE: ' ||REC.EMPLOYEE_ID|| ', NAME: '||REC.FIRST_NAME);
	END LOOP;
END;

-- WHILE
-- WHILE 조건 LOOP
--			반복할 문장;
-- END LOOP;
-- 1부터 10까지 총 합을 구해서 출력하시오
DECLARE
	I NUMBER := 1;
	HAP NUMBER := 0;
BEGIN
	WHILE I <= 10 LOOP
		HAP := HAP + I;
		I := I + 1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('1~10까지 총합'||HAP);
END;

-- PL/SQL의 종류
-- 1. 익명 블록
-- 이름 없이 한번 실행되는 PL/SQL블록
-- 데이터베이스에 저장되지 않고 즉시 실행됨
-- 테스트, 일회성 작업, 간단한 스크립트 작성 등에 주로 사용

-- 2. 프로시저(PROCEDURE)
-- 데이터베이스에 저장되어 필요할 때마다 호출할 수 있는 이름이 있는 PL/SQL 블록
-- 장점 
-- 하나의 요청으로 여러 SQL문을 실행 시킬 수 있음
-- 네트워크 소요시간을 줄여 성능을 개선할 수 있음
-- 기능 변경이 편함
-- CREATE OR REPLACE PROCEDURE 프로시저명(
--	매개변수 IN 데이터타입%TYPE,
--	매개변수 IN 데이터타입%TYPE,
--	매개변수 IN 데이터타입%TYPE
-- )IS
-- 함수 내에서 사용할 변수, 상수 선언;
-- BEGIN
--	실행할 문장;
-- END;

-- JOBS 테이블에 INSERT를 해주는 프로시저
SELECT * FROM JOBS;
INSERT INTO JOBS(JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY)
VALUES(값1, 값2, 값3, 값4);

CREATE OR REPLACE PROCEDURE MY_NEW_JOB_PROC(
	P_JOB_ID IN JOBS.JOB_ID%TYPE,
    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
)IS
BEGIN
	INSERT INTO JOBS(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
	VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
	DBMS_OUTPUT.PUT_LINE('ALL DONE ABOUT '||' '||P_JOB_ID);
END;

-- 프로시저 호출
-- 한번 실행했을 때 추가됨
-- 두번 실행하면 PK제약조건에 걸려 실행이 안됨
CALL MY_NEW_JOB_PROC('IT', 'DEVELOPER', 14000, 20000);

-- PK에 안걸리면 추가(INSERT)
-- PK에 걸리면 수정(UPDATE)

-- 함수와 프로시저의 차이
-- 함수는 반드시 하나이상의 값을 반환해야 함
-- 함수는 SQL문 내에서 사용할 수 있음
-- 함수는 주로 계산, 데이터의 가공, 값의 반환 작업에 사용

-- 프로시저는 SQL문 내에서 사용이 불가능
-- 프로시저는 값을 반드시 반환할 필요는 없음
-- 프로시저는 특정 작업이나 프로세스를 실행하기 위해 사용됨


-- 3. 트리거(TRIGGER)
-- 특정 테이블 또는 뷰에 대한 DML 또는 DDL작업이 발생할 때 자동으로 실행되는 PL/SQL 코드



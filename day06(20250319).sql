CREATE OR REPLACE PROCEDURE MY_NEW_JOB_PROC_1(
	P_JOB_ID IN JOBS.JOB_ID%TYPE,
    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
)IS
	CNT NUMBER := 0;
BEGIN
	-- SELECT ... INTO
	SELECT COUNT(*) INTO CNT FROM JOBS WHERE JOB_ID = P_JOB_ID;
	
	--JOB_ID가 있으면 UPDATE문 실행
	--(JOB_TITLE, MIN_SALARY, MAX_SALARY 다 수정)
	IF CNT = 1 THEN 
		UPDATE JOBS 
		SET JOB_TITLE = P_JOB_TITLE, MIN_SALARY = P_MIN_SALARY, MAX_SALARY = P_MAX_SALARY
		WHERE JOB_ID = P_JOB_ID;
		DBMS_OUTPUT.PUT_LINE('UPDATE ALL DONE ABOUT '||' '||P_JOB_ID);
	ELSE
		INSERT INTO JOBS(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
		VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
		DBMS_OUTPUT.PUT_LINE('INSERT ALL DONE ABOUT '||' '||P_JOB_ID);
	END IF;

END;

-- 프로시저 호출
-- 한번 실행했을 때 추가됨
-- 두번 실행하면 PK제약조건에 걸려 실행이 안됨
CALL MY_NEW_JOB_PROC_1('TECH', 'TECH_DEVELOPER', 15000, 25000);

SELECT *
FROM JOBS;

-- SELECT ... INTO
-- SQL 쿼리문의 실행결과를 PL/SQL문의 변수에 저장하는 역할
-- 쿼리문의 결과값을 직접 변수에 할당할 수 있음
-- 결과가 없는 경우 : NO_DATA_FOUND 예외가 발생
-- 결과가 여래행인 경우 : TOO_MANY_ROWS 오류 발생

DECLARE
	D_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
	D_FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
	SELECT EMPLOYEE_ID, FIRST_NAME 
	INTO D_EMP_ID, D_FIRST_NAME
	FROM EMPLOYEES
	WHERE EMPLOYEE_ID = 100;

	DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID: '||D_EMP_ID);
	DBMS_OUTPUT.PUT_LINE('FIRST_NAME: ' ||D_FIRST_NAME);
END;



-- PK에 안걸리면 추가(INSERT)
-- PK에 걸리면 수정(UPDATE)

-- 함수와 프로시저의 차이
-- 함수는 반드시 하나이상의 값을 반환해야 함
-- 함수는 SQL문 내에서 사용할 수 있음
-- 함수는 주로 계산, 데이터의 가공, 값의 반환 작업에 사용

-- 프로시저는 SQL문 내에서 사용이 불가능
-- 프로시저는 값을 반드시 반환할 필요는 없음
-- 프로시저는 특정 작업이나 프로세스를 실행하기 위해 사용됨


-- JOBS 테이블에서 제거하는 프로시저
CREATE OR REPLACE PROCEDURE DEL_JOB_PROC_1(
	P_JOB_ID IN JOBS.JOB_ID%TYPE
)IS
	CNT NUMBER := 0;
BEGIN
	SELECT COUNT(*) INTO CNT FROM JOBS WHERE JOB_ID = P_JOB_ID;

	IF CNT = 1 THEN 
		DELETE FROM JOBS
		WHERE JOB_ID = P_JOB_ID;
		DBMS_OUTPUT.PUT_LINE('DELETE ALL DONE ABOUT '|| ' ' ||P_JOB_ID);
	ELSE
		DBMS_OUTPUT.PUT_LINE('NO EXITE DELETE '|| ' ' ||P_JOB_ID);
	END IF;

END;


CALL DEL_JOB_PROC_1('IT');

SELECT *
FROM JOBS;

-- 3. 트리거(TRIGGER)
-- 데이터베이스에서 특정 이벤트(INSERT, UPDATE, DELETE 같은 DML 또는 DDL작업)가 발생할 때 자동으로 실행되는 PL/SQL 코드
-- 특정 데이터 또는 시스템 이벤트 발생시 자동으로 발동하여 지정된 작업을 수행함

-- 트리거의 종류
-- 실행 시점에 따른 분류
-- BEFORE 트리거
-- 	이벤트 발생 전에 실행, 주로 데이터 유효성 검증이나 변경 전 데이터 조작에 사용
-- AFTER 트리거
--	이벤트 발생 후에 실행, 주로 후속 작업 처리에 사용
-- INSTEAD OF 트리거
--	주로 뷰(VIEW)에 대해 사용되며, 뷰에 DML작업이 수행될 때 // 실제 테이블에 반영될 로직을 정의할 때 사용

-- 행 단위와 문장 단위
-- ROW-LEVEL트리거
--	DML문장이 실행될 때 해당 문장으로 영향을 받는 각 행마다 개별적으로 실행
-- STATEMENT-LEVEL 트리거
--	DML문장이 실행될 때 한번만 호출됨 // 행의 수와 관계없이 단 한번만 실행되므로, 특정 작업 전체에 대한 처리가 필요할 때 유용


--트리거의 기본 문법
-- CREATE OR REPLACE TRIGGER 트리거이름
--	 실행시점 INSERT OR UPDATE OR DELETE ON 테이블명
--	 (FOR EACH ROW) -> 행 단위 트리거가 되어 각 행마다 개별적으로 실행 -> 생략 가능
--	 DECLARE
--		 변수, 상수
--	 BEGIN
--		 트리거 실행시 수행할 PL/SQL코드
--	 END;
	
-- 트리거 활용 사례
-- 데이터 무결성 유지
-- 삽입 또는 수정되는 데이터가 특정 규칙을 준수하는지 사전에 확인할 수 있음
-- 감사 및 로깅
-- 테이블의 변경 내역을 별도의 감사 테이블에 기록하여, 누가 언제 어떤 데이터를 변경했는지 추적할 수 있음
-- 비즈니스로직 구현
-- 주문 테이블에 주문이 들어오면 상품테이블에서 자동으로 재고를 수정
-- 복잡한 데이터 처리
-- 한번의 DML 작업으로 여러 관련 테이블의 동시 변경이 필요한 경우, 트리거를 통해 이러한 복잡한 로직을 중앙집중적으로 관리할 수 있음

CREATE OR REPLACE TRIGGER TRG_CHECK_SALARY
BEFORE INSERT OR UPDATE ON EMPLOYEES -- EMPLOYEES 테이블에 추가나 수정이 발생하기 전에
FOR EACH ROW -- 영향을 받는 각 행마다 트리거가 실행
BEGIN
	IF :NEW.SALARY < 0 THEN -- :NEW.SALARY -> 새로 삽입되거나 수정된 행의 급여값을 참조
		RAISE_APPLICATION_ERROR(-20001,'급여는 0보다 작을 수 없습니다.'); -- 급여가 음수일 경우, 사용자 정의 에러(-20001)을 발생시켜 트랜잭션을 중단
	END IF;
END;

SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 100;

UPDATE EMPLOYEES E
SET SALARY = -1000
WHERE EMPLOYEE_ID = 100;

-- 가상변수
-- 오라클 트리거 내에서 자동으로 제공되는 특수한 변수
-- 데이터 변경 전, 후의 행 값을 임시로 보관하는 역할
-- :NEW 새로 삽입되거나 수정될 행의 값을 담고 있음 // INSERT, UPDATE트리거에서 주로 사용됨
-- BEFORE 트리거
-- :NEW의 값을 변경하여 입력될 데이터를 조정할 수 있음
-- AFTER 트리거에서는 값을 읽기 전용

-- :OLD 삭제되거나 수정되기 전에 기존 행 값을 담고 있음 // DELETE와 UPDATE 트리거에서 사용
-- INSERT작업에서는 기존 행이 없으므로 :OLD를 사용할 수 없음

-- 감사 로그 테이블 생성 예시
CREATE TABLE AUDIT_LOG(
	LOG_ID NUMBER PRIMARY KEY,
	OPERATION VARCHAR2(10),
	EMPLOYEE_ID NUMBER,
	CHANGE_DATE DATE DEFAULT SYSDATE,
	DETAILS VARCHAR2(4000)
);

SELECT *
FROM AUDIT_LOG
ORDER BY LOG_ID;

DELETE FROM AUDIT_LOG ;

-- EMPLOYEES 테이블에 대한 AFTER 트리거 생성
CREATE OR REPLACE TRIGGER EMLPOYEES_AUDIT
AFTER INSERT OR UPDATE OR DELETE ON EMPLOYEES
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		INSERT INTO AUDIT_LOG(LOG_ID, OPERATION, EMPLOYEE_ID, DETAILS)
		VALUES (AUDIT_LOG_SEQ.NEXTVAL, 'INSERT', :NEW.EMPLOYEE_ID, '신규 직원 추가');
	ELSIF UPDATING THEN
		INSERT INTO AUDIT_LOG(LOG_ID, OPERATION, EMPLOYEE_ID, DETAILS)
		VALUES (AUDIT_LOG_SEQ.NEXTVAL, 'UPDATE', :NEW.EMPLOYEE_ID, '직원 정보 변경');
	ELSIF DELETING THEN
		INSERT INTO AUDIT_LOG(LOG_ID, OPERATION, EMPLOYEE_ID, DETAILS)
		VALUES (AUDIT_LOG_SEQ.NEXTVAL, 'DELETE', :OLD.EMPLOYEE_ID, '직원 삭제');
	END IF;
END;

INSERT INTO HR.EMPLOYEES
(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES(98, 'MINSU', 'HONG', 'MINSU@GMAIL.COM', '112.1111', '2025.02.19', 'IT_PROG', 15000, 0, 100, 90);

DELETE FROM HR.EMPLOYEES
WHERE EMPLOYEE_ID = 98;

UPDATE HR.EMPLOYEES 
SET SALARY = 14000
WHERE EMPLOYEE_ID = 99;

SELECT *
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

CREATE SEQUENCE AUDIT_LOG_SEQ;

-- 시퀀스
-- 테이블에 값을 추가할 때 자동으로 순차적인 정수 값이 들어고도록 설정해주는 객체

-- 시퀀스 생성
-- CREATE SEQUENCE 시퀀스명;

-- 시퀀스 생성하면서 옵션 설정
-- CREATE SEQUENCE 시퀀스먕
-- START WITH 1 -> 1부터 카운팅
-- INCREMENT BY 1 -> 1씩 증가
-- CACHE 20; -> 미리 20개의 INDEX공간 확보

CREATE TABLE PERSON(
	IDX NUMBER PRIMARY KEY,
	NAME VARCHAR2(200),
	AGE NUMBER
)
CREATE SEQUENCE PERSON_SEQ;

-- PERSON에 데이터를 추가할때 IDX에 시퀀스 객체를 넣음
INSERT INTO PERSON VALUES(PERSON_SEQ.NEXTVAL, '홍길동', 30);
INSERT INTO PERSON VALUES(PERSON_SEQ.NEXTVAL, '김길동', 25);
INSERT INTO PERSON VALUES(PERSON_SEQ.NEXTVAL, '박길동', 40);

SELECT *
FROM PERSON;

-- SELECT 절에서 시퀀스 객체에 들어있는 값을 확인할 수 있음

SELECT PERSON_SEQ.CURRVAL FROM DUAL;
SELECT PERSON_SEQ.NEXTVAL FROM DUAL;

-- 시퀀스 값을 초기화 하는법
-- 1. 시퀀스를 삭제하고 다시 만듬
-- 2. 현재 시퀀스 값 만큼 INCREMENT를 음수로 만듬
ALTER SEQUENCE PERSON_SEQ INCREMENT BY -2;
-- 다시 시퀀스의 증가량을 1로 설정
ALTER SEQUENCE PERSON_SEQ INCREMENT BY 1;

-- 시퀀스 삭제
DROP SEQUENCE PERSON_SEQ;

CREATE TABLE DEPT_COPY AS SELECT * FROM DEPT;

SELECT *
FROM DEPT_COPY;

-- DEPT 테이블에 값이 입력 수정 삭제가 될때마다 DEPT_COPY에도 똑같이 적용하는 트리거
-- TRG_DEPT_COPY

CREATE OR REPLACE TRIGGER TRG_DEPT_COPY
AFTER INSERT OR UPDATE OR DELETE ON DEPT
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		INSERT INTO DEPT_COPY(DEPTNO, DNAME, LOC) VALUES(:NEW.DEPTNO, :NEW.DNAME, :NEW.LOC);
	ELSIF UPDATING THEN
		-- DNAME이 변경되었을 경우
        IF :NEW.DNAME != :OLD.DNAME THEN
            UPDATE DEPT_COPY
            SET DNAME = :NEW.DNAME
            WHERE DEPTNO = :OLD.DEPTNO;
        END IF;
        
        -- LOC가 변경되었을 경우
        IF :NEW.LOC != :OLD.LOC THEN
            UPDATE DEPT_COPY
            SET LOC = :NEW.LOC
            WHERE DEPTNO = :OLD.DEPTNO;
        END IF;
	ELSIF DELETING THEN
		DELETE FROM DEPT_COPY WHERE DEPTNO = :OLD.DEPTNO;
	END IF;
END;

INSERT INTO DEPT VALUES(50, 'NAME', 'SEOUL');
UPDATE DEPT 
SET DNAME = 'TESTING'
WHERE DEPTNO = 50;
DELETE FROM DEPT WHERE DEPTNO = 50;
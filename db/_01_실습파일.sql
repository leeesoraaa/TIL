-- 현재 접속된 계정 확인 하는 명령어
show user
-- 예약어(keyword): 용도와 기능이 미리 정의된 명령어

-- 실습에 사용한 자료를 복사 붙여넣기 한 후 해당 계정에 담는 작업을 수행한다. EMP_EXAMPLE.sql
-- 테이블 삭제 명령어: 테이블 생성 전에 동일한 이름의 테이블이 존재하면 오류가 발생하므로 기존 테이블을 제거하는 작업을 먼저 수행한다.
DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;

-- DEPARTMENT 테이블 생성, 부서에 대한 정보를 담기 위한 테이블
CREATE TABLE DEPARTMENT
        (DNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY, -- 부서번호 숫자 최대 2글자, 제약조건 기본키
         DNAME VARCHAR2(14), -- 부서명 가변길이 문자 최대 14글자
	 LOC   VARCHAR2(13) ) ; -- 부서의 위치 가변길이 문자 최대 13글자
     
-- EMPLOYEE 테이블 생성, 직원정보를 담기 위한 테이블
CREATE TABLE EMPLOYEE 
        (ENO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY, -- 사번 숫자 최대 4자리, 제약조건 기본키
	 ENAME VARCHAR2(10), -- 직원이름 문자 최대 10자리
 	 JOB   VARCHAR2(9), -- 직부(직책)
	 MANAGER  NUMBER(4), -- 직속상관 사번
	 HIREDATE DATE, -- 입사일자
	 SALARY NUMBER(7,2), -- 급여(전체 7곱자리, 소수점 둘째자리)
	 COMMISSION NUMBER(7,2), -- 상여금(전체 7곱자리, 소수점 둘째자리)
	 DNO NUMBER(2) CONSTRAINT FK_DNO REFERENCES DEPARTMENT); -- 부서번호 참조
     
-- SALGRADE 테이블 생성, 직원들의 호봉에 따른 연봉금액, 1~5호봉    
CREATE TABLE SALGRADE
        (GRADE NUMBER,
	 LOSAL NUMBER,
	 HISAL NUMBER );

-- DEPARTMENT 테이블에 레코드를 삽입하는 명령어 (부서번호, 부서명, 부서위치) 
INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

-- EMPLOYEE 테이블에 레코드를 삽입하는 명령어 (사번, 직원이름, 직무, 직속상관 사번, 입사일자, 급여, 상여금, 부서번호)
INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

-- DB에 영구저장
COMMIT;


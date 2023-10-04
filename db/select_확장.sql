-- 주석(comment): 프로그램 실행과 상관없이 코드의 설명을 담기 위해 사용하는 구문(기호 --,#, /* ~ */,//)
-- sql query: DB 표준 명령어, 종결자 세미콜론;
-- sql*plus 명령어: oracle에서만 사용 가능한 명령어, 한 줄 명령어

-- 현재 접속한 사용자 계정을 확인하는 명령
show user

-- scott 계정이 가지고 있는 모든 테이블의 목록(tab: table)을 추출하는 명령
select * from tab;

-- CRUD 명령어: DML관련 명령어
-- DDL: 정의어(create-생성, alter-수정, drop-삭제)
-- DML: 조작어(select-추출/검색, insert- 추가, update-수정, delete-삭제)
-- DCL: 제어어(commit-영구저장/반영, rollback-복구, grant-권한부여, revoke-권한해제)
-- 트랜젝션(transaction): 데이터베이스를 통해 수행되는 명령어의 진행과정, 하나의 명령이 실행되는 과정

-- select 명령어: 테이블에 저장된 데이터를 레코드 단위로 추출
--1. 기본형: select 필드명 from 테이블명;
-- Q1. 직원 정보를 담고 있는 employee 테이블에 등록된 모든 사원의 정보를 추출하시오.(*=all)
-- 테이블의 구조를 확인하는 명령
desc employee
select * from employee;

-- Q2. 직원정보(employee) 테이블에서 직원의 번호, 이름, 직급을 추출하시오.
select eno, ename, job from employee;

-- Q3. 직급(job)이 사원(clerk)에 해당하는 사원의 정보만 추출하시오.
select * from employee where job = 'CLERK';

--%s: 문자열은 '' 붙이기

--2. 확장형: where절 - 주어진 조건이 참인 것만 추출할 때 사용하는 절
-- 조건식(or 판정식 or 비교/판단문): 반드시 그 결과가 참 또는 거짓으로 판정되는 수식
-- 연산자(operation): 피연산자 사이에 연산을 수행하기 위해 사용하는 기호들
-- 산술연산자: 사칙연산을 수행하는 연산기호(+, -, *, /)
-- Q4. 직원의 정보를 담고있는 테이블 employee를 이요하여 현재 직원의 이름과 급여 그리고 10씩 인상된 급여를 추출하시오.
select ename, salary, salary + 10 from employee;

--별칭(nickname): as절
select ename, salary, salary + 10 as "인상된 급여" from employee;

--Q5. 직원정보를 담고 있는 테이블에 직급이 "analyst"에 해당하는 직원의 급여를 500씩 인상하여 추출하시오.
select ename, job, salary, salary + 500 "인상 후" from employee
where job = 'ANALYST';

--Q6. 직원테이블의 연봉과 보너스를 합친 금액을 추출하되 해당 컬럼명은 총급여로 표시하시오.
select salary, commission, salary + commission "총급여"
from employee;
-- null: 비어있다는 의미로 0이 아님 따라서 사칙연산이 불가능
-- nulll을 다른 값으로 변환하는 함수: NVL함수, NVL(데이터, 대체값)
select salary, nvl(commission, 0), salary + nvl(commission, 0) "총급여"
from employee;

-- 관계연산자 or 비교연산자: 주어진 조건에 참인 것만 추출
--Q7. 부서번호(dno)가 20인 사원의 정보를 추출하시오.
select * from employee where dno = 20;

--Q8. 부서번호가 20이 아닌 직원의 정보를 추출하시오.
select * from employee where dno ^= 20;
select * from employee where dno != 20;
select * from employee where dno <> 20;

--Q9. 사원의 이름이 FORD인 사원의 사번, 이름, 급여를 추출하시오.
select eno, ename, salary from employee where ename = 'FORD';

--Q10. 입사일이 1982년 1월 1일 이후에 해당하는 사원의 정보를 추출하시오.
--문자, 날짜는 반드시 홑따옴표 안에 표시한다.
select * from employee where hiredate >= '82/01/01';

-- 논리연산자: 논리값(참, 거짓)을 이용하여 연산을 수행하는 연산자
-- 여러개의 비교연산자를 결합하여 결과를 얻어낼 때 사용하는 연산자
--and, or, not

--Q11. 부서번호가 10이고 직급이 MANAGER에 해당하는 직원의 정보를 추출하시오.
select * from employee where dno = 10 and job='MANAGER';

--Q12. 부서번호가 10이거나 직급이 MANAGER에 해당하는 직원의 정보를 추출하시오.
select * from employee where dno=10 or job='MANAGER';

--Q13. 부서번호가 10이 아닌 사원의 정보를 추출하시오.(3가지 유형을 기술하시오.)
select * from employee where dno ^=10;
select * from employee where dno <>10;
select * from employee where dno != 10;

-- 관용적인 표현식을 이용한 논리연산자
-- between ~ and: 하나의 컬럼을 기준으로 조건을 부여할 때 사용하는 연산자, 숫자, 문자, 날짜형에 사용가능
--Q14. 급여가 2000이상 3000이하에 해당하는 사원의 정보를 추출하시오.
select * from employee where salary >=2000 and salary <= 3000;
select * from employee where salary between 2000 and 3000;

--in: 포함여부를 판단하는 관용적 표현
--Q15. 급여가 2000미만이거나 3000초과에 해당하는 사원의 정보를 추출하시오.
select * from employee where salary < 2000 or salary > 3000;
select * from employee where salary not between 2000 and 3000;

--Q16. 1987년에 입사한 사원의 정보를 추출하시오.
select * from employee where hiredate >= '87/01/01' and hiredate < '88/01/01';
select * from employee where hiredate between '87/01/01' and '87/12/31';

--Q17. 부서번호가 10이거나 30에 해당하는 사원의 정보를 추출하시오.
select * from employee where dno = 10 or dno = 30;
select * from employee where dno in(10, 30);
select * from employee where dno != 20;

-- !의 의미는 not을 뜻한다.
select * from employee where dno not in(10, 30);

-- 만능문자, 와일드카드문자(wild character): %, _ => 프로그래밍 언어에서의 와일드문자는 *와 ?를 사용
-- 대체문자
-- '=' 대신 같다는 뜻의 like를 사용함
-- %: 글자 수에 상관없이 모든 글자를 대신하는 기호
-- _: 개당 한 글자를 대체하는 만능문자

-- Q18. 사원의 이름의 첫 글자가 'M'로 시작하는 직원 정보를 추출하시오.
select * from employee where ename like 'M%';

--Q19. 사원의 이름의 마지막 글자가 'N'에 해당하는 직원의 정보를 추출하시오.
select * from employee where ename like'%N';

--Q20. 직원의 이름에 'R'이 포함된 직원의 정보를 추출하시오.
select * from employee where ename like '%R%';

--Q21. 직원 이름의 두번째 글자가 'A'인 직원의 정보를 추출하시오.
select * from employee where ename like '_A%';

--Q22. 직원 이름의 첫 글자가 'M'이 아닌 직원의 정보를 추출하시오.
select * from employee where ename not like 'M%';

-- is NULL / is NOT NULL
select commission from employee; 
select commission from employee where commission is null;
select * from employee where commission is not null;

--3. 확장형: 정렬을 위한 order by 절
-- 정렬(sort): 주어진 키 값에 따라 순서대로 나열하는 것
-- 정렬 방식: 오름차순(asc, ascending, 생략가능)과 내림차순(desc, descending)
--  숫자
--  문자: 사전 순(오름차순), 사전 반대순(내림차순)

-- Q23. 사원의 급여를 기준으로 오름차순 정렬하여 추출하시오.
select * from employee order by salary; -- 정렬방식이 생략되면 오름차순으로 간주한다.

--Q24. 부서번호를 기준으로 오름차순 정렬하여 추출하시오. 이 때, 동일한 부서번호를 가지고 있는 직원은 급여를 기준으로 내림차순 정렬하시오.
select * from employee order by dno, salary desc;
select * from employee order by salary desc, dno;

--Q25. 가장 최근에 입사한 사원 순서대로 추출하시오.
select * from employee order by hiredate desc;

-- distinct: 동일한 값들이 중복되어 추출되지 않도록 하는 옵션
select distinct dno from employee;

-- 연결연산자: select문 내부에 문자를 연결할 때 사용하는 연산자, ||
select ename || ' 의 직무는 ' || job || ' 입니다. ' from employee;

--함수(Function): 반복적으로 수행하는 명령이나 기능을 하나의 명령으로 묶어서 관리하는 명령어
-- SQL 단일행 함수: 함수의 결과가 하나의 행으로 추출된다. 
--   종류: 숫자함수, 문자함수, 날짜함수, 형변환, 일반함수
-- SQL 복수행 함수 = 그룹 함수

-- dual 테이블: 임시 테이블(실제 존재하지 않으나 존재하는 것 처럼 보여지는 테이블)
--   단일행 함수의 결과를 추출하기 위해 사용되는 가상의 테이블
-- 10 * 5
select 10*5 from dual;
desc dual
select * from dual;

--현재 시스템의 날짜를 추출하는 함수
select sysdate from dual;

-- 숫자 함수: 숫자 데이터를 처리하는 함수
--  ABS(): 절대값을 추출하는 함수
select abs(-10) from dual;
desc dual
select -10, abs(-10) from dual;

--ROUND(숫자, 자릿수): 특정 자릴수에서 반올림하는 함수
--FLOOR(숫자): 소숫점 아래를 버리는 함수
select 34.5432 from dual;
select floor(34.5432) from dual;
select round(34.5432, 0) from dual;

select 34.5678, round(34.5678), round(34.5678, 2), round(34.5678, -1) from dual;
select 34.5678, round(34.5678,-2) from dual;

--MOD(숫자, 나눌 수): 숫자를 해당 나눌 수로 나누어 생기는 나머지를 추출하는 함수
select mod(27, 5), mod(27, 7), mod(27, 2) from dual;

-- 자연어 처리, NLP
-- UPPER, LOWER, LENGTH, LENGTHB, INSTR, SUBSTR ...























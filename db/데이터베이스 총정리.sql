--1. 데이터타입: 오라클에서 지원하는 자료형
--char: 고정길이 문자 데이터, 입력된 자료의 길이와 상관없이 정해진 길이 만큼 저장 영역 차지
--varchar2: 가변길이 문자 데이터
-- number: 전체자릿수, 소숫점 이하 실수
-- date: 날짜 데이터, timestamp(date의 확장된 개념)

--2. 오라클 데이터베이스 접속
--SQL*PLUS와 SQL 명령어(DDL, DML, DCL)
-- 사용자 계정: 관리자(system, sys), 일반 사용자 계정(scott)
--오라클 접속: sqlplus id/pw
-- 현재 계정 확인: show user
show user
--계정 접속 명령: connect(=conn)
conn system/1234
--테이블 구조확인: desc 테이블명
desc employee
--데이터 조회: select 
--select [distinct] 컬럼명 [*=all] [as]
--from 테이블명
--[where 조건식]
--[order by 컬럼명 asc/desc]
--[group by 컬럼명]
--[having 그룹조건식]

--수식: 산술식, 관계식(비교/판단), 논리식
-- 산술식(+, -, *, /): 숫자 또는 날짜데이터만 사용 가능
-- Q1. 각 직원의 연봉을 계산하여 사원번호, 이름, 급여, 연봉을 추출하시오.
select eno, ename, salary, salary * 12 "연봉" from employee;

--연봉은 급여와 보너스를 이용하여 계산할 것
select eno, ename, salary, salary * 12 + commission "연봉" from employee; -- 산술식은 null이 계산되지 않는다.
--NVL 함수: NULL값을 특정값으로 바꿔줌
select eno, ename, salary, salary * 12 + nvl(commission,0) "연봉" from employee;

--비교연산자(관계연산자)
--Q2. 급여가 1500이상인 사원의 정보 추출
select * from employee where salary >= 1500;
--Q3. 부서번호가 10인 사원의 정보 추출
select *from employee where  dno=10;
--Q4. SCOTT 사원의 정보 추출
select * from employee where ename='SCOTT';
--Q5. 1981년 전에 입사한 직원의 정보 추출
select * from employee where hiredate<'1981/01/01';

--논리연산자: 하나이상의 수식을 연결하여 계산할 때
--AND
--OR
--NOT: 단항 연산자

--Q1. 부서번호가 10이고 직급이 'MANAGER'인 사원의 정보 추출
select *from employee where dno=10 and job='MANAGER';
--Q2. 부서번호가 10이거나 직급이 'MANAGER'인 사원의 정보 추출
select*from employee where dno=10 or job='MANAGER';
--Q3.부서번호가 10이 아닌 직원의 정보 추출
select * from employee where not dno =10;
--Q4. 급여가 1000에서 1500사이의 직원 추출
select * from employee where salary between 1000 and 1500;
--Q5. 급여가 1000미만이거나 1500초과인 직원정보 추출
select * from employee where salary not between 1000 and 1500;
--Q6. 커미션이 300이거나 500이거나 1400인 사원 추출
select * from employee where commission in(300, 500, 1400);

--LIKE연산자: 와일드카드문자(_,%)와 함께쓰는 연산자 
--Q1. 사원의 이름이 'F'로 시작하는 사원
select * from employee where ename like 'F%';
--Q2. 이름에 'M'이 포함된 사원의 정보추출
select * from employee where ename like '%M%';
select * from employee where instr(ename, 'M') !=0;
--Q3. 이름이 'N'으로 끝나는 사원
select * from employee where ename like '%N';
select * from employee where substr(ename, -1,1)='N';
--Q4. 이름의 두번째 글자가 'A'인 사원
select * from employee where ename like '_A%';
select * from employee where substr(ename, 2, 1)='A';
--Q5. 이름의 세번째글자가 'A'인 사원
select * from employee where ename like'__A%';
select * from employee where substr(ename, 3, 1)='A';
--Q6. 이름에 'A'를 포함하지 않는 직원
select * from employee where ename not like '%A%';
select * from employee where instr(ename, 'A') =0;

--is null/ is not null
select ename, commission from employee;
--Q1. 보너스를 받는 직원의 정보만 추출
select * from employee where commission is not null;

--order by: 주어진 컬럼을 기준으로 오름차순(asc)/ 내림차순(desc)정렬하여 추출할 때
--Q1. 직원의 급여를 기준으로 오름차순 정렬하여 추출
select * from employee order by salary;
--Q2. 직원의 부서번호를 기준으로 오름차순, 정렬 결과에서 급여를 기준으로 내림차순정렬
select * from employee order by dno, salary desc;
--Q3. 가장 최근에 입사한 직원순으로 추출
select *from employee order by hiredate desc;

--문자 함수
-- upper, lower, initcap
-- length, lengthb
-- concat = ||
--substr(문자, 시작위치, 글자수), substrb
-- instr(문자데이터, 찾을 글자) => 위치 반환 0 = 문자열에 그 글자가 없음
--lpad(left padding): 왼쪽에 생긴 공백의 크기만큼 특정 문자로 채우는 함수
--rpad(right padding): 오른쪽에       ''

select*from employee;
select rpad(salary, 10, '!') from employee;
select lpad(salary, 10, ' ') from employee;

-- trim: 공백을 제거하는 함수
-- ltrim(문자) / rtrim(문자): 왼쪽/오른쪽의 공백 제거
select '   Oracle' from dual;
select ltrim('   Oracle') from dual;

-- 그룹함수
-- sum, avg, max, min
-- count: 해당 컬럼의 null이 아닌 행의 수, count(*): 해당 테이블의 레코드 수
select count(*) from employee;

--group by 절
--사원테이블의 직원 급여의 총합을 추출하시오.
select ename, sum(salary) from employee; -- error
--부서별 급여의 총합을 추출하되 부서번호와 급여의 총합이 표시되도록 하시오.
select dno, sum(salary) from employee group by dno;

-- 소속부서별 평균 급여를 추출하시오.
select dno, avg(salary) from employee group by dno;

--부서별 사원 수와 커미션을 받는 사원의 수를 추출하시오.
select dno, count(*), count(commission) from employee
group by dno;

-- 직군의 종류의 개수를 추출하시오
select distinct job from employee; 

--having 절
-- Q1. 부서별 평균급여가 2000이상인 부서의 번호와 부서별 평균 급여를 추출하시오
select e.dno, dname, round(avg(salary), 2) from employee e, department d
where e.dno=d.dno
group by e.dno, dname
having round(avg(salary), 2) >= 2000;
--Q2. 부서별 최대급여와 최소급여를 추출하되, 최대급여가 2900이상인 부서만 추출하시오.
select dno, max(salary), min(salary) from employee
group by dno
having max(salary) >=2900;

--다중그룹
select dno, job, count(*), sum(salary)
from employee
group by dno, job
order by dno, job;

--조인
-- 실무에서는 내부조인(equi join)과 외부조인(outer join)
--INNER join: 내부조인, 특정 컬럼을 기준으로 정확하게 일치하는 행들만 추출하는 join(교집합)
--inner join ~ on 조건 /inner join ~ using() - 겹치는 컬럼 구분 안 해도 됨
select * from employee e inner join department d
on e.dno=d.dno;

--outer join: 일치하지 않는 값도 추출
--left outer join
-- left outer join-: left only
-- right outer join
--right outer join-: right only

create table food_a( id number(1) primary key, fname varchar2(20) not null);
create table food_b(id number (1) primary key, fname varchar2(20) not null);

insert into food_a values(1, '돈가스');
insert into food_a values(2, '삼겹살');
insert into food_a values(3, '초밥');
insert into food_a values(4, '곱창전골');

insert into food_b values(1, '초밥');
insert into food_b values(2, '돈가스');
insert into food_b values(3, '칼국수');
insert into food_b values(4, '햄버거');

select * from food_a;
select * from food_b;

--inner join
select * from food_a, food_b
where food_a.fname=food_b.fname;

select * from food_a a inner join food_b b
on a.fname=b.fname;

--outer join: letf outer join, A left outer join B(A는 모두 추출되고 B는 A와 매칭되는 행만 추출
select * from food_a a left outer join food_b b
on a.fname=b.fname; -- food_b의 칼국수와 햄버거는 매칭이 되지 않아 null

--left outer join- : A left outer join B ~ where B.id is null (B와 중복된 값을 뺀 순수A만 추출)
select * from food_a a left outer join food_b b
on a.fname=b.fname
where b.id is null;

--right outer join: A right outer join B(B는 모두 추출되고 A는 B와 매칭되는 행만 추출)
select * from food_a a right outer join food_b b
on a.fname=b.fname;

--right outer join- : A right outer join B ~ where A.id is null (A와 중복된 값을 뺀 순수B만 추출)
select * from food_a a right outer join food_b b
on a.fname=b.fname
where a.id is null;

--Q1.  equi join 을 이용하여 scott 사원의 부서번호와 부서명을 추출하시오
select ename, e.dno, dname from employee e, department d
where e.dno=d.dno and ename='SCOTT';

--Q2. inner join 과 on 연산자를 이용하여 사원이름과 해당 사원이 소속된 부서명 그리고 부서의 지역명을 추출하시오.
select ename, dname, loc
from employee e inner join department d
on e.dno=d.dno;

--Q3. inner join과 using연산자를 이용하여 부서번호가 10번에 해당하는 사원의 담당업무와 부서의 지역명을 추출하시오 
select dno, ename, job, loc
from employee inner join department
using(dno) 
where dno = 10;

--Q4. natural join 을 사용하여 commission 을 받는 사원의 이름과 부서이름, 지역명을 추출하시오
select ename, dname, loc
from employee e, department d
where e.dno=d.dno and commission is not null;

select ename, dname, loc
from employee natural join department -- natural 조인은 조인조건을 따로 달지 않아도 겹치는 컬럼 기준으로 조인시켜줌
where commission is not null;












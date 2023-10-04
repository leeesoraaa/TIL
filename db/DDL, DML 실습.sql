--데이터 정의어: DDL
-- 데이터베이스의 구조를 생성하는 명령어 create
-- 데이터베이스의 구조를 변경하는 명령어 alter
-- 데이터베이스의 구조를 삭제하는 명령어 drop / cascade - 제약조건(연쇄)
-- 데이터베이스의 구조에 이름을 변경하는 명령어 rename

-- 데이터베이스 구조: 테이블(기본), 뷰, 인덱스, 시퀀스, 시스템카달로그, ...
-- Q1. 상품(product)테이블을 생성하시오.
create table product(num number(2), name varchar(5), price number, qty number);
desc product

--Q2. 부서(dept) 테이블을 생성하시오. 
create table dept (dno number(2), dname varchar(4), loc varchar(5));
desc dept

-- 기존에 존재하는 테이블을 이용하여 새로운 테이블 생성: as 절
create table dept_second as select * from department;
desc dept_second
select * from dept_second;
select * from tab;

--Q3. 사원테이블의 직급이 SALESMAN에 해당하는 사원의 정보만 새로운 테이블 sales 로 구조와 내용을 복사하시오.
create table sales as select * from employee where job='SALESMAN';

--Q4. 사원테이블에 사원번호, 사원명, 입사일자, 급여컬럼을 이용하여 emp_second라는 테이블을 생성하시오.
create table emp_second as select eno, ename, hiredate, salary from employee;

--Q5. 부서테이블의 구조만 복사하여 dept_third라는 이름의 테이블을 생성하시오.
create table dept_third as select * from department where 0=1;

select * from sales;
select * from emp_second;
select * from dept_third;

-- alter table ~ add()
-- Q5. 사원정보 테이블에 날짜형태의 데이터를 담는 birth 라는 이름의 컬럼을 추가하시오.
alter table employee add(birth date);
select* from employee;

--alter table ~ modify
-- 수정하려는 칼럼에 내용이 있는 경우: 크기는 기존 자료형보다 커야함
-- 수정하려는 칼럼에 내용이 없는 경우: 크기와 자료형 변경 가능
--Q6. 사원테이블의 사원이름의 크기를 변경하시오.
create table emp as select * from employee;
select*from emp;
desc emp
alter table emp modify ename varchar2(10);

-- alter table ~ drop column 컬럼명
desc employee
alter table employee drop column birth;

--test를 sample로 변경
rename test to sample;

--drop table 테이블명;
drop table dept01;

--DML
--Q7. 기존의 부서테이블에서 데이터를 제외하고 구조만 복사해서 dept_copy 생성하시오.
create table dept_copy as select * from department where 0=1;
desc dept_copy
select * from dept_copy;

--레코드 삽입 방법1
insert into dept_copy(dno,dname,loc)
values(11, '개발부', '서울시');

--레코드 삽입 방법2: 모든 컬럼에 레코드를 삽입할 때 컬럼명 생략가능
insert into dept_copy values(22, '홍보부', '부산시');

--레코드 삽입 방법3: 특정 컬럼에만 레코드 삽입할 때 
 insert into dept_copy (dno, loc) values(33, '대전시');

--레코드 삽입 방법4: values 대신 서브쿼리를 이용하여 다른 테이블 속 레코드 복사 가능
-- dept_copy 테이블 삭제
drop table dept_copy;

-- department 테이블의 구조만 이용하여 dept_copy 테이블 생성
create table dept_copy as select * from department where 0=1;

insert into dept_copy select * from department; --컬럼명과 컬럼의 수는 일치해야한다.

-- Q8. dept_copy 테이블의 부서명을 모두 HR로 변경하시오. 
update dept_copy set dname = 'HR';

-- 서브쿼리를 이용하여 다른 테이블에 저장된 데이터로 해당 컬럼의 값을 변경할 수 있다.
--Q9. 부서테이블의 모든 지역명을 부서번호가 20에 해당하는 부서의 지역으로 변경하시오.
update dept_copy set loc = (select loc from dept_copy where dno=20);

-- dept_copy 테이블의 부서명을 'aaa'로 변경하고 부서번호를 33으로 변경하시오.
update dept_copy set dname = 'aaa', dno=33;

--dept_copy 테이블의 레코드 전체 삭제 
delete from dept_copy; -- 전체 삭제할 때 *를 쓰지 않음

--department 테이블의 레코드를 dept_copy테이블에 추가하시오.
insert into dept_copy select * from department; -- as쓰지 않음

delete from dept_copy where dname='SALES';
select*from dept_copy;

--서브쿼리를 이용하여 레코드 삭제하기
-- 사원정보테이블의 구조와 내용을 복사하여 emp 라는 이름의 테이블을 생성한다.
drop table emp;
create table emp as select * from employee;
select* from emp;

--Q11. 부서명이 SALES에 해당하는 사원의 정보를 emp 테이블에서 삭제하는 작업을 수행하시오.
--(1) 부서정보를 가지고 있는 테이블에서 SALES라는 부서명에 해당하는 부서번호를 추출함.
select dno from department where dname='SALES'; --30
--(2) 위에서 찾은 부서번호가 30번에 해당하는 사원의 정보를 삭제하는 작업을 수행한다
delete from emp where dno=30;

delete from emp where dno = (select dno from department where dname='SALES');



















-- 데이터 무결성 제약조건(CONSTRAINT) : 유효성 검사
-- 테이블에 부적절한 데이터의 입력을 방지하기 위해 테이블을 생성할 때 기술하는 여러 규칙들
-- 컬럼 하나 당 제약규칙은 하나만 담을 수 있음
--1. not null: 생략 불가능,  null-생략가능(기본형)
--2. unique: 중복 불가능, 유일성
--3. primary key: 기본키(not null + unique)
--4. foreign key: 외래키(다른 테이블을 참조할 때)
--5. check: 유효성 검사 규칙, 입력값에 범위를 부여하는 것

drop table dept;
create table dept(dno number(2), dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '서울시');
select * from dept;
insert into dept(dname, loc) values('bbb', '대전시');
insert into dept(dno, loc) values(33, '춘천시');

--NOT NULL 제약 규칙
drop table dept;
create table dept(dno number(2) not null, dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '서울시');
select * from dept;
insert into dept(dname, loc) values('bbb', '대전시'); -- error
insert into dept(dno, loc) values(11, '춘천시'); -- 동일한 dno 를 가지지만 error 아님

-- UNIQUE 제약규칙
drop table dept;
create table dept(dno number(2) unique, dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '서울시');
select * from dept;
insert into dept(dname, loc) values('bbb', '대전시');
insert into dept(dno, loc) values(33, '춘천시');
insert into dept values(11, 'ddd', '부산시'); -- error

--PRIMARY KEY => 기본키
-- 기본키는 레코드를 식별할 용도로 사용하는 키로 중복을 허용하지 않고, 생략이 불가능하다
drop table dept;
create table dept(dno number(2) primary key, dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '서울시');
select * from dept;
insert into dept(dname, loc) values('bbb', '대전시'); -- error
insert into dept(dno, loc) values(11, '춘천시'); -- error

-- foreign key: 외래키, 참조무결성
-- 테이블 사이의 관계를 발생시키는 제약조건
-- 참조하는 테이블의 컬럼에 기본키(primary key)를 설정한다.

drop table emp;
desc employee;
create table emp(eno number(4) primary key, ename varchar2(20) not null, dno number(2) constraint fkfk_dno references dept(dno)); 
 
 insert into emp values(1111, 'aaa', 10);
 insert into emp values(2222, 'bbb', 20);
 insert into emp values(3333, 'ccc', 10);
 insert into emp values(4444, 'ddd', 30);
 insert into emp values(5555, 'eee', 10);
select * from emp; 

drop table dept;
create table dept(dno number(2) primary key, dname varchar2(20), loc varchar2(20));
desc dept
insert into dept values(10, '홍보부', '서울시');
insert into dept values(20, '영업부', '춘천시');
insert into dept values(30, '개발부', '대전시');
select * from dept;

insert into emp values(6666, 'kkk', 40); --error (dept 부서번호에 40이 없기 때문)

--부서번호가 40번인 직원정보 삭제
delete from emp where dno=40;

-- 테이블을 생성한 후 외래키 설정
alter table emp add constraint fk_ddd foreign key(dno) references dept(dno); -- fk_dno는 제약조건의 이름(마음대로 설정)

-- 외래키 조회: user_constraints, uset_cons_columnas 딕셔너리를 이용해서 외래키 조회
select a.constraint_name, a.table_name, b.column_name, a.constraint_type, a.r_constraint_name
from user_constraints a, user_cons_columns b
where a.constraint_name = b.constraint_name;

-- check: 유효성 검사 규칙, 특정 컬럼에 입력되는 값에 범위를 설정하는 기능
drop table emp01;
create table emp01(eno number(4) primary key, ename varchar2(20), salary number(7, 2) constraint sal check(salary>1000));
insert into emp01 values(1111, 'aaa', 890); --error(salary가 1000보다 작기 때문)
































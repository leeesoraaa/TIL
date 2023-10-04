-- 데이터 무결성 제약 조건
-- NOT NULL
drop table dept cascade constraints;
create table dept as select * from department; 
select * from dept;
desc dept

insert into dept values(50, '개발부', '서울시');
insert into dept values(50, '영업부', '춘천시');
insert into dept (dno, dname) values(50, 'DB');

drop table dept;
create table dept(dno number(2) not null, dname varchar2(14) not null, loc varchar2(13) not null);

insert into dept values(10, '개발부', '서울시');
insert into dept values(20, '홍보부', '광주시');
insert into dept(dno, dname) values(50, '개발부'); -- error
insert into dept values(20, '영업부', '부산시');

-- UNIQUE
drop table emp;
create table emp (eno number(4) unique, ename varchar2(14) not null, job varchar2(14), salary number(7));
desc emp;

insert into emp values(1111, '이소라', '부장', 1000);
insert into emp values(1111, '이순신', '과장', 800); -- error
insert into emp(ename, job, salary) values('이순신', '과장', 800);

--PRIMARY KEY
drop table emp;
create table emp (eno number(4) primary key, ename varchar2(14) not null, job varchar2(14), salary number(7));

desc emp;

insert into emp values(1111, '이소라', '부장', 1000);
insert into emp values(1111, '이순신', '과장', 800); --error
insert into emp values(2222, '이순신', '과장', 800);
insert into emp(ename, job, salary) values('홍길동', '대리', 700); --error
insert into emp(eno, ename) values(3333, '장보고');

--FOREIGN KEY
-- 부서테이블(dept): dno(기본키) =>부모테이블
-- 사원테이블(emp): eno(기본키), dno(외래키) =>자식테이블
drop table dept;
drop table emp;

create table dept (dno number(2) primary key, dname varchar2(14), loc varchar2(13));

insert into dept values(10, '개발부', '서울');
insert into dept values(20, '홍보부', '춘천');
insert into dept values(30, '영업부', '강릉');
insert into dept values(40, '회계부', '속초');
select * from dept;

create table emp(eno number(4) primary key, ename varchar2(14) not null, job varchar2(20), salary number, dno number(2) 
constraint emp_dno_fk references dept(dno));

insert into emp values(1111, '이소라', '부장', 1000, 10);
insert into emp values(2222, '이소라', '과장', 800, 30);
insert into emp values(3333, '이순신', '대리', 600, 50); -- error

-- CHECK
drop table sample;
create table sample(
name varchar2(20),
age number constraint ch_age check(age > 0 and age< 150),
gender char(1) constraint ch_gender check(gender in ('M', 'W')),
id number primary key);

insert into sample values('홍길동', 30, 'M', 1);
insert into sample values('장보고', 25, 'M', 2);
insert into sample values('유관순', -100, 'W', 3); --error














-- ������ ���Ἲ ���� ����
-- NOT NULL
drop table dept cascade constraints;
create table dept as select * from department; 
select * from dept;
desc dept

insert into dept values(50, '���ߺ�', '�����');
insert into dept values(50, '������', '��õ��');
insert into dept (dno, dname) values(50, 'DB');

drop table dept;
create table dept(dno number(2) not null, dname varchar2(14) not null, loc varchar2(13) not null);

insert into dept values(10, '���ߺ�', '�����');
insert into dept values(20, 'ȫ����', '���ֽ�');
insert into dept(dno, dname) values(50, '���ߺ�'); -- error
insert into dept values(20, '������', '�λ��');

-- UNIQUE
drop table emp;
create table emp (eno number(4) unique, ename varchar2(14) not null, job varchar2(14), salary number(7));
desc emp;

insert into emp values(1111, '�̼Ҷ�', '����', 1000);
insert into emp values(1111, '�̼���', '����', 800); -- error
insert into emp(ename, job, salary) values('�̼���', '����', 800);

--PRIMARY KEY
drop table emp;
create table emp (eno number(4) primary key, ename varchar2(14) not null, job varchar2(14), salary number(7));

desc emp;

insert into emp values(1111, '�̼Ҷ�', '����', 1000);
insert into emp values(1111, '�̼���', '����', 800); --error
insert into emp values(2222, '�̼���', '����', 800);
insert into emp(ename, job, salary) values('ȫ�浿', '�븮', 700); --error
insert into emp(eno, ename) values(3333, '�庸��');

--FOREIGN KEY
-- �μ����̺�(dept): dno(�⺻Ű) =>�θ����̺�
-- ������̺�(emp): eno(�⺻Ű), dno(�ܷ�Ű) =>�ڽ����̺�
drop table dept;
drop table emp;

create table dept (dno number(2) primary key, dname varchar2(14), loc varchar2(13));

insert into dept values(10, '���ߺ�', '����');
insert into dept values(20, 'ȫ����', '��õ');
insert into dept values(30, '������', '����');
insert into dept values(40, 'ȸ���', '����');
select * from dept;

create table emp(eno number(4) primary key, ename varchar2(14) not null, job varchar2(20), salary number, dno number(2) 
constraint emp_dno_fk references dept(dno));

insert into emp values(1111, '�̼Ҷ�', '����', 1000, 10);
insert into emp values(2222, '�̼Ҷ�', '����', 800, 30);
insert into emp values(3333, '�̼���', '�븮', 600, 50); -- error

-- CHECK
drop table sample;
create table sample(
name varchar2(20),
age number constraint ch_age check(age > 0 and age< 150),
gender char(1) constraint ch_gender check(gender in ('M', 'W')),
id number primary key);

insert into sample values('ȫ�浿', 30, 'M', 1);
insert into sample values('�庸��', 25, 'M', 2);
insert into sample values('������', -100, 'W', 3); --error














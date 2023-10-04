-- ������ ���Ἲ ��������(CONSTRAINT) : ��ȿ�� �˻�
-- ���̺� �������� �������� �Է��� �����ϱ� ���� ���̺��� ������ �� ����ϴ� ���� ��Ģ��
-- �÷� �ϳ� �� �����Ģ�� �ϳ��� ���� �� ����
--1. not null: ���� �Ұ���,  null-��������(�⺻��)
--2. unique: �ߺ� �Ұ���, ���ϼ�
--3. primary key: �⺻Ű(not null + unique)
--4. foreign key: �ܷ�Ű(�ٸ� ���̺��� ������ ��)
--5. check: ��ȿ�� �˻� ��Ģ, �Է°��� ������ �ο��ϴ� ��

drop table dept;
create table dept(dno number(2), dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '�����');
select * from dept;
insert into dept(dname, loc) values('bbb', '������');
insert into dept(dno, loc) values(33, '��õ��');

--NOT NULL ���� ��Ģ
drop table dept;
create table dept(dno number(2) not null, dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '�����');
select * from dept;
insert into dept(dname, loc) values('bbb', '������'); -- error
insert into dept(dno, loc) values(11, '��õ��'); -- ������ dno �� �������� error �ƴ�

-- UNIQUE �����Ģ
drop table dept;
create table dept(dno number(2) unique, dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '�����');
select * from dept;
insert into dept(dname, loc) values('bbb', '������');
insert into dept(dno, loc) values(33, '��õ��');
insert into dept values(11, 'ddd', '�λ��'); -- error

--PRIMARY KEY => �⺻Ű
-- �⺻Ű�� ���ڵ带 �ĺ��� �뵵�� ����ϴ� Ű�� �ߺ��� ������� �ʰ�, ������ �Ұ����ϴ�
drop table dept;
create table dept(dno number(2) primary key, dname varchar2(14), loc varchar2(13));
insert into dept values(11, 'aaa', '�����');
select * from dept;
insert into dept(dname, loc) values('bbb', '������'); -- error
insert into dept(dno, loc) values(11, '��õ��'); -- error

-- foreign key: �ܷ�Ű, �������Ἲ
-- ���̺� ������ ���踦 �߻���Ű�� ��������
-- �����ϴ� ���̺��� �÷��� �⺻Ű(primary key)�� �����Ѵ�.

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
insert into dept values(10, 'ȫ����', '�����');
insert into dept values(20, '������', '��õ��');
insert into dept values(30, '���ߺ�', '������');
select * from dept;

insert into emp values(6666, 'kkk', 40); --error (dept �μ���ȣ�� 40�� ���� ����)

--�μ���ȣ�� 40���� �������� ����
delete from emp where dno=40;

-- ���̺��� ������ �� �ܷ�Ű ����
alter table emp add constraint fk_ddd foreign key(dno) references dept(dno); -- fk_dno�� ���������� �̸�(������� ����)

-- �ܷ�Ű ��ȸ: user_constraints, uset_cons_columnas ��ųʸ��� �̿��ؼ� �ܷ�Ű ��ȸ
select a.constraint_name, a.table_name, b.column_name, a.constraint_type, a.r_constraint_name
from user_constraints a, user_cons_columns b
where a.constraint_name = b.constraint_name;

-- check: ��ȿ�� �˻� ��Ģ, Ư�� �÷��� �ԷµǴ� ���� ������ �����ϴ� ���
drop table emp01;
create table emp01(eno number(4) primary key, ename varchar2(20), salary number(7, 2) constraint sal check(salary>1000));
insert into emp01 values(1111, 'aaa', 890); --error(salary�� 1000���� �۱� ����)
































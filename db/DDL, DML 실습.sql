--������ ���Ǿ�: DDL
-- �����ͺ��̽��� ������ �����ϴ� ��ɾ� create
-- �����ͺ��̽��� ������ �����ϴ� ��ɾ� alter
-- �����ͺ��̽��� ������ �����ϴ� ��ɾ� drop / cascade - ��������(����)
-- �����ͺ��̽��� ������ �̸��� �����ϴ� ��ɾ� rename

-- �����ͺ��̽� ����: ���̺�(�⺻), ��, �ε���, ������, �ý���ī�޷α�, ...
-- Q1. ��ǰ(product)���̺��� �����Ͻÿ�.
create table product(num number(2), name varchar(5), price number, qty number);
desc product

--Q2. �μ�(dept) ���̺��� �����Ͻÿ�. 
create table dept (dno number(2), dname varchar(4), loc varchar(5));
desc dept

-- ������ �����ϴ� ���̺��� �̿��Ͽ� ���ο� ���̺� ����: as ��
create table dept_second as select * from department;
desc dept_second
select * from dept_second;
select * from tab;

--Q3. ������̺��� ������ SALESMAN�� �ش��ϴ� ����� ������ ���ο� ���̺� sales �� ������ ������ �����Ͻÿ�.
create table sales as select * from employee where job='SALESMAN';

--Q4. ������̺� �����ȣ, �����, �Ի�����, �޿��÷��� �̿��Ͽ� emp_second��� ���̺��� �����Ͻÿ�.
create table emp_second as select eno, ename, hiredate, salary from employee;

--Q5. �μ����̺��� ������ �����Ͽ� dept_third��� �̸��� ���̺��� �����Ͻÿ�.
create table dept_third as select * from department where 0=1;

select * from sales;
select * from emp_second;
select * from dept_third;

-- alter table ~ add()
-- Q5. ������� ���̺� ��¥������ �����͸� ��� birth ��� �̸��� �÷��� �߰��Ͻÿ�.
alter table employee add(birth date);
select* from employee;

--alter table ~ modify
-- �����Ϸ��� Į���� ������ �ִ� ���: ũ��� ���� �ڷ������� Ŀ����
-- �����Ϸ��� Į���� ������ ���� ���: ũ��� �ڷ��� ���� ����
--Q6. ������̺��� ����̸��� ũ�⸦ �����Ͻÿ�.
create table emp as select * from employee;
select*from emp;
desc emp
alter table emp modify ename varchar2(10);

-- alter table ~ drop column �÷���
desc employee
alter table employee drop column birth;

--test�� sample�� ����
rename test to sample;

--drop table ���̺��;
drop table dept01;

--DML
--Q7. ������ �μ����̺��� �����͸� �����ϰ� ������ �����ؼ� dept_copy �����Ͻÿ�.
create table dept_copy as select * from department where 0=1;
desc dept_copy
select * from dept_copy;

--���ڵ� ���� ���1
insert into dept_copy(dno,dname,loc)
values(11, '���ߺ�', '�����');

--���ڵ� ���� ���2: ��� �÷��� ���ڵ带 ������ �� �÷��� ��������
insert into dept_copy values(22, 'ȫ����', '�λ��');

--���ڵ� ���� ���3: Ư�� �÷����� ���ڵ� ������ �� 
 insert into dept_copy (dno, loc) values(33, '������');

--���ڵ� ���� ���4: values ��� ���������� �̿��Ͽ� �ٸ� ���̺� �� ���ڵ� ���� ����
-- dept_copy ���̺� ����
drop table dept_copy;

-- department ���̺��� ������ �̿��Ͽ� dept_copy ���̺� ����
create table dept_copy as select * from department where 0=1;

insert into dept_copy select * from department; --�÷���� �÷��� ���� ��ġ�ؾ��Ѵ�.

-- Q8. dept_copy ���̺��� �μ����� ��� HR�� �����Ͻÿ�. 
update dept_copy set dname = 'HR';

-- ���������� �̿��Ͽ� �ٸ� ���̺� ����� �����ͷ� �ش� �÷��� ���� ������ �� �ִ�.
--Q9. �μ����̺��� ��� �������� �μ���ȣ�� 20�� �ش��ϴ� �μ��� �������� �����Ͻÿ�.
update dept_copy set loc = (select loc from dept_copy where dno=20);

-- dept_copy ���̺��� �μ����� 'aaa'�� �����ϰ� �μ���ȣ�� 33���� �����Ͻÿ�.
update dept_copy set dname = 'aaa', dno=33;

--dept_copy ���̺��� ���ڵ� ��ü ���� 
delete from dept_copy; -- ��ü ������ �� *�� ���� ����

--department ���̺��� ���ڵ带 dept_copy���̺� �߰��Ͻÿ�.
insert into dept_copy select * from department; -- as���� ����

delete from dept_copy where dname='SALES';
select*from dept_copy;

--���������� �̿��Ͽ� ���ڵ� �����ϱ�
-- ����������̺��� ������ ������ �����Ͽ� emp ��� �̸��� ���̺��� �����Ѵ�.
drop table emp;
create table emp as select * from employee;
select* from emp;

--Q11. �μ����� SALES�� �ش��ϴ� ����� ������ emp ���̺��� �����ϴ� �۾��� �����Ͻÿ�.
--(1) �μ������� ������ �ִ� ���̺��� SALES��� �μ��� �ش��ϴ� �μ���ȣ�� ������.
select dno from department where dname='SALES'; --30
--(2) ������ ã�� �μ���ȣ�� 30���� �ش��ϴ� ����� ������ �����ϴ� �۾��� �����Ѵ�
delete from emp where dno=30;

delete from emp where dno = (select dno from department where dname='SALES');



















--1. ������Ÿ��: ����Ŭ���� �����ϴ� �ڷ���
--char: �������� ���� ������, �Էµ� �ڷ��� ���̿� ������� ������ ���� ��ŭ ���� ���� ����
--varchar2: �������� ���� ������
-- number: ��ü�ڸ���, �Ҽ��� ���� �Ǽ�
-- date: ��¥ ������, timestamp(date�� Ȯ��� ����)

--2. ����Ŭ �����ͺ��̽� ����
--SQL*PLUS�� SQL ��ɾ�(DDL, DML, DCL)
-- ����� ����: ������(system, sys), �Ϲ� ����� ����(scott)
--����Ŭ ����: sqlplus id/pw
-- ���� ���� Ȯ��: show user
show user
--���� ���� ���: connect(=conn)
conn system/1234
--���̺� ����Ȯ��: desc ���̺��
desc employee
--������ ��ȸ: select 
--select [distinct] �÷��� [*=all] [as]
--from ���̺��
--[where ���ǽ�]
--[order by �÷��� asc/desc]
--[group by �÷���]
--[having �׷����ǽ�]

--����: �����, �����(��/�Ǵ�), ����
-- �����(+, -, *, /): ���� �Ǵ� ��¥�����͸� ��� ����
-- Q1. �� ������ ������ ����Ͽ� �����ȣ, �̸�, �޿�, ������ �����Ͻÿ�.
select eno, ename, salary, salary * 12 "����" from employee;

--������ �޿��� ���ʽ��� �̿��Ͽ� ����� ��
select eno, ename, salary, salary * 12 + commission "����" from employee; -- ������� null�� ������ �ʴ´�.
--NVL �Լ�: NULL���� Ư�������� �ٲ���
select eno, ename, salary, salary * 12 + nvl(commission,0) "����" from employee;

--�񱳿�����(���迬����)
--Q2. �޿��� 1500�̻��� ����� ���� ����
select * from employee where salary >= 1500;
--Q3. �μ���ȣ�� 10�� ����� ���� ����
select *from employee where  dno=10;
--Q4. SCOTT ����� ���� ����
select * from employee where ename='SCOTT';
--Q5. 1981�� ���� �Ի��� ������ ���� ����
select * from employee where hiredate<'1981/01/01';

--��������: �ϳ��̻��� ������ �����Ͽ� ����� ��
--AND
--OR
--NOT: ���� ������

--Q1. �μ���ȣ�� 10�̰� ������ 'MANAGER'�� ����� ���� ����
select *from employee where dno=10 and job='MANAGER';
--Q2. �μ���ȣ�� 10�̰ų� ������ 'MANAGER'�� ����� ���� ����
select*from employee where dno=10 or job='MANAGER';
--Q3.�μ���ȣ�� 10�� �ƴ� ������ ���� ����
select * from employee where not dno =10;
--Q4. �޿��� 1000���� 1500������ ���� ����
select * from employee where salary between 1000 and 1500;
--Q5. �޿��� 1000�̸��̰ų� 1500�ʰ��� �������� ����
select * from employee where salary not between 1000 and 1500;
--Q6. Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ��� ����
select * from employee where commission in(300, 500, 1400);

--LIKE������: ���ϵ�ī�幮��(_,%)�� �Բ����� ������ 
--Q1. ����� �̸��� 'F'�� �����ϴ� ���
select * from employee where ename like 'F%';
--Q2. �̸��� 'M'�� ���Ե� ����� ��������
select * from employee where ename like '%M%';
select * from employee where instr(ename, 'M') !=0;
--Q3. �̸��� 'N'���� ������ ���
select * from employee where ename like '%N';
select * from employee where substr(ename, -1,1)='N';
--Q4. �̸��� �ι�° ���ڰ� 'A'�� ���
select * from employee where ename like '_A%';
select * from employee where substr(ename, 2, 1)='A';
--Q5. �̸��� ����°���ڰ� 'A'�� ���
select * from employee where ename like'__A%';
select * from employee where substr(ename, 3, 1)='A';
--Q6. �̸��� 'A'�� �������� �ʴ� ����
select * from employee where ename not like '%A%';
select * from employee where instr(ename, 'A') =0;

--is null/ is not null
select ename, commission from employee;
--Q1. ���ʽ��� �޴� ������ ������ ����
select * from employee where commission is not null;

--order by: �־��� �÷��� �������� ��������(asc)/ ��������(desc)�����Ͽ� ������ ��
--Q1. ������ �޿��� �������� �������� �����Ͽ� ����
select * from employee order by salary;
--Q2. ������ �μ���ȣ�� �������� ��������, ���� ������� �޿��� �������� ������������
select * from employee order by dno, salary desc;
--Q3. ���� �ֱٿ� �Ի��� ���������� ����
select *from employee order by hiredate desc;

--���� �Լ�
-- upper, lower, initcap
-- length, lengthb
-- concat = ||
--substr(����, ������ġ, ���ڼ�), substrb
-- instr(���ڵ�����, ã�� ����) => ��ġ ��ȯ 0 = ���ڿ��� �� ���ڰ� ����
--lpad(left padding): ���ʿ� ���� ������ ũ�⸸ŭ Ư�� ���ڷ� ä��� �Լ�
--rpad(right padding): �����ʿ�       ''

select*from employee;
select rpad(salary, 10, '!') from employee;
select lpad(salary, 10, ' ') from employee;

-- trim: ������ �����ϴ� �Լ�
-- ltrim(����) / rtrim(����): ����/�������� ���� ����
select '   Oracle' from dual;
select ltrim('   Oracle') from dual;

-- �׷��Լ�
-- sum, avg, max, min
-- count: �ش� �÷��� null�� �ƴ� ���� ��, count(*): �ش� ���̺��� ���ڵ� ��
select count(*) from employee;

--group by ��
--������̺��� ���� �޿��� ������ �����Ͻÿ�.
select ename, sum(salary) from employee; -- error
--�μ��� �޿��� ������ �����ϵ� �μ���ȣ�� �޿��� ������ ǥ�õǵ��� �Ͻÿ�.
select dno, sum(salary) from employee group by dno;

-- �ҼӺμ��� ��� �޿��� �����Ͻÿ�.
select dno, avg(salary) from employee group by dno;

--�μ��� ��� ���� Ŀ�̼��� �޴� ����� ���� �����Ͻÿ�.
select dno, count(*), count(commission) from employee
group by dno;

-- ������ ������ ������ �����Ͻÿ�
select distinct job from employee; 

--having ��
-- Q1. �μ��� ��ձ޿��� 2000�̻��� �μ��� ��ȣ�� �μ��� ��� �޿��� �����Ͻÿ�
select e.dno, dname, round(avg(salary), 2) from employee e, department d
where e.dno=d.dno
group by e.dno, dname
having round(avg(salary), 2) >= 2000;
--Q2. �μ��� �ִ�޿��� �ּұ޿��� �����ϵ�, �ִ�޿��� 2900�̻��� �μ��� �����Ͻÿ�.
select dno, max(salary), min(salary) from employee
group by dno
having max(salary) >=2900;

--���߱׷�
select dno, job, count(*), sum(salary)
from employee
group by dno, job
order by dno, job;

--����
-- �ǹ������� ��������(equi join)�� �ܺ�����(outer join)
--INNER join: ��������, Ư�� �÷��� �������� ��Ȯ�ϰ� ��ġ�ϴ� ��鸸 �����ϴ� join(������)
--inner join ~ on ���� /inner join ~ using() - ��ġ�� �÷� ���� �� �ص� ��
select * from employee e inner join department d
on e.dno=d.dno;

--outer join: ��ġ���� �ʴ� ���� ����
--left outer join
-- left outer join-: left only
-- right outer join
--right outer join-: right only

create table food_a( id number(1) primary key, fname varchar2(20) not null);
create table food_b(id number (1) primary key, fname varchar2(20) not null);

insert into food_a values(1, '������');
insert into food_a values(2, '����');
insert into food_a values(3, '�ʹ�');
insert into food_a values(4, '��â����');

insert into food_b values(1, '�ʹ�');
insert into food_b values(2, '������');
insert into food_b values(3, 'Į����');
insert into food_b values(4, '�ܹ���');

select * from food_a;
select * from food_b;

--inner join
select * from food_a, food_b
where food_a.fname=food_b.fname;

select * from food_a a inner join food_b b
on a.fname=b.fname;

--outer join: letf outer join, A left outer join B(A�� ��� ����ǰ� B�� A�� ��Ī�Ǵ� �ุ ����
select * from food_a a left outer join food_b b
on a.fname=b.fname; -- food_b�� Į������ �ܹ��Ŵ� ��Ī�� ���� �ʾ� null

--left outer join- : A left outer join B ~ where B.id is null (B�� �ߺ��� ���� �� ����A�� ����)
select * from food_a a left outer join food_b b
on a.fname=b.fname
where b.id is null;

--right outer join: A right outer join B(B�� ��� ����ǰ� A�� B�� ��Ī�Ǵ� �ุ ����)
select * from food_a a right outer join food_b b
on a.fname=b.fname;

--right outer join- : A right outer join B ~ where A.id is null (A�� �ߺ��� ���� �� ����B�� ����)
select * from food_a a right outer join food_b b
on a.fname=b.fname
where a.id is null;

--Q1.  equi join �� �̿��Ͽ� scott ����� �μ���ȣ�� �μ����� �����Ͻÿ�
select ename, e.dno, dname from employee e, department d
where e.dno=d.dno and ename='SCOTT';

--Q2. inner join �� on �����ڸ� �̿��Ͽ� ����̸��� �ش� ����� �Ҽӵ� �μ��� �׸��� �μ��� �������� �����Ͻÿ�.
select ename, dname, loc
from employee e inner join department d
on e.dno=d.dno;

--Q3. inner join�� using�����ڸ� �̿��Ͽ� �μ���ȣ�� 10���� �ش��ϴ� ����� �������� �μ��� �������� �����Ͻÿ� 
select dno, ename, job, loc
from employee inner join department
using(dno) 
where dno = 10;

--Q4. natural join �� ����Ͽ� commission �� �޴� ����� �̸��� �μ��̸�, �������� �����Ͻÿ�
select ename, dname, loc
from employee e, department d
where e.dno=d.dno and commission is not null;

select ename, dname, loc
from employee natural join department -- natural ������ ���������� ���� ���� �ʾƵ� ��ġ�� �÷� �������� ���ν�����
where commission is not null;












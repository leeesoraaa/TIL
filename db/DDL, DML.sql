--������ ���Ǿ�(DDL): �����ͺ��̽��� ������ �����ϰ� �����ϰ� �����ϴ� ��ɾ�
-- 1. create table/view/user
-- �ڷ���(data type): �÷����� �Ӽ�
-- char(size): �������� ���� ������
-- varchar2(max size): �������� ���� ������
-- number(��üũ��, �Ҽ��� �ڸ���): ������ ���� �� �ִ� 40�ڸ�
-- date/ timestamp
-- Q1. ������ ���̺� emp01�� �����ϰ�, �����ȣ eno, ����̸� ename, ����޿� sal �� �÷����� ��Ƽ� �����Ͻÿ�.
--����� ���� ��Ģ(����): ���̺��, �÷���, ��Ÿ ���α׷� �ȿ��� ����ڰ� ���Ƿ� ������ ����ϴ� �̸��� �ۼ��ϴ� ��
-- �ݵ�� ���ڷ� ����, ���ڼ� 1~30��(oracle�� ���� �� ���� ����), ������(A~Z, ��ҹ���), ����(0~9), Ư������(_, $, #)�� ���԰���, �ߺ�/���� �Ұ���
create table emp01(eno number(4), ename varchar2(20), sal number);

--���̺� ���� Ȯ��
desc emp01

--������ �����ϴ� ���̺��� Ȱ���Ͽ� ���̺��� ������ �� �ִ�. :as��
create table emp02 as select * from emp01; --emp01 ���̺��� ������ ������ �״�� �����Ͽ� ���ο� ���̺� �����Ѵٴ� �ǹ�
desc emp02

create table emp as select * from employee;
select * from emp01;
select * from employee;

--������ �����ϴ� ���̺��� ������ �̿��Ͽ� ���ο� ���̺� ����
-- ���� ����
create table emp03 as select * from employee where 1=0;
desc emp03
select * from emp03;

--Q2. �μ���ȣ�� 30���� �ش��ϴ� ������� ������ ������ �ִ� ���̺� emp30�� �����Ͻÿ�.
create table emp30 as select * from employee where dno=30;

--2. alter table: ���� ���̺��� ������ �����ϴ� ��ɾ�
--���̺� ���� ���� ������ �÷��� �߰�, ����, ���� ���� �ִ�.
--  1) alter table ~ add: ���� ���̺� ���ο� �÷��� �߰��ϴ� ��ɾ�
select * from emp01;
alter table emp01 add(job varchar2(9));
desc emp01
--  2) alter table ~ modify: ���� ���̺� �÷��� �����ϴ� ��ɾ�
--   �ش� �÷��� �ڷᰡ ���� ���: ������ Ÿ��(0)�� �÷��� ũ��(0)
--   �ش� �÷��� �ڷᰡ �ִ� ���: ������ Ÿ��(x)�� �÷��� ũ��(0, ���� �÷��� ũ�⺸�� �ݵ�� �� Ŀ����)
alter table emp01 modify(job varchar2(30));
desc emp01
--  3) alter table ~ drop column: ���̺� �̹� �����ϴ� �÷��� �����ϴ� ��ɾ�
alter table emp01 drop column job;
desc emp01

--3. drop table: ���� ���̺��� �����ϴ� ��ɾ�
 drop table emp01;
 select * from tab;
 
 --4. rename: ������ ����ϴ� ���̺��� �̸��� �����ϴ� ��ɾ�
 rename emp to test;

-- ������ ���۾�(DML): ���̺��� ������ �߰�, ����, ����, �����ϴ� ��ɾ�
-- select ~ from: ����, �˻�
-- �μ����̺��� ������ �̿��Ͽ� dept01�̶�� ���̺��� �����Ͻÿ�.
create table dept01 as select * from department where 0=1;
select * from dept01;

-- insert into values: �߰�
insert into dept01(dno, dname, loc) values(11, '�ѹ���', '��õ��');
insert into dept01 values(22, '�����', '����');
insert into dept01(dno, dname) values (33, 'ȫ����');
insert into dept01(dno, loc) values(44, '�����');

-- update ~ set: ����
--���̺� ����� ���ڵ带 �����ϱ� ���� ����ϴ� ��ɾ�
-- ����! where ���� ������� ���� ��� ��� ���ڵ��� ���� �����ȴ�.
select*from test;
--��� ����� �μ���ȣ�� 30���� �����Ͻÿ�.
update test set dno=30;
--������ �޿��� 10%�λ���� �����Ͻÿ�.
update test set salary = salary*1.1;
--��� ������ �Ի����� ���� ��¥�� �����Ͻÿ�.
update test set hiredate = sysdate;

-- ������ SALESMAN�� ������ �μ���ȣ�� 40���� �����Ͻÿ�.
update test set dno=40 where job='SALESMAN';
-- ������ MANAGER�� ������ �޿��� 10%�λ��ϴ� �������� �ۼ��Ͻÿ�.
update test set salary = salary*1.1 where job='MANAGER';
--SCOTT ����� �μ���ȣ�� 20����, ������ MANAGER��, �޿��� 50, Ŀ�̼��� 4000���� �����ϴ� �������� �����Ͻÿ�.
update test set dno=20, job = 'MANAGER', salary=50, commission=4000 where ename ='SCOTT';

--Q3. 20�� �μ��� �������� 40�� �μ��� ���������� �����ϴ� ������ �ۼ��ϵ� ���������� �̿��Ͻÿ�.
--��,  department ���̺��� ������ ������ �̿��Ͽ� dept02 ���̺��� �����Ͽ� �۾��� ��
create table dept02 as select * from department;
update dept02 set loc = (select loc from dept02 where dno=40) where dno=20;
select * from dept02;

-- delete ~ from: ����
-- ���̺� ����� ���ڵ带 �����ϴ� ��ɾ�
-- where �������� ������ ��� ���ڵ� ����
delete from dept02;




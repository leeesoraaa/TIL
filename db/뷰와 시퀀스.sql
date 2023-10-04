-- ���� ���̺� ��(View)
-- ��(view): �������� ���̺��� �ٰŷ� ������� ���� ���̺�, ���̺� �����ʹ� ������ ���� ���� ���̺��� �������� �ʰ� sql�� ����Ǿ� �ִ�.
-- �⺻���̺�: �並 �����ϱ� ���ؼ� ���������� �����͸� ������ �ִ� �������� ���̺��� ���Ѵ�.
-- �ǽ��� dept ���̺�� emp ���̺� ����: department ���̺�� employee ���̺� ����
drop table dept cascade constraints;
drop table emp;

create table dept as select * from department;
create table emp as select * from employee;

select * from dept;
select * from emp;

--�並 �����ϴ� ���: create view ��� [�ɼ�]
-- �ɼ�: create or replace view, force, with check option, with read only

--Q1. �μ���ȣ�� 30���� �ش��ϴ� ������� ��ȣ, �̸�, �μ���ȣ�� �����Ͻÿ�.
select eno, ename, dno from emp where dno=30;

-- 30�� �μ��� �Ҽӵ� ������� ��ȣ, �̸�, �μ���ȣ�� ����ϱ� ���� select ���� �ϳ��� ��� �����ϱ�
create view emp_view30 as select eno, ename, dno from emp where dno=30;
select * from emp_view30;

--�並 ����ϴ� ����: �����ϰ� �� �������̳� ����ϰ� ����ϴ� �������� ��� �����ϸ� �����̳� �۾��� ȿ������ ���� �� �ִ�. ���ȿ� ����

--�� ����
drop view emp_view30; --���� ������ �⺻���̺� ������ ���� ������ �⺻���̺��� �����Ǹ� ��� �ڵ����� �����ȴ�.

-- ������(sequence): �Ϸù�ȣ�� ������ ������ �ִ� ���
-- ����Ŭ������ ���� �����ϱ� ���� �Ϲ������� ���� ���� �⺻Ű�� ����ϴ� ��찡 �ִ�. 
-- �⺻Űó�� �����Ұ�, �ߺ��Ұ�, �ڵ� ��ȣ �߻���
-- �������� ����: create sequence ��������
-- �ɼ�: start with => ���۹�ȣ, increment by =>������, maxvalue => �ִ밪
-- ������ ���� Ȯ���ϴ� ��ɾ�: currval(�������� ���簪), nextval(������)

-- ������ �����ϱ�
create sequence sample_seq; --1���� 1�� ��� �����Ǵ� ������

select sample_seq.nextval from dual; -- ���� ���� ������ ���簪�� �������� �ʱ� ������ ���������� �����ϰ� ���簪 ������

select sample_seq.currval from dual;

-- �����ȣ�� ������ �������� ������ ��ü�� �����Ͻÿ�
-- ���۰�: 1, 1�� ����, �ִ밪 100000�� �Ǵ� emp_seq�� ����
create sequence emp_seq start with 1 increment by 1 maxvalue 100000;

drop table emp01;
create table emp01(eno number primary key, ename varchar2(14), salary number);

insert into emp01 values(emp_seq.nextval, '�̼Ҷ�', 1000);
insert into emp01 values(emp_seq.nextval, '�̼Ҷ�', 1000);
insert into emp01 values(emp_seq.nextval, '�̼Ҷ�', 1000);
insert into emp01 values(emp_seq.nextval, '�̼Ҷ�', 1000);
insert into emp01 values(emp_seq.nextval, '�̼Ҷ�', 1000);
select * from emp01;



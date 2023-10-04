-- �ּ�(comment): ���α׷� ����� ������� �ڵ��� ������ ��� ���� ����ϴ� ����(��ȣ --,#, /* ~ */,//)
-- sql query: DB ǥ�� ��ɾ�, ������ �����ݷ�;
-- sql*plus ��ɾ�: oracle������ ��� ������ ��ɾ�, �� �� ��ɾ�

-- ���� ������ ����� ������ Ȯ���ϴ� ���
show user

-- scott ������ ������ �ִ� ��� ���̺��� ���(tab: table)�� �����ϴ� ���
select * from tab;

-- CRUD ��ɾ�: DML���� ��ɾ�
-- DDL: ���Ǿ�(create-����, alter-����, drop-����)
-- DML: ���۾�(select-����/�˻�, insert- �߰�, update-����, delete-����)
-- DCL: �����(commit-��������/�ݿ�, rollback-����, grant-���Ѻο�, revoke-��������)
-- Ʈ������(transaction): �����ͺ��̽��� ���� ����Ǵ� ��ɾ��� �������, �ϳ��� ����� ����Ǵ� ����

-- select ��ɾ�: ���̺� ����� �����͸� ���ڵ� ������ ����
--1. �⺻��: select �ʵ�� from ���̺��;
-- Q1. ���� ������ ��� �ִ� employee ���̺� ��ϵ� ��� ����� ������ �����Ͻÿ�.(*=all)
-- ���̺��� ������ Ȯ���ϴ� ���
desc employee
select * from employee;

-- Q2. ��������(employee) ���̺��� ������ ��ȣ, �̸�, ������ �����Ͻÿ�.
select eno, ename, job from employee;

-- Q3. ����(job)�� ���(clerk)�� �ش��ϴ� ����� ������ �����Ͻÿ�.
select * from employee where job = 'CLERK';

--%s: ���ڿ��� '' ���̱�

--2. Ȯ����: where�� - �־��� ������ ���� �͸� ������ �� ����ϴ� ��
-- ���ǽ�(or ������ or ��/�Ǵܹ�): �ݵ�� �� ����� �� �Ǵ� �������� �����Ǵ� ����
-- ������(operation): �ǿ����� ���̿� ������ �����ϱ� ���� ����ϴ� ��ȣ��
-- ���������: ��Ģ������ �����ϴ� �����ȣ(+, -, *, /)
-- Q4. ������ ������ ����ִ� ���̺� employee�� �̿��Ͽ� ���� ������ �̸��� �޿� �׸��� 10�� �λ�� �޿��� �����Ͻÿ�.
select ename, salary, salary + 10 from employee;

--��Ī(nickname): as��
select ename, salary, salary + 10 as "�λ�� �޿�" from employee;

--Q5. ���������� ��� �ִ� ���̺� ������ "analyst"�� �ش��ϴ� ������ �޿��� 500�� �λ��Ͽ� �����Ͻÿ�.
select ename, job, salary, salary + 500 "�λ� ��" from employee
where job = 'ANALYST';

--Q6. �������̺��� ������ ���ʽ��� ��ģ �ݾ��� �����ϵ� �ش� �÷����� �ѱ޿��� ǥ���Ͻÿ�.
select salary, commission, salary + commission "�ѱ޿�"
from employee;
-- null: ����ִٴ� �ǹ̷� 0�� �ƴ� ���� ��Ģ������ �Ұ���
-- nulll�� �ٸ� ������ ��ȯ�ϴ� �Լ�: NVL�Լ�, NVL(������, ��ü��)
select salary, nvl(commission, 0), salary + nvl(commission, 0) "�ѱ޿�"
from employee;

-- ���迬���� or �񱳿�����: �־��� ���ǿ� ���� �͸� ����
--Q7. �μ���ȣ(dno)�� 20�� ����� ������ �����Ͻÿ�.
select * from employee where dno = 20;

--Q8. �μ���ȣ�� 20�� �ƴ� ������ ������ �����Ͻÿ�.
select * from employee where dno ^= 20;
select * from employee where dno != 20;
select * from employee where dno <> 20;

--Q9. ����� �̸��� FORD�� ����� ���, �̸�, �޿��� �����Ͻÿ�.
select eno, ename, salary from employee where ename = 'FORD';

--Q10. �Ի����� 1982�� 1�� 1�� ���Ŀ� �ش��ϴ� ����� ������ �����Ͻÿ�.
--����, ��¥�� �ݵ�� Ȭ����ǥ �ȿ� ǥ���Ѵ�.
select * from employee where hiredate >= '82/01/01';

-- ��������: ����(��, ����)�� �̿��Ͽ� ������ �����ϴ� ������
-- �������� �񱳿����ڸ� �����Ͽ� ����� �� �� ����ϴ� ������
--and, or, not

--Q11. �μ���ȣ�� 10�̰� ������ MANAGER�� �ش��ϴ� ������ ������ �����Ͻÿ�.
select * from employee where dno = 10 and job='MANAGER';

--Q12. �μ���ȣ�� 10�̰ų� ������ MANAGER�� �ش��ϴ� ������ ������ �����Ͻÿ�.
select * from employee where dno=10 or job='MANAGER';

--Q13. �μ���ȣ�� 10�� �ƴ� ����� ������ �����Ͻÿ�.(3���� ������ ����Ͻÿ�.)
select * from employee where dno ^=10;
select * from employee where dno <>10;
select * from employee where dno != 10;

-- �������� ǥ������ �̿��� ��������
-- between ~ and: �ϳ��� �÷��� �������� ������ �ο��� �� ����ϴ� ������, ����, ����, ��¥���� ��밡��
--Q14. �޿��� 2000�̻� 3000���Ͽ� �ش��ϴ� ����� ������ �����Ͻÿ�.
select * from employee where salary >=2000 and salary <= 3000;
select * from employee where salary between 2000 and 3000;

--in: ���Կ��θ� �Ǵ��ϴ� ������ ǥ��
--Q15. �޿��� 2000�̸��̰ų� 3000�ʰ��� �ش��ϴ� ����� ������ �����Ͻÿ�.
select * from employee where salary < 2000 or salary > 3000;
select * from employee where salary not between 2000 and 3000;

--Q16. 1987�⿡ �Ի��� ����� ������ �����Ͻÿ�.
select * from employee where hiredate >= '87/01/01' and hiredate < '88/01/01';
select * from employee where hiredate between '87/01/01' and '87/12/31';

--Q17. �μ���ȣ�� 10�̰ų� 30�� �ش��ϴ� ����� ������ �����Ͻÿ�.
select * from employee where dno = 10 or dno = 30;
select * from employee where dno in(10, 30);
select * from employee where dno != 20;

-- !�� �ǹ̴� not�� ���Ѵ�.
select * from employee where dno not in(10, 30);

-- ���ɹ���, ���ϵ�ī�幮��(wild character): %, _ => ���α׷��� ������ ���ϵ幮�ڴ� *�� ?�� ���
-- ��ü����
-- '=' ��� ���ٴ� ���� like�� �����
-- %: ���� ���� ������� ��� ���ڸ� ����ϴ� ��ȣ
-- _: ���� �� ���ڸ� ��ü�ϴ� ���ɹ���

-- Q18. ����� �̸��� ù ���ڰ� 'M'�� �����ϴ� ���� ������ �����Ͻÿ�.
select * from employee where ename like 'M%';

--Q19. ����� �̸��� ������ ���ڰ� 'N'�� �ش��ϴ� ������ ������ �����Ͻÿ�.
select * from employee where ename like'%N';

--Q20. ������ �̸��� 'R'�� ���Ե� ������ ������ �����Ͻÿ�.
select * from employee where ename like '%R%';

--Q21. ���� �̸��� �ι�° ���ڰ� 'A'�� ������ ������ �����Ͻÿ�.
select * from employee where ename like '_A%';

--Q22. ���� �̸��� ù ���ڰ� 'M'�� �ƴ� ������ ������ �����Ͻÿ�.
select * from employee where ename not like 'M%';

-- is NULL / is NOT NULL
select commission from employee; 
select commission from employee where commission is null;
select * from employee where commission is not null;

--3. Ȯ����: ������ ���� order by ��
-- ����(sort): �־��� Ű ���� ���� ������� �����ϴ� ��
-- ���� ���: ��������(asc, ascending, ��������)�� ��������(desc, descending)
--  ����
--  ����: ���� ��(��������), ���� �ݴ��(��������)

-- Q23. ����� �޿��� �������� �������� �����Ͽ� �����Ͻÿ�.
select * from employee order by salary; -- ���Ĺ���� �����Ǹ� ������������ �����Ѵ�.

--Q24. �μ���ȣ�� �������� �������� �����Ͽ� �����Ͻÿ�. �� ��, ������ �μ���ȣ�� ������ �ִ� ������ �޿��� �������� �������� �����Ͻÿ�.
select * from employee order by dno, salary desc;
select * from employee order by salary desc, dno;

--Q25. ���� �ֱٿ� �Ի��� ��� ������� �����Ͻÿ�.
select * from employee order by hiredate desc;

-- distinct: ������ ������ �ߺ��Ǿ� ������� �ʵ��� �ϴ� �ɼ�
select distinct dno from employee;

-- ���Ῥ����: select�� ���ο� ���ڸ� ������ �� ����ϴ� ������, ||
select ename || ' �� ������ ' || job || ' �Դϴ�. ' from employee;

--�Լ�(Function): �ݺ������� �����ϴ� ����̳� ����� �ϳ��� ������� ��� �����ϴ� ��ɾ�
-- SQL ������ �Լ�: �Լ��� ����� �ϳ��� ������ ����ȴ�. 
--   ����: �����Լ�, �����Լ�, ��¥�Լ�, ����ȯ, �Ϲ��Լ�
-- SQL ������ �Լ� = �׷� �Լ�

-- dual ���̺�: �ӽ� ���̺�(���� �������� ������ �����ϴ� �� ó�� �������� ���̺�)
--   ������ �Լ��� ����� �����ϱ� ���� ���Ǵ� ������ ���̺�
-- 10 * 5
select 10*5 from dual;
desc dual
select * from dual;

--���� �ý����� ��¥�� �����ϴ� �Լ�
select sysdate from dual;

-- ���� �Լ�: ���� �����͸� ó���ϴ� �Լ�
--  ABS(): ���밪�� �����ϴ� �Լ�
select abs(-10) from dual;
desc dual
select -10, abs(-10) from dual;

--ROUND(����, �ڸ���): Ư�� �ڸ������� �ݿø��ϴ� �Լ�
--FLOOR(����): �Ҽ��� �Ʒ��� ������ �Լ�
select 34.5432 from dual;
select floor(34.5432) from dual;
select round(34.5432, 0) from dual;

select 34.5678, round(34.5678), round(34.5678, 2), round(34.5678, -1) from dual;
select 34.5678, round(34.5678,-2) from dual;

--MOD(����, ���� ��): ���ڸ� �ش� ���� ���� ������ ����� �������� �����ϴ� �Լ�
select mod(27, 5), mod(27, 7), mod(27, 2) from dual;

-- �ڿ��� ó��, NLP
-- UPPER, LOWER, LENGTH, LENGTHB, INSTR, SUBSTR ...























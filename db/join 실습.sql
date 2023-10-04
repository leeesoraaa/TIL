-- JOIN

--�ǽ��� ���̺� ��� Ȯ��
select * from tab;

--�ǽ��� ���̺��� ������ Ȯ��
select * from department; -- �μ�����(�μ���ȣ, �μ���, �μ���ġ)
select * from employee; -- �������(���, �̸�, ����, ���, �Ի���, �޿�, ���ʽ�, �μ���ȣ)
select * from salgrade; -- �޿� ���(���, �����޿�, �ְ�޿�)

--Q1. ��� ��ȣ�� 7788�� ����� �̸��� �Ҽ� �μ����� �����Ͻÿ�.
select eno, ename, dname
from employee e, department d
where e.eno=7788 and e.dno= d.dno;

--join ���ǿ� �ش��ϴ� �÷��� ��� using �Լ�
-- ���� where ������ ���� �������ǰ� �Ϲ� ������ �򰥸��� ������ ���� ������ using �Լ��� ��� ���
select ename, dname
from employee join department
using(dno)
where eno=7788;

--Q2. ������� �̸��� �޿� �׸��� �޿������ �����Ͻÿ�.
select ename, salary, grade
from employee, salgrade 
where salary between losal and hisal;

--Q3. ����� �̸��� �Ҽӵ� �μ��� �̸� �׸��� �޿�, �޿������ �����Ͻÿ�.
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno=d.dno and salary between losal and hisal;

--Q4. ����� �̸��� ���ӻ���� �̸��� �����Ͻÿ�.
select emp.ename ���, mag.ename ���
from employee emp, employee mag
where emp.manager=mag.eno;

select emp.ename ���, mag.ename ���
from employee emp, employee mag
where emp.manager=mag.eno(+); --manager�� null���� �ִ��� ���Խ��Ѷ�

--T1. SCOTT ����� �μ���ȣ�� �μ����� �����Ͻÿ�.
select ename, e.dno, dname
from employee e, department d
where e.dno=d.dno and ename='SCOTT';

--T2. ����� �̸��� �Ҽӵ� �μ��� �׸��� �μ��� ��ġ�� �����Ͻÿ�.
select ename, dname, loc
from employee e, department d
where e.dno=d.dno;

--T3. �μ���ȣ�� 10�� �ش��ϴ� ������� ������ �����Ͻÿ�.
select job
from employee e, department d
where e.dno=d.dno and d.dno=10;

--T4. Ŀ�̼��� �޴� ����� �̸��� �μ��̸�, �μ��������� �����Ͻÿ�.
select ename, dname, loc
from employee e, department d
where e.dno=d.dno and commission<>0;

--T5. ����� 'A'�� ���Ե� ����� �̸��� �μ����� �����Ͻÿ�.
select ename, dname
from employee e, department d
where e.dno=d.dno and ename like '%A%';

--T6. NEWYORK���� �ٹ��ϴ� ����� �̸��� ���� �׸��� �μ���ȣ�� �μ����� �����Ͻÿ�.
select ename, job, d.dno, dname
from employee e, department d
where e.dno=d.dno and loc='NEW YORK';

--T7. ����̸�, �����ȣ, ����̸�, �����ȣ�� �����Ͻÿ�
select e.ename ����̸�, e.eno �����ȣ, m.ename ����̸�, m.eno �����ȣ
from employee e, employee m
where e.manager=m.eno;







--sub query

--Q1. SCOTT ������� �޿��� ���� �޴� ����� �����Ͻÿ�.
select ename, salary
from employee
where salary > (select salary from employee where ename='SCOTT'); --������ ��������

--Q2. SCOTT�� ������ �μ����� �ٹ��ϴ� ����� ������ �����Ͻÿ�.
select * from employee where dno = (select dno from employee where ename='SCOTT');

--Q3. �ּұ޿��� �޴� ����� �̸�, ����, �޿��� �����Ͻÿ�.
select ename, job, salary
from employee
where salary=(select min(salary) from employee);

--Q4. 30�� �ּ��� ���� ���� �� �ּ� �޿��� �޴� ����� �޿����� �� ū �޿��� �޴� �μ��� ��ȣ�� �ּ� �޿��� �����Ͻÿ�.
select dno, min(salary)
from employee
group by dno
having min(salary)>(select min(salary) from employee where dno=30);

--������: where���� having��(�׷캰�� ������� ����� �������� ������ ��´�)

--Q5. �μ��� �ּұ޿��� �޴� ����� �����ȣ�� �̸��� �����Ͻÿ�.
select dno, min(salary) from employee group by dno; -- ������ �����
select eno, ename
from employee
where salary in (select min(salary) from employee group by dno);

--Q6. ������ ��������� �ƴϸ鼭 �޿��� ������ ������Ǻ��� ���� ����� ������ �����Ͻÿ�.
select * from employee
where job <> 'SALESMAN' and salary < any(select salary from employee where job = 'SALESMAN');









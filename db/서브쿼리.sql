--sub query

--Q1. SCOTT 사원보다 급여를 많이 받는 사원을 추출하시오.
select ename, salary
from employee
where salary > (select salary from employee where ename='SCOTT'); --단일행 서브쿼리

--Q2. SCOTT과 동일한 부서에서 근무하는 사원의 정보를 추출하시오.
select * from employee where dno = (select dno from employee where ename='SCOTT');

--Q3. 최소급여를 받는 사원의 이름, 직급, 급여를 추출하시오.
select ename, job, salary
from employee
where salary=(select min(salary) from employee);

--Q4. 30번 주서에 속한 직원 중 최소 급여를 받는 사원의 급여보다 더 큰 급여를 받는 부서의 번호와 최소 급여를 추출하시오.
select dno, min(salary)
from employee
group by dno
having min(salary)>(select min(salary) from employee where dno=30);

--조건절: where절과 having절(그룹별로 묶어놓은 결과를 기준으로 조건을 담는다)

--Q5. 부서별 최소급여를 받는 사원의 사원번호와 이름을 추출하시오.
select dno, min(salary) from employee group by dno; -- 다중행 결과값
select eno, ename
from employee
where salary in (select min(salary) from employee group by dno);

--Q6. 직급이 세일즈맨이 아니면서 급여가 임의의 세일즈맨보다 낮은 사원의 정보를 추출하시오.
select * from employee
where job <> 'SALESMAN' and salary < any(select salary from employee where job = 'SALESMAN');









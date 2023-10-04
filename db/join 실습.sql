-- JOIN

--실습용 테이블 목록 확인
select * from tab;

--실습용 테이블의 내용을 확인
select * from department; -- 부서정보(부서번호, 부서명, 부서위치)
select * from employee; -- 사원정보(사번, 이름, 직급, 상관, 입사일, 급여, 보너스, 부서번호)
select * from salgrade; -- 급여 등급(등급, 최저급여, 최고급여)

--Q1. 사원 번호가 7788인 사원의 이름과 소속 부서명을 추출하시오.
select eno, ename, dname
from employee e, department d
where e.eno=7788 and e.dno= d.dno;

--join 조건에 해당하는 컬럼을 담는 using 함수
-- 같은 where 조건을 쓰면 조인조건과 일반 조건이 헷갈리기 때문에 조인 조건을 using 함수로 묶어서 사용
select ename, dname
from employee join department
using(dno)
where eno=7788;

--Q2. 사원별로 이름과 급여 그리고 급여등급을 추출하시오.
select ename, salary, grade
from employee, salgrade 
where salary between losal and hisal;

--Q3. 사원의 이름과 소속된 부서의 이름 그리고 급여, 급여등급을 추출하시오.
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno=d.dno and salary between losal and hisal;

--Q4. 사원의 이름과 직속상관의 이름을 추출하시오.
select emp.ename 사원, mag.ename 상관
from employee emp, employee mag
where emp.manager=mag.eno;

select emp.ename 사원, mag.ename 상관
from employee emp, employee mag
where emp.manager=mag.eno(+); --manager에 null값이 있더라도 포함시켜라

--T1. SCOTT 사원의 부서번호와 부서명을 추출하시오.
select ename, e.dno, dname
from employee e, department d
where e.dno=d.dno and ename='SCOTT';

--T2. 사원의 이름과 소속된 부서명 그리고 부서의 위치를 추출하시오.
select ename, dname, loc
from employee e, department d
where e.dno=d.dno;

--T3. 부서번호가 10에 해당하는 사원들의 직급을 추출하시오.
select job
from employee e, department d
where e.dno=d.dno and d.dno=10;

--T4. 커미션을 받는 사원의 이름과 부서이름, 부서지역명을 추출하시오.
select ename, dname, loc
from employee e, department d
where e.dno=d.dno and commission<>0;

--T5. 사원명에 'A'가 포함된 사원의 이름과 부서명을 추출하시오.
select ename, dname
from employee e, department d
where e.dno=d.dno and ename like '%A%';

--T6. NEWYORK에서 근무하는 사원의 이름과 직급 그리고 부서번호와 부서명을 추출하시오.
select ename, job, d.dno, dname
from employee e, department d
where e.dno=d.dno and loc='NEW YORK';

--T7. 사원이름, 사원번호, 상관이름, 상관번호를 추출하시오
select e.ename 사원이름, e.eno 사원번호, m.ename 상관이름, m.eno 상관번호
from employee e, employee m
where e.manager=m.eno;







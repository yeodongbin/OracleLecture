문1 기계과 학생들 중 학년별 평균 신장이 160이상인
    학년과 평균 신장을 출력하시오.
select stu_grade, avg(stu_height)
from student
where stu_dept = '기계'
group by stu_grade
having avg(stu_height) > 160;

문2 최대 신장이 175이상인 학과와 학과별 최대신장을
    출력하시오.
select stu_dept, max(stu_height)
from student
group by stu_dept
having max(stu_height) > 175;


-Equl Join
= oracle join
select emp.empno, emp.ename, dept.dname
from emp, dept
where emp.deptno = dept.deptno;

select e.empno, e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno;

= Natural join
select emp.empno, emp.ename, dept.dname
from emp natural join dept;

= JOIN ~ USING
select emp.empno, emp.ename, dept.dname
from emp JOIN dept USING(deptno);

= JOIN ~ ON
select emp.empno, emp.ename, dept.dname
from emp JOIN dept ON emp.deptno = dept.deptno;

= INNER JOIN ~ ON
select emp.empno, emp.ename, dept.dname
from emp INNER JOIN dept ON emp.deptno = dept.deptno;

문3 학생들이 듣고 있는 과목 번호, 점수를 확인하시오.
    학번, 학생이름, 과목번호, 점수를 출력하시오.
select student.stu_no, student.stu_name, 
       enrol.sub_no, enrol.enr_grade
from student, enrol
where student.stu_no = enrol.stu_no
order by 1;

= natural join
select stu_no, stu_name, sub_no, enr_grade
from student natural join enrol;

= JOIN ~ USING
select stu_no, stu_name, sub_no, enr_grade
from student join enrol using(stu_no);

= JOIN ~ ON
select student.stu_no, stu_name, sub_no, enr_grade
from student join enrol on student.stu_no = enrol.stu_no;

= INNER JOIN ~ ON
select student.stu_no, stu_name, sub_no, enr_grade
from student inner join enrol 
on student.stu_no = enrol.stu_no;

문4 부서번호가 30이고, 급여가 1500이상인 사원의
    이름, 부서명, 급여를 출력하시오.(5가지 방식)
select ename, dname, sal
from emp, dept
where emp.deptno = dept.deptno
and (emp.deptno = 30 and emp.sal >=1500);

1) EQ JOIN
SELECT e.ename, d.dname, e.sal  
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND d.deptno = 30 
AND e.sal >= 1500; 

2) NATURAL JOIN
SELECT ename, dname, sal  
FROM emp Natural Join dept 
WHERE deptno = 30 
AND emp.sal >= 1500;

3) JOIN USING()
SELECT ename, dname, sal  
FROM emp JOIN dept USING (deptno)
WHERE deptno = 30 AND sal >= 1500;

4) JOIN ON
SELECT emp.ename, dept.dname, emp.sal  
FROM emp JOIN dept ON emp.deptno = dept.deptno
WHERE emp.deptno = 30 AND emp.sal >= 1500;

5) INNER JOIN ON
SELECT emp.ename, dept.dname, emp.sal  
FROM emp INNER JOIN dept ON emp.deptno = dept.deptno
WHERE emp.deptno = 30 AND emp.sal >= 1500;


문5 사원수가 5명이 넘는 부서의 부서명과 사원수를
    출력하시오.(5가지 방식)
select emp.deptno, dept.dname, count(*)
from emp, dept
where emp.deptno = dept.deptno
group by emp.deptno, dept.dname
having count(*) > 5;

문제 5번 정답입니다.
= oracle join
select dept.dname, count(*)
from dept, emp
where dept.deptno = emp.deptno
group by dept.dname
having count(emp.empno) > 5;

= natural join
select dept.dname, count(*)
from dept natural join emp
group by dept.dname
having count(emp.empno) > 5;

= join ~ using
select dept.dname, count(*)
from dept join emp using(deptno)
group by dept.dname
having count(emp.empno) > 5;

= join ~ on
select dept.dname, count(*)
from dept join emp on dept.deptno = emp.deptno
group by dept.dname
having count(emp.empno) > 5;

= inner join ~ on 
select dept.dname, count(*)
from dept inner join emp on dept.deptno = emp.deptno
group by dept.dname
having count(emp.empno) > 5;

문6 각 부서의 이름과 가장 많은 월급의 크기를 
    출력하시오
select dname, max(emp.sal)
from emp, dept
where emp.deptno = dept.deptno
group by dept.dname;

문6 ADAMS 사원이 근무하는 부서이름과 지역이름을 
    출력하시오.
select dname, loc
from emp, dept
where emp.deptno = dept.deptno
and emp.ename = 'ADAMS';

문7 NEW YORK이나 DALLAS 지역에 근무하는 사원들의
    사원번호, 사원이름을 사원번호 순으로 검색하시오.
select empno, ename
from emp, dept
where emp.deptno = dept.deptno
and (loc = 'NEW YORK' 
or loc = 'DALLAS')
order by empno;

select empno, ename, loc
from emp natural join dept
where loc = 'NEW YORK' 
or loc = 'DALLAS'
order by empno;

문8 부서이름이 ACCOUNTING이거나, 지역이름이 CHICAGO인
    사원의 사원번호와 사원이름을 검색하시오.
select empno, ename, loc, dname
from emp natural join dept
where dname = 'ACCOUNTING' or loc = 'CHICAGO';

- Non Equl
문9 사원번호, 사원이름, 급여, 급여등급을 
    급여등급별 사원번호 순으로 검색하시오.
select empno, ename, sal, grade
from emp, salgrade
where emp.sal between salgrade.losal 
and salgrade.hisal
order by empno;

select empno, ename, sal, grade
from emp, salgrade
where emp.sal >= salgrade.losal 
and emp.sal <= salgrade.hisal
order by empno;


- SELF JOIN
select my.empno, my.ename, mgr.empno, mgr.ename
from emp my, emp mgr
where my.mgr = mgr.empno;

+ group by 추가
문10 각 부서의 이름과 가장 많은 월급의 크기를 
    출력하시오.
select dname, max(sal)
from emp JOIN dept ON emp.deptno = dept.deptno
group by dname;

- OUTER JOIN
FULL OUTER JOIN
select ename, dname, loc
from emp FULL OUTER JOIN dept
ON emp.deptno = dept.deptno

select ename, dname, loc
from emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;
=
select ename, dname, loc
from emp, dept
where emp.deptno = dept.deptno(+);

select ename, dname, loc
from emp RIGHT OUTER JOIN dept
ON emp.deptno = dept.deptno
=
select ename, dname, loc
from emp, dept
where emp.deptno(+) = dept.deptno;

문11 사원번호, 사원이름, 상사번호, 상사이름을 
모두 출력하는 쿼리를 작성하시오.
(단, 사장님도 포함하여 출력할 수 있도록 작성하시오.)
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1 LEFT OUTER JOIN emp e2 
ON e1.mgr = e2.empno;

select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1 ,emp e2 
where e1.mgr = e2.empno(+);

문12 사원번호, 사원이름, 직책, 관리자이름, 근무위치를
출력하시오. 
(단, 사장님도 포함하여 출력할 수 있도록 작성하시오.)
select e1.empno, e1.ename, e1.job, e2.ename, d.loc
from emp e1 LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno
            JOIN dept d ON e1.deptno = d.deptno;

select e1.empno, e1.ename, e1.job, e2.ename, d.loc
from emp e1, emp e2, detp d
where e1.mgr = e2.empno(+) 
and e1.deptno = d.deptno;


문13 사원 JAMES의 사원번호, 이름, 급여, 급여등급, 부서명과
그의 상사 이름, 상사의 부서명을 출력하시오.

select e1.empno, e1.ename, e1.sal, grade, d1.dname, 
       e2.ename, d2.dname
from emp e1, emp e2, salgrade, dept d1, dept d2
where e1.deptno = d1.deptno 
and e1.sal between losal and hisal
and e1.mgr = e2.empno
and e2.deptno = d2.deptno
and e1.ename = 'JAMES';

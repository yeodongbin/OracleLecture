- View

select ename, loc
from emp, dept
where emp.deptno = dept.deptno
and loc = 'NEW YORK';

CREATE VIEW V_NEW_YORK
AS select ename, loc
from emp, dept
where emp.deptno = dept.deptno
and loc = 'NEW YORK';

SELECT * 
FROM V_NEW_YORK;

SELECT * 
FROM (select ename, loc
      from emp, dept
      where emp.deptno = dept.deptno
      and loc = 'NEW YORK') loc_info;

select e1.empno, e1.ename, e2.ename
from emp e1, emp e2
and e1.mgr = e2.empno;

CREATE VIEW V_MGR_INFO AS 
select e1.empno EMPNO, e1.ename ENAME, e2.ename MGR_ENAME
from emp e1, emp e2
WHERE e1.mgr = e2.empno;

CREATE OR REPLACE VIEW V_MGR_INFO AS 
select e1.empno EMPNO, e1.ename ENAME, e1.job JOB,
       e2.ename MGR_ENAME
from emp e1, emp e2
WHERE e1.mgr = e2.empno;

문1 EMP 테이블로 부터 10, 20번 부서의 사원들로
    이루어진 뷰를 만드시오.
CREATE VIEW V_EMP AS
SELECT *
FROM EMP 
WHERE DEPTNO IN (10, 20);

문2 사원번호, 사원이름, 부서이름, 상급자 이름으로 구성된 
    뷰를 만드시오.
CREATE OR REPLACE VIEW V_EMP_MGR (EMPNO, ENAME, DNAME, MGR_NAME) AS
SELECT E1.EMPNO, E1.ENAME, DEPT.DEPTNO, E2.ENAME
FROM EMP E1, EMP E2, DEPT
WHERE E1.MGR = E2.EMPNO
AND E1.DEPTNO = DEPT.DEPTNO;

문3 학과별 평균 몸무게와 평균 키를 가지는 뷰를 만드시오.
CREATE VIEW V_DEPT_AVG (STU_DEPT, AVG_STU_WEIGHT, AVG_STU_HEIGHT) AS
SELECT STU_DEPT, ROUND(AVG(STU_WEIGHT)), ROUND(AVG(STU_HEIGHT))
FROM STUDENT
GROUP BY STU_DEPT;

문4 학생이름, 키, 몸무게, BMI 지수를 가지는 뷰를 만드시오.
CREATE VIEW V_BMI (STU_NAME, STU_HEIGHT, STU_WEIGHT, BMI) AS
SELECT STU_NAME, STU_HEIGHT, STU_WEIGHT, 
       ROUND((10000*STU_WEIGHT/(POWER(STU_HEIGHT,2))),1) AS BMI
FROM STUDENT;

문5 사원번호, 이름, 급여, 커미션, 전체수입(급여+커미션)을 가지는
    뷰를 만들시오.

CREATE OR REPLACE VIEW V_INCOME AS
select empno, ename, sal, comm, (sal+nvl(comm,0)) income
from emp;

UPDATE V_EMP
SET SAL = 4000
WHERE EMPNO = 7839;

DELETE FROM V_BMI 
WHERE STU_NAME = '박희철';

SELECT view_name, text_length, text
FROM user_view;

- top-N
문6 수입 가장 많은 상위 3명의 수입과 직원번호를 출력하시오.

select empno, income
from (select empno, ename, sal, comm, (sal+nvl(comm,0)) income
      from emp
      order by income desc) emp_income
where rownum <= 3;

문7 부서별 평균 급여가 작은 부서 2개의 부서명, 평균급여를 출력하시오.
SELECT * 
FROM (SELECT DNAME, ROUND(AVG(SAL))
      FROM EMP, DEPT
      WHERE EMP.DEPTNO = DEPT.DEPTNO
      GROUP BY DNAME
      ORDER BY 2) DNAME_AVG
WHERE ROWNUM <=3;

문8 BMI크기가 상위 5명의 이름, 학번, BMI 지수를 출력하시오.

CREATE VIEW V_BMI_DESC AS
SELECT STU_NAME, STU_NO,
NVL(ROUND((10000*STU_WEIGHT/(POWER(STU_HEIGHT,2))),1),0) AS BMI
FROM STUDENT
ORDER BY BMI DESC;

SELECT *
FROM V_BMI_DESC
WHERE ROWNUM <=5;

- INDEX
CREATE INDEX i_stu_name 
ON STUDENT(STU_NAME);

DROP INDEX i_stu_name


- Sequence
CREATE SEQUENCE seq_num
INCREMENT BY 1
START WITH 1
MAXVALUE 100

CREATE TABLE SEQ_EMP (SEQ_NO, EMPNO, ENAME) AS
SELECT SEQ_NUM.nextval, EMPNO, ENAME
FROM EMP;

문9 초기값 1, 증감값 2, 최대값 20, CYCLE이 가능한
    시쿼스를 만드시오.
    CREATE SEQUENCE seq_num4
    INCREMENT BY 2
    START WITH 1
    MAXVALUE 200
    CYCLE;

    CREATE SEQUENCE seq_num4
    INCREMENT BY 2
    START WITH 1
    MAXVALUE 20
    CYCLE
    NOCACHE;




































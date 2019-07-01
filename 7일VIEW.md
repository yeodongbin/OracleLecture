병행처리 (스케줄링)
View

문제 1. EMP 테이블로 부터 10, 20번 부서의 사원들로 
이루어지 뷰를 생성하시오. 
CREATE VIEW EMPNO_VIEW AS
select *
from emp
where deptno in (10, 20);

문제 2. 사원번호, 사원이름, 부서이름, 상급자 이름으로
 구성된 뷰를 생성하시오.
create or replace view emp4 (empno, ename, dname, mgr_name) as
select e1.empno, e1.ename ,d.dname, e2.ename
from emp e1, emp e2, dept d
where e1.mgr = e2.empno 
and e1.deptno = d.deptno;

문제 3. 학과별 평균 몸무게와 평균 키를 가지는 
뷰를 생성하시오.
CREATE VIEW STUDENT_VIEW (STU_DEPT, STU_HEIGHT, STU_WEIGHT) AS
SELECT STU_DEPT, ROUND(AVG(STU_HEIGHT),2), ROUND(AVG(STU_WEIGHT),2)
FROM STUDENT
GROUP BY STU_DEPT;

문제 4. 학생이름, 키, 몸무게, BMI 지수를 가지는 
뷰를 생성하시오.

CREATE OR REPLACE VIEW STU_BMI AS
SELECT STU_NAME, STU_HEIGHT, STU_WEIGHT, 
ROUND((10000*STU_WEIGHT/(STU_HEIGHT*STU_HEIGHT)),2) AS BMI
FROM STUDENT
WHERE STU_HEIGHT IS NOT NULL
AND STU_WEIGHT IS NOT NULL;

문제 5. 사원 이름, 급여, 커미션, 전체수입(급여+커미션)을 
가지는 뷰를 생성하시오.
CREATE OR REPLACE VIEW EMP_INCOME AS
SELECT ENAME, SAL, NVL(COMM,0) AS COMM, 
           (SAL+NVL(COMM,0)) AS INCOME
FROM EMP;


문제 6. 초기값 1, 증감값 1, 최대값 1000인 시쿼스를 만들고 
시쿼스를 이용해서 학생들에게 숫자를 지정하는 
새로운 테이블을 만드시오.
STUDENT_SEQ (SEQ_NO, STU_NO, STU_NAME, STU_GRADE, 
                      STU_CLASS, STU_GENDER)

CREATE SEQUENCE SEQ2
INCREMENT BY 1
START WITH 1
MAXVALUE 1000;

CREATE TABLE STUDENT_SEQ (SEQ_NO, STU_NO, 
STU_NAME, STU_GRADE, STU_CLASS, STU_GENDER) AS
SELECT SEQ2.NEXTVAL, STU_NO, 
STU_NAME, STU_GRADE, STU_CLASS, STU_GENDER
FROM STUDENT

ROWID, ROWNUM
SELECT ENAME
FROM EMP;

문제 7. 수입(급여+커미션)이  높은 상위 5명의 
사원번호, 사원이름, 부서명을 출력하는 뷰를 만드시오.

CREATE VIEW V_STU_INCOME AS
SELECT *
FROM (SELECT EMPNO, ENAME, DNAME, (SAL+NVL(COMM,0)) INCOME
           FROM EMP NATURAL JOIN DEPT
           ORDER BY 4 DESC) STU_INCOME
WHERE ROWNUM <6;

문제 8. 부서별 평균 급여가 작은 부서 2개의 부서이름을 
뷰로 출력하시오.

CREATE VIEW V_AVG_DEPT AS
SELECT *
FROM (SELECT DEPTNO, ROUND(AVG(SAL)) AS  AVG_SAL
	FROM EMP 
	GROUP BY DEPTNO
	ORDER BY 2) AVG_DEPT
WHERE ROWNUM <3;






















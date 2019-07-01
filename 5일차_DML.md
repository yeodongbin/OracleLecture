SET
union
union all
intersect
minus

select * 
from student
where stu_dept in ('기계', '전기전자');

select * 
from student
where stu_dept = '기계'
union
select * 
from student
where stu_dept = '전기전자';

select * 
from student
where stu_dept = '컴퓨터정보'
union (union all, minus, intersect)
select * 
from student
where stu_grade = '2';

1. SALES 부서와 RESEARCH 부서에 근무중인
사원 정보를 모두 출력하시오.
SELECT *
FROM EMP JOIN DEPT 
ON EMP.DEPTNO = DEPT.DEPTNO
WHERE DEPT.DNAME = 'SALES'
UNION
SELECT *
FROM EMP JOIN DEPT 
ON EMP.DEPTNO = DEPT.DEPTNO
WHERE DEPT.DNAME = 'RESEARCH'

2. SALESMAN 이지만, 보너스를 받지 않는 사원의
정보를 출력하시오.
SELECT * 
FROM EMP
WHERE JOB = 'SALESMAN'
MINUS
SELECT * 
FROM EMP
WHERE COMM IS NOT NULL;

SELECT * 
FROM EMP
WHERE JOB = 'SALESMAN'
INTERSECT
SELECT * 
FROM EMP
WHERE COMM IS NULL;

1. EMP_TEST에 EMP 테이블의 
'SMITH'를 제외한 모든 사원의 정보를
입력하시오.
INSERT INTO EMP_TEST
SELECT * 
FROM EMP
WHERE EMPNO != 7369;

2. EMP_TEST 테이블에 아래 정보를 
입력하시오.
월급 : 100000
보너스 : 1000
이름 : SON
사원번호 : 1112

INSERT INTO EMP_TEST (SAL, COMM, ENAME, EMPNO)
VALUES (100000, 1000, 'SON', 1112) ;
UPDATE EMP_TEST
SET DEPTNO = 30
WHERE EMPNO = 7900;

UPDATE EMP_TEST
SET SAL = SAL * 1.1;
WHERE DEPTNO = 20;

UPDATE EMP_TEST
SET HIREDATE = SYSDATE()
WHERE 1=1;

3. EMP_TEST에 사원번호 9999, 사원이름 KITRI 입력하시오.
그 후에 사원번호가 9999인 사원의 이름을 KITRI00으로 변경하시오.
INSERT INTO EMP_TEST (EMPNO, ENAME) 
VALUES (9999,'KITRI');
COMMIT;

UPDATE EMP_TEST
SET ENAME = 'KITRI00'
WHERE EMPNO = 9999;
COMMIT;

4. subject_test 테이블을 새로 만드시오.
subject_test 테이블에 subject 테이블 정보를 
모두 저장합니다.
subject_test 테이블에 아래 정보를 입력하시오.
(112, 오라클DB, 여동빈, 1, 컴퓨터정보)
create table subject_test (
sub_no char(3),
sub_name varchar2(30),
sub_prof varchar2(12),
sub_grade number(1),
sub_dept varchar2(20),
constraint p_test_sub_no primary key(sub_no));

INSERT INTO subject_test 
SELECT * 
FROM subject;

INSERT INTO subject_test  
VALUES (112, '오라클DB', '여동빈', 1, '컴퓨터정보');
COMMIT;

SELECT * 
FROM subject_test;

5. enrol_test 테이블을 새로 만드시오.
enrol_test 테이블에 enrol 정보를 모두 저장하시오.
enrol_test 테이블에 시스템분석 설계를 듣는 
학생들의 점수는 10점씩 증가 시키시오.

create table enrol_test(
sub_no char(3),
stu_no char(9),
enr_grade number(3),
constraint p_course_test primary key(sub_no,stu_no));

insert into enrol_test
select*
from enrol;

update enrol_test
set enr_grade = enr_grade + 10
where sub_no = (select sub_no
	           from subject
 	           where sub_name = '시스템분석설계'); //104

6. emp_test 테이블에서 월급 등급이 3인 직원의 
월급을 15% 인상하여 저장하시오.
update emp_test
set sal = sal * 1.15
where sal between 
(select losal from salgrade where grade=3) 
and 
(select hisal from salgrade where grade=3);

update emp_test
set sal = sal * 1.15
where empno in (select empno
	           from emp_test, salgrade
	           where emp_test.sal between losal and hisal
	           and grade = 3)

7. emp_test 테이블에서 DALLAS에서 일하는 직원들의 
COMM을 100씩 추가하시오.
update emp_test
set comm = nvl(comm,0)+100
where deptno = (select deptno 
                        from dept 
                        where loc = 'DALLAS');

8. emp_test 테이블에서 SCOTT의 상급자를 
BLAKE로 변경하시오.
update emp_test
set mgr = (select empno 
               from emp_test 
               where ename = 'BLAKE')
where empno = (select empno 
                        from emp_test 
                        where ename = 'SCOTT');

9. 사원번호가 7902번인 사원의 데이터를 
삭제하시오.
DELETE EMP_TEST
WHERE EMPNO=7902;

10. 평균급여 보다 적게 받은 사원을 삭제하시오.

DELETE EMP_TEST
WHERE SAL < (SELECT AVG(SAL)
             FROM EMP_TEST);

11. 모든행을 삭제
DELETE from EMP_TEST

12. emp 에 다음 정보를 입력하시오.
사원번호 1112,
이름 PARK,
월급 1000
만약에 데이터가 존재하면 UPDATE 하고
데이터가 존재하지 않으면 INSERT하시오.

MERGE INTO EMP E 
USING DUAL T 
ON (E.EMPNO = 1112)
WHEN MATCHED THEN
UPDATE SET E.ENAME = 'PARK' , E.SAL = 1000
WHEN NOT MATCHED THEN
INSERT (E.EMPNO, E.ENAME, E.SAL)
VALUES (1112, 'PARK', 1000);

13. student 테이블에서 컴퓨터 정보 1,2학년 학생이면 
몸무게를 10KG 씩 증가시키고, 컴퓨터 정보 3학년 
학생이면 몸무게 20kg을 증가시켜 새로운 
student_test 테이블에 데이터를 저장하시오.
(새로운 student_test 테이블 생성이 필요함.)
MERGE INTO STUDENT_TEST A
    USING STUDENT B
    ON (A.STU_NO = B.STU_NO)
WHEN MATCHED THEN
    UPDATE SET A.STU_WEIGHT = B.STU_WEIGHT + 
			       DECODE(B.STU_GRADE, 1, 10, 2, 10, 3, 20)
WHEN NOT MATCHED THEN
    INSERT (A.STU_NO, 
	A.STU_NAME, 
	A.STU_DEPT, 
	A.STU_GRADE, 
	A.STU_CLASS, 
	A.STU_GENDER, 
	A.STU_HEIGHT, 
	A.STU_WEIGHT)
    VALUES (B.STU_NO, 
	B.STU_NAME, 
	B.STU_DEPT, 
	B.STU_GRADE, 
	B.STU_CLASS, 
	B.STU_GENDER, 
	B.STU_HEIGHT, 
	B.STU_WEIGHT + 
	DECODE(B.STU_GRADE, 1, 10, 2, 10, 3, 20));













MERGE INTO student_test st
USING student s
ON (s.stu_detp = '컴퓨터정보')
WHEN MATCHED THEN
UPDATE SET st.weight = 
decode (st.stu_grade,3,st.stu_weight+20,
                             st.stu_weight+10)
WHEN NOT MATCHED THEN
INSERT (
st.stu_no,
st.stu_name,
st.stu_dept,
st.stu_grade,
st.stu_class,
st.stu_gender,
st.stu_height,
st.stu_weight)
VALUES (
s.stu_no,
s.stu_name,
s.stu_dept,
s.stu_grade,
s.stu_class,
s.stu_gender,
s.stu_height,
s.stu_weight)
































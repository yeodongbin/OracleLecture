INSERT INTO t_student
SELECT *
FROM student

INSERT INTO t_student
VALUES ('20190930','여동빈','전기전자',3,'A','M',184,90);

INSERT INTO t_student(STU_NO, STU_NAME, STU_DEPT, STU_GRADE)
VALUES ('20191001','박혜민','기계',2);

INSERT INTO t_student(STU_GENDER, STU_NO, STU_NAME, STU_HEIGHT)
VALUES ('F','20191002','전유경',170);

문1 T_EMP 테이블을 만들고, 'SMITH'를 제외한 모든 사원의
    정보를 입력하시오.
CREATE TABLE T_EMP
AS SELECT * 
FROM EMP
WHERE ENAME <> 'SMITH';

INSERT INTO T_EMP
SELECT *
FROM EMP
WHERE ENAME <> 'SMITH';

문2 T_EMP 테이블에 아래 정보를 입력하시오.
이름 : SON
월급 : 20000
보너스 : 20%
사원번호 : 777
INSERT INTO T_EMP(ENAME, SAL, COMM, EMPNO)
VALUES('SON',20000,(20000*0.2),777)

문3 T_EMP 테이블에 사원번호 9999, 사원이름 KITRI를 
    입력하시오.
INSERT INTO T_EMP(EMPNO, ENAME)
VALUES(9999,'KITRI');


- UPDATE
예제) 손흥민의 SAL를 30000으로 변경하시오.
UPDATE T_EMP
SET SAL = 30000
WHERE EMPNO = 777;

문4 손흥민의 보너스를 10% 인상하시오.
    그리고, 손흥민의 입사일을 오늘 날짜로 변경하시오.
UPDATE T_EMP
SET COMM = COMM * 1.1, HIREDATE = SYSDATE
WHERE EMPNO = 777;

문5 손흥민보다 적게 월급을 받는 사원들의 월급을 
    10% 인상하시오.
UPDATE T_EMP
SET SAL = SAL * 1.1
WHERE SAL < (SELECT SAL
	     FROM T_EMP
             WHERE EMPNO = 777);

문6 COMM 이 NULL 값인 모든 사원의 COMM을 0으로 변경하시오.
UPDATE T_EMP
SET COMM = 0
WHERE COMM IS NULL;

문7 월급 등급이 3인 직원의 월급을 15% 인상하여 저장하시오.
UPDATE T_EMP
SET SAL = SAL * 1.15
WHERE EMPNO IN (SELECT EMPNO
		FROM SALGRADE, T_EMP
		WHERE T_EMP.SAL BETWEEN LOSAL AND HISAL
		AND GRADE = 3);

문8 DALLAS에서 일하는 직원들의 COMM을 100씩 추가하시오.
UPDATE T_EMP
SET COMM = NVL(COMM,0) + 100
WHERE DEPTNO = (SELECT DEPTNO
		FROM DEPT
		WHERE LOC = 'DALLAS');

문9 SCOTT의 상급자를 BLAKE로 변경하시오.
UPDATE T_EMP
SET MGR = (SELECT EMPNO
	   FROM T_EMP
	   WHERE ENAME = 'BLAKE')
WHERE EMPNO = (SELECT EMPNO
	       FROM T_EMP
	       WHERE ENAME = 'SCOTT')

- DELETE
DELETE FROM T_EMP
WHERE EMPNO = 777;

문10 사원번호 7902번 사원 정보를 모두 삭제하시오.
DELETE FROM T_EMP
WHERE EMPNO = 7902;

문11 평균급여 보다 적게 받는 사원을 모두 삭제하시오
DELECT FROM T_EMP
WHERE SAL < (SELECT AVG(SAL) FROM T_EMP);

문12 T_EMP 테이블의 데이터를 모두 삭제하시오.
DELECT FROM T_EMP;

- MERGE

MERGE INTO T_EMP
USING EMP
ON (EMP.EMPNO = T_EMP.EMPNO)
WHEN MATCHED THEN
	UPDATE SET T_EMP.ENAME = EMP.ENAME
WHEN NOT MATCHED THEN
	INSERT VALUES ('777','SON','','','','','','');


문13 T_EMP에서 다음 정보를 입력하시오.
사원번호 : 1112
이름     : PARK
월급     : 2000 
데이터가 존재하면 UPDATE하고
데이터가 존재하지 않으면 INSERT 하시오.

CREATE TABLE S_EMP
AS SELECT * 
FROM EMP
WHERE EMPNO = 7902;

MERGE INTO T_EMP
USING S_EMP
ON (S_EMP.EMPNO = T_EMP.EMPNO)
WHEN MATCHED THEN
	UPDATE SET ENAME = 'PARK', SAL = 2000
WHEN NOT MATCHED THEN
	INSERT VALUES (1112,'PARK','','','',2000,'','');

문14 STUDENT 테이블에서 컴퓨터정보 1,2학년이면
     몸무게를 10KG 씩 증가시키고, 컴퓨터정보 3학년
     학생이면 몸무게 20KG을 증가시켜 T_STUDENT 테이블에 
     저장하시오. 

CREATE TABLE T_STUDENT
AS SELECT * FROM STUDENT;

MERGE INTO T_STUDENT A
USING (SELECT * FROM STUDENT WHERE STU_DEPT = '컴퓨터정보') B
ON (A.STU_NO = B.STU_NO )
WHEN MATCHED THEN
	UPDATE SET A.STU_WEIGHT = B.STU_WEIGHT + 
                                  DECODE(B.STU_GRADE, 
     					 1, 10,
					 2, 10,
					 3, 20)
WHEN NOT MATCHED THEN
	INSERT (A.STU_NAME,  A.STU_DEPT,   A.STU_GRADE,
                A.STU_CLASS, A.STU_GENDER, A.STU_HEIGHT,
                A.STU_WEIGHT)
        VALUES (B.STU_NAME,  B.STU_DEPT,   B.STU_GRADE,
                B.STU_CLASS, B.STU_GENDER, B.STU_HEIGHT,
                B.STU_WEIGHT + DECODE(B.STU_GRADE, 
     				      1, 10,
				      2, 10,
				      3, 20));



문15 외국인 학생 테이블(fore_student) 작성시에 오류가 
     발생하였다. 외국인 학생 MAKE를 student 테이블에 
     추가합니다. 외국인 학생들의 클래스는 모두 A반으로 
     변경하고 추가된 MAKR 를 fore_student에 저장하시오.

	<오류 발생 명령문>
	CREATE TABLE fore_student
	as select * from student 
	where stu_grade = 1;
        
        <MAKE 정보> -> STUDENT 테이블에 추가(INSERT)
	STU_NO STU_NAME STU_GRADE
        1111   MAKE     1학년

insert into fore_student (stu_no, stu_name, stu_grade)
values(1111, 'MAKE',1);

MERGE INTO FORE_STUDENT F
USING (SELECT * FROM STUDENT WHERE STU_GRADE = 1) S
ON (S.STU_NO = F.STU_NO)
WHEN MATCHED THEN
	UPDATE SET STU_CLASS = 'A'
WHEN NOT MATCHED THEN
        INSERT (F.STU_NO, F.STU_NAME, F.STU_DEPT, F.STU_GRADE,
                F.STU_CLASS, F.STU_GENDER, F.STU_HEIGHT, 
                F.STU_WEIGHT)
        VALUES (S.STU_NO, S.STU_NAME, S.STU_DEPT, S.STU_GRADE,
                S.STU_CLASS, S.STU_GENDER, S.STU_HEIGHT, 
                S.STU_WEIGHT))

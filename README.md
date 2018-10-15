
# OracleLecture
	
'SELECT *
FROM EMP
WHERE JOB = 'SALESMAN' OR JOB = 'ANALYST'
ORDER BY DEPTNO, JOB, SAL;'


SELECT * 

FROM EMP

WHERE JOB LIKE 'S%' OR JOB LIKE 'A%'

ORDER BY DEPTNO, JOB, SAL;


SELECT * 
FROM EMP
WHERE JOB IN ('SALESMAN','ANALYST')
ORDER BY DEPTNO, JOB, SAL;

SELECT * 
FROM EMP
WHERE JOB = ANY('SALESMAN','ANALYST')
ORDER BY DEPTNO, JOB, SAL;

SELECT * 
FROM EMP
WHERE JOB = SOME('SALESMAN','ANALYST')
ORDER BY DEPTNO, JOB, SAL;


- 사원들의 정보를 사원직무별, 급여 순으로 검색하라. 단 급여는 1000만원 이상만 검색하라
select * 
from emp
where sal >=1000
order by job, sal;


- JOB이 Manager가 아닌 사원의 사원번호, 이름, 직무별 출력하시오. 단, JOB이 없는 사원은 제외한다.
select empno, ename, job
from emp
where job <> 'MANAGER' and job is not null
order by job;


- 사원들의 사원이름과 사원직무를 연결하여 검색하여라. (예: King PRESIDENT)
select concat(concat(inticap(ename),' '),job) from emp;
select inticap(ename)||' '||job from emp;


- 사원들의 사원이름과 사원이름의 길이를 검색하여라 단 매니저만 검색하시오.
select ename,
from emp
where


- emp 테이블의 hiredate를 연도로 출력하시오.
select empno, ename, job, mgr,
       to_char(hiredate,'yyyy"년"') as hiredate,
       sal,comm,deptno
from emp;


- 학생들중에 기계과 학생들은 등록금을 10000만원
            전기전자 학생들은 등록금을 9000만원
            컴퓨터정보 학생들은 등록금을 8000만원이라고 한다.
학번, 이름, 과, 등록금을 출력하시오. 단, 2013학번만 출력합니다.
select stu_no, stu_name, stu_dept,
case stu_dept when '기계' then '10000'
              when '전기전자' then '9000'
              when '컴퓨터정보' then '8000'
       else '0'
end as 등록금
from student
where stu_no like '2013%';

select stu_no, stu_name, stu_dept,
decode(stu_dept,'기계','10000',
                '전기전자','9000',
                '컴퓨터정보','8000',
      '0') as 등록금
from student
where stu_no like '2013%';


- 부서NO, 부서별 평균 임금을 출력하시오. 단, 평균 임금이 2000이하인 부서는 제외
select deptno, avg(sal)
from emp
group by deptno
having avg(sal) > 2000;


- 1981년입사자들의 평균 임금(sal)을 출력하시오. 
select avg(sal)
from emp
where to_char(hiredate,'yyyyddmm') like ('1981%');

SELECT avg(sal)
FROM emp
GROUP BY SUBSTR(hiredate, 1, 2)
HAVING SUBSTR(hiredate, 1, 2) = '81';

X
select hiredate as 입사일, avg(sal) 평균임금
from emp
group by hiredate
having hiredate like '81%';

select avg(sal)
from emp
where to_char(hiredate,'yyyy') = '1981';
//group by to_char(hiredate,'yyyy');


- 직무별 최대 임금을 출력하시오.
select job,max(sal)
from emp
group by job
order by max(sal) desc;


- SALESMAN의 커미션 평균를 출력하시오.
select avg(nvl(comm,0))
from emp
where job = 'SALESMAN';

select avg(nvl(comm,0))
from emp
group by job
having job = 'SALESMAN';


- 직무 중 가장 적게 수입을 가지는 직무의 평균 월급을 출력하시오.(커미션 포함)
select job,min(avg(sal+nvl(comm,0)))
from emp
group by job;


-FORD 씨와 월급이 같은 사람, 월급을 출력하시오.
(FORD 씨는 제외하시오.)

select ename, sal
from emp
where sal = 
(select distinct sal
from emp
where ename = 'FORD')
and ename <> 'FORD';

//포드 월급 (3000)
select sal
from emp
where ename = 'FORD';


- 사원 이름이 JONES인 직원의 부서명을 출력
select dname
from dept
where deptno = (select deptno
                from emp
                where ename = 'JONES');


- 평균 급여보다 많은 급여를 받는 사원의 이름, 사번, 급여를 급여 내림차순으로 출력
select avg(sal) 
from emp; //평균 급여

select ename, empno, sal 
from emp
where sal > (select avg(sal) from emp)
order by sal;


- 상사가 BLAKE인 사원들의 사원번호, 이름,
  급여를 출력하시오.(급여 오름차순)
  select empno from emp 
  where ename = 'BLAKE'; //BLAKE 사원번호

  select empno, ename, sal
  from emp
  where mgr = (select empno 
               from emp 
               where ename = 'BLAKE')
  order by sal desc;
  

- 커미션을 가장 많이 받는 사람의 급여와
  동일한 급여를 받는 직원의 이름, 급여, 
  사원번호를 출력하시오.

select max(comm)from emp; //최대 커미션

//최대 커미션 받는 사람연봉
select sal 
from emp 
where comm = 
(select max(comm)from emp)
//O
select ename, sal, empno 
from emp 
where sal = (select sal 
             from emp 
             where comm = (select max(comm)
                           from emp))
and comm <> (select max(comm)from emp);

//O
select * from emp where comm <>(select max(comm)from emp);
select ename, sal, empno 
from (select * 
      from emp 
      where comm <>(select max(comm)from emp))
where sal = (select sal 
             from emp 
             where comm = (select max(comm)
                           from emp));


- 전기전자 학생수 보다 많거나 같은 학과의 과 이름, 학생수를 출력하시오.(과이름 내림차순)
select count(*) from student 
where stu_dept = '전기전자';
select stu_dept, count(*) from student
group by stu_dept
having count(*) > (select count(*) from student 
where stu_dept = '전기전자');


- Enrol 점수가 가장 높은 학생의 BMI 지수를 출력하시오.
select max(enr_grade)
from enrol;//가장 큰 enr_grade

select stu_no
from enrol 
where enr_grade = (select max(enr_grade)
from enrol);//가장 큰 enr_grade 가진 학번

select stu_weight/((stu_height/100)*(stu_height/100)) as BMI
from student
where stu_no = (select stu_no
from enrol 
where enr_grade = (select max(enr_grade)
from enrol));//학번과 동일한 키와 몸무게

- 여학생 중 가장 큰 키, 무거운 학생의 정보와 같은 학생 정보를 모두 출력하시오.
  (학과, 성별로 구분하여 표시할 것)

select max(stu_height), max(stu_weight)
from student
where stu_gender = 'F';

select *
from student
where (stu_height,stu_weight) in 
(select max(stu_height), max(stu_weight)
from student
where stu_gender = 'F')
order by stu_dept, stu_gender;

=> 사원번호, 사원이름, 부서이름, 부서번호를 출력하시오
(5가지 종류를 모두 사용하여 출력할 것)
-Oracledb(where)
select empno, ename, dname, dept.deptno
from dept, emp
where dept.deptno = emp.deptno;

-natual join(자동)
select empno, ename, dname, deptno
from dept natural join emp;

-join using
select empno, ename, dname, deptno
from dept join emp using(deptno);

-inner join using
select empno, ename, dname, deptno
from dept inner join emp using(deptno);

-join on
select empno, ename, dname, dept.deptno
from dept join emp on dept.deptno = emp.deptno;

-inner join on
select empno, ename, dname, dept.deptno
from dept inner join emp on dept.deptno = emp.deptno;

=> 부서가 30이고, 급여가 1500이상인 사원의 이름, 부서명, 급여를 출력하시오.
(4가지 방법)
V
select e.ename, d.dname, e.sal
from dept d, emp e
where d.deptno = e.deptno
and d.deptno = 30
and e.sal>=1500;

select ename, dname, sal
from dept natural join emp
where deptno = 30 
and sal >=1500;

select ename, dname, sal
from dept join emp using(deptno)
where deptno = 30 
and sal >=1500;

select e.ename, d.dname, e.sal
from dept d join emp e on d.deptno = e.deptno
where d.deptno = 30 
and e.sal >=1500;
V
select e.ename, d.dname, e.sal
from dept d join emp e 
on d.deptno = e.deptno 
and d.deptno = 30 
and e.sal >=1500;


- 급여가 1500이상이고 부서번호가 30번인 사원 중에 매니저인 사람의 상사의 정보를 모두 출력하시오. 
(where 방식, join on 방식 사용, 테이블 닉네임)
//self join
select b.ename, b.job
from emp a, emp b
where a.mgr = b.empno
and a.sal >= 1500
and a.deptno = 30
and a.job = 'MANAGER';

//self join
select b.ename, b.job
from emp a join emp b on a.mgr = b.empno
where a.sal >= 1500
and a.deptno = 30
and a.job = 'MANAGER';

//sub query
select mgr
from emp
where sal >=1500
and deptno =30
and job = 'MANAGER';

select *
from emp
where empno = (select mgr
from emp
where sal >=1500
and deptno =30
and job = 'MANAGER');

////////////////////////////////////////////
// RIGHT OUTER JOIN
select a.*, sub_name
from enrol a, subject b
where a.sub_no(+) = b.sub_no
order by 1

select a.*, sub_name
from enrol a right outer join subject b 
on a.sub_no = b.sub_no
order by 1

// LEFT OUTER JOIN
select a.*, sub_name
from enrol a, subject b
where a.sub_no = b.sub_no(+)
order by 1

select a.*, sub_name
from enrol a left outer join subject b 
on a.sub_no = b.sub_no
order by 1

// FULL OUTER JOIN
select a.*, sub_name
from enrol a full outer join subject b 
on a.sub_no = b.sub_no
order by 1


=> 사원번호, 사원이름을 부하직원수가 적은 순으로 검색하여라.
(group by, self join)
select b.empno, b.ename, count(*)
from emp a join emp b on a.mgr = b.empno
group by b.empno, b.ename, b.mgr
order by 3;

select a.empno, a.ename, count(b.mgr)
from emp a join emp b on a.empno = b.mgr
group by a.empno, a.ename
order by 3;

SELECT e1.empno, e1.ename
FROM emp e1, (SELECT mgr
           FROM emp
           GROUP BY mgr
           HAVING mgr IS NOT NULL
           ORDER BY COUNT(*) ASC) e2
WHERE e1.empno = e2.mgr;


=> 시스템분석설계를 수강하는 학생들의 이름, 학과를 출력하시오.

select stu.stu_name, stu.stu_dept
from student stu, enrol e, subject sub
where stu.stu_no = e.stu_no 
and sub.sub_no = e.sub_no
and sub_name = '시스템분석설계';

select sub_no
from subject
where sub_name = '시스템분석설계';

select stu.stu_name, stu.stu_dept
from student stu join enrol e 
on stu.stu_no = e.stu_no
where e.sub_no = (select sub_no
from subject
where sub_name = '시스템분석설계');


=> enr_grade가 70이상인 학생들의 이름, 학과, 학번을 출력하시오. (join)
select student.stu_name, student.stu_dept, student.stu_no
from student, enrol
where student.stu_no = enrol.stu_no
and enr_grade >= 70;

- emp, salgrade, dept 이동시키시오
create [table_name] (
열이름 타입(사이즈) 
constraint pk_[table_name] primary key,
열이름 타입(사이즈) 
, ...

)
<테이블 생성이후>

INSERT INTO dept
SELECT * FROM ora_user2.dept;

INSERT INTO salgrade
SELECT * FROM ora_user2.salgrade;

INSERT INTO emp
SELECT * FROM ora_user2.emp;


- 사원번호 7902인 FORD의 상급자사원번호를 7654, 부서번호를 30으로 바꾸시오.
UPDATE emp
SET mgr = 7654, deptno = 30
WHERE empno = 7902;

- 지역이 DALLAS 인 사원들의 급여를 
100 증가 시키시오.

UPDATE emp
SET sal = sal + 100
WHERE deptno = (SELECT deptno 
FROM dept
WHERE loc = 'DALLAS');


- 부서번호 50, 부서이름 'PLANNING', 
  지역 'SEOUL'을 추가하시오.
INSERT INTO dept
VALUES (50, 'PLANNING','SEOUL');

- comm에 NULL값이 있는 경우, 0으로 변경하시오.
UPDATE emp
SET comm = 0
WHERE comm is null;


- BLAKE의 부하직원들의 Comm을 100씩 증가 시키시오.
UPDATE emp
SET comm = comm + 100
WHERE mgr = (SELECT empno
FROM emp
WHERE ename = 'BLAKE');


- 사장님 직함을 CEO로 변경하시오.
UPDATE emp
SET job = 'CEO'
WHERE mgr is null;


- 외국인 학생 테이블(fore_student) 작성시에 오류가 
발생하였다.
외국인 학생 MAKE를 student 테이블에 추가합니다.
전체 한국 학생들의 클래스는 모두 A반으로 변경하시오.

<오류 발생 명령문>
CREATE TABLE fore_student
as select * from student 
where stu_grade = 1;

insert into fore_student
values(20180004, 'MAKE','기계',1,'C','M',190,100);


MERGE INTO student stu
USING (select * from student
union
select * from fore_student) fore
ON (stu.stu_no = fore.stu_no)
WHEN MATCHED THEN
UPDATE SET stu.stu_class = 'A'
WHEN NOT MATCHED THEN
INSERT VALUES(fore.stu_no,
              fore.stu_name,
	      fore.stu_dept,
   	      fore.stu_grade, 
	      fore.stu_class,
	      fore.stu_gender,
	      fore.stu_height,
	      fore.stu_weight);


-----------------------------------------------------
** 테이블 생성
CREATE TABLE student_1 (
stu_no char(9) NOT NULL,
stu_name varchar2(12) CONSTRAINT n_stu_name NOT NULL,
stu_dept varchar2(20),
stu_grade number(3,1) 
);

CREATE TABLE student_2 (
stu_no char(9) UNIQUE,
stu_name varchar2(12) CONSTRAINT u_stu_name UNIQUE,
stu_dept varchar2(20),
stu_grade number(3,1) 
);

CREATE TABLE student_3 (
stu_no char(9) PRIMARY KEY,
stu_name varchar2(12) 
CONSTRAINT pk_stu_name PRIMARY KEY,
stu_dept varchar2(20),
stu_grade number(3,1) 
);

CREATE TABLE student_4 (
stu_no char(9),
stu_name varchar2(12),
stu_dept varchar2(20),
stu_grade number(3,1),
CONSTRAINT pk_stu_no 
PRIMARY KEY(stu_no, stu_name)
);

//제약조건 검색
SELECT A.UNIQUENESS, B.*
FROM ALL_INDEXES A, ALL_IND_COLUMNS B
WHERE A.INDEX_NAME = B.INDEX_NAME 
AND A.TABLE_NAME='STUDENT_4';

CREATE TABLE student_5 (
stu_no char(9),
stu_name varchar2(12),
stu_dept varchar2(20),
stu_grade number(1)
CONSTRAINT c_stu_gender 
CHECK (stu_gender in ('M','F','G')),
stu_gender char(1) 
CONSTRAINT c_stu_grade 
CHECK (stu_grade between 1 and 3)
);

INSERT INTO student_5 (stu_grade, stu_gender)
VALUES (4,'M');

select *
from user_constraints
where table_name LIKE 'STUDENT_%';

CREATE TABLE student_6 
AS select * from student;

CREATE TABLE student_7
AS select * from student 
where stu_dept = '기계';

CREATE TABLE student_8
AS select * from student;

** 테이블 제한조건
CREATE TABLE emp_1 (
empno    number(4,0) primary key,
ename    varchar2(10),
job      varchar2(9),
mgr      number(4,0),
hiredate date,
sal      number(7,2),
comm     number(7,2),
deptno   number(2,0),
CONSTRAINT fk_deptno 
FOREIGN KEY(deptno)
REFERENCES dept(deptno)
);

INSERT INTO emp_1(empno, deptno)
VALUES (1111, 60); //60때문에 에러

- 다음 테이블(nike)을 만드시오.
id    : 기본키
style : unique
color : 색깔 입력은 항상 존재
owner : 제약 조건 없음
c_size  : XS, S, M, L, XL, XXL만 입력가능
gender: M, F만 입력 가능
count : 제약 조건 없음
m_date  : 제약 조건 없음

CREATE TABLE nike (
id char(10),
style varchar2(20),
color varchar2(20) NOT NULL,
owner varchar2(20),
c_size char(3),
gender char(1),
count  number(6,0),
m_date date,
CONSTRAINT pk_id PRIMARY KEY(id),
CONSTRAINT u_style UNIQUE(style),
CONSTRAINT c_c_size CHECK (
c_size in ('XS','S','M','L','XL','XXL')),
CONSTRAINT c_gender CHECK (
gender in ('M','F'))
);

CREATE TABLE adidas (
id char(10),
style varchar2(20),
color varchar2(20) UNIQUE NOT NULL,
owner varchar2(20),
c_size char(3),
gender char(1),
count  number(6,0),
m_date date DEFAULT sysdate,
CONSTRAINT pk_id_a PRIMARY KEY(id),
CONSTRAINT u_style_a UNIQUE(style),
CONSTRAINT c_c_size_a CHECK (
c_size in ('XS','S','M','L','XL','XXL')),
CONSTRAINT c_gender_a CHECK (
gender in ('M','F'))
);

INSERT INTO adidas (id, color)
VALUES ('tf110','white');

//CONSTRAINT nu_id NOT NULL //not NULL 이름

** 테이블 삭제
DROP TABLE STUDENT_1;
TRUNCATE TABLE STUDENT_2;

** 테이블 변경
//열 추가
ALTER TABLE adidas
ADD (type varchar2(10),
     loc varchar2(20));

//열 삭제
ALTER TABLE adidas
DROP (location);

//열 이름 바꾸기
ALTER TABLE adidas
RENAME COLUMN loc TO location;

//열 속성 바꾸기
ALTER TABLE adidas
MODIFY (location char(10));

//열 제약조건 추가(NOT NULL)
ALTER TABLE adidas
MODIFY location NOT NULL; 

//제약조건 삭제
ALTER TABLE adidas
DROP CONSTRAINT pk_id_a;

//제약조건 추가
ALTER TABLE adidas
ADD CONSTRAINT pk_idid PRIMARY KEY (id);

//제약조건 이름 변경
ALTER TABLE adidas
RENAME CONSTRAINT pk_id TO pkidid;

//테이블명 변경
RENAME nike TO FILA;

----------------------------------------------------------------
CREATE OR REPLACE VIEW v_student
AS select stu_no, stu_name, stu_height
from student;

select student.stu_no, student.stu_name, 
subject.sub_name
from student, enrol, subject
where student.stu_no = enrol.stu_no
and subject.sub_no = enrol.sub_no;

CREATE OR REPLACE VIEW 	v_student2
AS select student.stu_no, student.stu_name, 
subject.sub_name
from student, enrol, subject
where student.stu_no = enrol.stu_no
and subject.sub_no = enrol.sub_no;

- 부서번호가 10번, 20번인 사원들의 사원번호,
이름, 월급을 보여주는 VIEW(emp_1)을 만드시오.
CREATE OR REPLACE VIEW emp_1
AS select empno, ename, sal
from emp
where deptno in (10,20);

- 사원번호가 7369보다 큰 사원들의
사원이름, 입사일, 부서번호, 부서이름을
보여주는 VIEW(emp_2)를 만드시오.
CREATE OR REPLACE VIEW emp_2
AS select e.ename, e.hiredate, e.deptno, 
d.dname
from emp e, dept d
where e.deptno = d.deptno 
and e.empno > 7369;

- 이름이 'A'로 시작하는 사원들의 모든 사원정보를 볼 수 있는 VIEW(emp_3)를 
만드시오.
CREATE OR REPLACE VIEW emp_3
AS select * from emp
where ename like 'A%';

CREATE OR REPLACE VIEW v_stu
AS select stu_no, stu_name, a.stu_dept, stu_height
from student a, 
(select stu_dept, avg(stu_height) as avg_height
from student
group by stu_dept) b
where a.stu_dept = b.stu_dept
and a.stu_height > b.avg_height;

//rownum 선택 질의
select stu_name, stu_height
from (select stu_name, stu_height, rownum r
      from (select stu_name, stu_height
            from student 
            where stu_height is not null
            order by 2 desc)
      ) a
where a.r = 5;

//rowid
select stu_name, stu_height, 
       rownum, rowid
from student;

//Top-N 질의
select stu_name, stu_height
from (select stu_name, stu_height
            from student 
            where stu_height is not null
            order by 2 desc) a
where rownum <= 5;

- 직원들 중 봉급과 커미션을 합해서 상위 5명 
  사원의 사원번호, 이름, 부서명을 출력하시오.
  (사장님은 제외)

select empno, ename, dname
from (select e.empno, e.ename, d.dname,
(e.sal+nvl(e.comm,0)) as income
from emp e, dept d
where e.deptno = d.deptno
and e.mgr is not null
order by 4 desc) 
where rownum <=5;


CREATE OR REPLACE VIEW emp_0
AS select e.empno, e.ename, d.dname,
(e.sal+nvl(e.comm,0)) as income
from emp e, dept d
where e.deptno = d.deptno
and e.mgr is not null
order by 4;

select empno, ename, dname
from emp_0
where rownum<=5;

CREATE INDEX i_stu_name 
ON student(stu_name);

CREATE UNIQUE INDEX i_stu_name 
ON student(stu_name);

DROP INDEX i_stu_name;

CREATE SEQUENCE seq1
INCREMENT BY 1
START WITH 1
MAXVALUE 100
MINVALUE 1
CYCLE;


SELECT seq1.nextval from dual;//증감
SELECT seq1.currval from dual;//확인

CREATE TABLE ttab (
in_no number(7),
name  varchar2(9),
id    char(9));

INSERT INTO ttab
VALUES (seq1.nextval,'sana','sana');

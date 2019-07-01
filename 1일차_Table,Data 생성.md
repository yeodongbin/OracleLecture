COL EMPNO FORMAT 9999
COL ENAME FORMAT A10
COL DNAME FORMAT A10
COL JOB FORMAT A10
COL MGR FORMAT 9999
COL SAL FORMAT 99999
COL DEPTNO FORMAT 999

DROP TABLE DEPT CASCADE CONSTRAINT;
DROP TABLE EMP CASCADE CONSTRAINT;

/////////////////////////////////////////////////////////////////////////

CREATE TABLE DEPT(
	DEPTNO NUMBER(2) CONSTRAINT pk_dept PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);

INSERT INTO DEPT VALUES (10,'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');


CREATE TABLE EMP(
	EMPNO NUMBER(4) CONSTRAINT pk_emp PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4), 
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) 
);

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',null,TO_DATE('1981-11-17','yyyy-mm-dd'),5000,null,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,TO_DATE('1981-04-02','yyyy-mm-dd'),2975,null,20);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('1981-05-01','yyyy-mm-dd'),2850,null,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('1981-06-09','yyyy-mm-dd'),2450,null,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('1987-04-19','yyyy-mm-dd'),3000,null,20);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,TO_DATE('1981-12-03','yyyy-mm-dd'),3000,null,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('1981-02-20','yyyy-mm-dd'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('1981-02-22','yyyy-mm-dd'),1250,500,30);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('1981-09-28','yyyy-mm-dd'),1250,1400,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('1981-09-08','yyyy-mm-dd'),1500,null,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,TO_DATE('1981-12-03','yyyy-mm-dd'),950,null,30);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,TO_DATE('1982-01-23','yyyy-mm-dd'),1300,null,10);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,TO_DATE('1980-12-17','yyyy-mm-dd'),800,null,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('1987-05-23','yyyy-mm-dd'),1100,null,20);
COMMIT;

CREATE TABLE salgrade(
	grade number(7,2),
	losal number(7,2),
	hisal number(7,2)
);

INSERT INTO salgrade values(1,700,1200);
INSERT INTO salgrade values(2,1201,1400);
INSERT INTO salgrade values(3,1401,2000);
INSERT INTO salgrade values(4,2001,3000);
INSERT INTO salgrade values(5,3001,9999);

-------------------------------------------------------------------------------------------------------

create table student(
stu_no char(9),
stu_name varchar2(12),
stu_dept varchar2(20),
stu_grade number(1),
stu_class char(1),
stu_gender char(1),
stu_height number(5,2),
stu_weight number(5,2),
constraint p_stu_no primary key(stu_no));

insert into student values(20153075, '옥한빛','기계',1,'C','M',177,80);
insert into student values(20153088, '이태연','기계',1,'C','F',162,50);
insert into student values(20143054, '유가인','기계',2,'C','F',154,47);
insert into student values(20152088, '조민우','전기전자',1,'C','M',188,90);
insert into student values(20142021, '심수정','전기전자',2,'A','F',168,45);
insert into student values(20132003, '박희철','전기전자',3,'B','M',null,63);
insert into student values(20151062, '김인중','컴퓨터정보',1,'B','M',166,67);
insert into student values(20141007, '진현무','컴퓨터정보',2,'A','M',174,64);
insert into student values(20131001, '김종헌','컴퓨터정보',3,'C','M',null,72);
insert into student values(20131025, '옥성우','컴퓨터정보',3,'A','F',172,63);

create table subject(
sub_no char(3),
sub_name varchar2(30),
sub_prof varchar2(12),
sub_grade number(1),
sub_dept varchar2(20),
constraint p_sub_no primary key(sub_no));

insert into subject values('111', '데이터베이스','이재영',2,'컴퓨터정보');
insert into subject values('110', '자동제어','정순정',2,'전기전자');
insert into subject values('109', '자동화설계','박민영',3,'기계');
insert into subject values('101', '컴퓨터개론','강종영',3,'컴퓨터정보');
insert into subject values('102', '기계공작법','김태영',1,'기계');
insert into subject values('103', '기초전자실험','김유석',1,'전기전자');
insert into subject values('104', '시스템분석설계','강석현',3,'컴퓨터정보');
insert into subject values('105', '기계요소설계','김명성',1,'기계');
insert into subject values('106', '전자회로실험','최영민',3,'전기전자');
insert into subject values('107', 'CAD응용실습','구봉규',2,'기계');
insert into subject values('108', '소프트웨어공학','권민성',1,'컴퓨터정보');

create table enrol(
sub_no char(3),
stu_no char(9),
enr_grade number(3),
constraint p_course primary key(sub_no,stu_no));

insert into enrol values('101','20131001',80);
insert into enrol values('104','20131001',56);
insert into enrol values('106','20132003',72);
insert into enrol values('103','20152088',45);
insert into enrol values('101','20131025',65);
insert into enrol values('104','20131025',65);
insert into enrol values('108','20151062',81);
insert into enrol values('107','20143054',41);
insert into enrol values('102','20153075',66);
insert into enrol values('105','20153075',56);
insert into enrol values('102','20153088',61);
insert into enrol values('105','20153088',78);
- SQLPLUS 접속
1. 시작 -> 프로그램 - > Oracle -> sqlplus

2. win + R -> cmd
sqlplus 
system
1234

- ID 만들기
create user c##ora_user 
identified by yeo;

- ID 권한 부여 (DBA)
grant dba to c##ora_user;

- ID 접속
sqlplus c##ora_user/yeo
select * from tab; //테이블 검색
desc student;      //테이블 속성 확인

- c## 삭제 설정
alter session set "_ORACLE_SCRIPT"=ture;

- Table 만들기
create table student (
stu_no     char(9),
stu_name   varchar2(12),
stu_dept   varchar2(20),
stu_grade  number(1),
stu_class  char(1),
stu_gender char(1),
stu_height number(5,2),
stu_weight number(5,2),
 constraint p_stu_no primary key(stu_no));

- Table 입력
insert into student values ('20153075', '옥한빛', '기계',1,'C','M',177,80);

- 테이블 속성 확인
describe [table 이름];
desc [table 이름];

- 화면 Clear
clear screen
cl scr

- 
5 select 
1 from 
2 where 
3 group by
4 having
6 order by

select stu_no, stu_name
from student
where stu_no = 20153075;

select stu_no, stu_name
from student
where stu_height = 177

select stu_no, stu_name, stu_grade
from student
where stu_grade = 1;

문1. 
기계과 학생들의 학번, 이름, 학과 명을 출력하시오.
SELECT STU_NO, STU_NAME,STU_DEPT
FROM STUDENT
WHERE STU_DEPT = '기계';

문2. 
여학생들의 학과명을 출력하시오.
SELECT DISTINCT STU_DEPT, STU_NAME
FROM STUDENT
WHERE STU_GENDER = 'F';

SELECT STU_NAME, STU_WEIGHT * 10
FROM STUDENT;

SELECT STU_NAME AS 학생이름, STU_WEIGHT AS 학생키
FROM STUDENT;

SELECT STU_NAME 학생이름, STU_WEIGHT 학생몸무게
FROM STUDENT;

// '옥한빛' 학생은 몸무게가 '80'KG입니다.
SELECT STU_NAME ||' 학생은 몸무게가 '|| 
       STU_WEIGHT || 'kg입니다.' AS 몸무게
FROM STUDENT;

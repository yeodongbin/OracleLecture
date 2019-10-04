- TABLE

// 테이블 생성
CREATE TABLE TEST
(U_ID   VARCHAR2(10) PRIMARY KEY,
 U_DATE DATE);

CREATE TABLE ACCOUNT2
AS SELECT * FROM ACCOUNT WHERE 1 = 2;

문1 account 테이블을 생성한다.
account_no   : 숫자 4자리, pk         
account_date : 날짜
code        : 가변문자 14 자리
withdrawar  : 숫자 8자리
deposit     : 숫자 10자리
balance     : 숫자 12자리
branch_code : 문자 8자리

CREATE TABLE account (
no          NUMBER(4) PRIMARY KEY,
date        DATE DEFAULT SYSDATE,
code        VARCHAR2(14) ,
withdrawar  NUMBER(8),
deposit     NUMBER(10),
balance     NUMBER(12),
branch_code CHAR(8)
);

//테이블 삭제
DROP TABLE [테이블 명];
EX) DROP TABLE ACCOUNT;

//테이블 이름 바꾸기
RENAME [이전 테이블명] TO [이후 테이블명];
EX) RENAME S_STU TO S_STUDENT

//테이블 열 추가
ALTER TABLE [테이블명] ADD ([컬럼명] [컬럼타입]);
EX) ALTER TABLE S_STU ADD (BMI NUMBER(4,1));

//테이블 열 이름 변경
ALTER TABLE [테이블명] RENAME COLUME [이전 컬럼명] TO [이후 컬럼명]
EX) ALTER TABLE S_STU RENAME COLUMN BMI TO BMIs

//테이블 열 타입 변경
ALTER TABLE [테이블명] MODIFY ([컬럼명] [이후 변경타입]);
EX) ALTER TABLE S_STU MODIFY (BMIS NUMBER);


// 제약조건
// 제약조건 확인
SELECT * FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'STUDENT_1';

- NOT NULL
CREATE TABLE STUDENT_1 (
STU_NO   CHAR(9) NOT NULL,
STU_NAME VARCHAR2(20) CONSTRAINT n_stu_name NOT NULL
);

CREATE TABLE STUDENT_1 (
STU_NO   CHAR(9),
STU_NAME VARCHAR2(20), 
CONSTRAINT n_stu_name NOT NULL(STU_NO)
);

- UNIQUE 
CREATE TABLE STUDENT_2 (
STU_NO   CHAR(9) UNIQUE,
STU_NAME VARCHAR2(20) CONSTRAINT u_stu_name UNIQUE
);

- CHECK
CREATE TABLE STUDENT_3 (
STU_NO   CHAR(9), 
STU_NAME VARCHAR2(20) CONSTRAINT u_stu_name UNIQUE,
STU_GENDER CHAR(1) CONSTRAINT c_stu_gender 
CHECK (STU_GENDER IN ('M','F'))
);

- DEFAULT
CREATE TABLE account (
no          NUMBER(4) PRIMARY KEY,
date        DATE DEFAULT SYSDATE);

문제2. 다음 테이블(nike)을 만드시오.
id     : 문자 10자리 (pk)
style  : 문자 20자리
color  : 가변문자 20자리
owner  : 가변문자 20자리
c_size : XS, S, M, L, XL, XXL만 입력가능
gender : M, F만 입력 가능
count  : NUMBER (1~9999 입력가능)
m_date : DATE 

CREATE TABLE NIKE (
ID    CHAR(10) CONSTRAINT pk_id PRIMARY KEY,
STYLE CHAR(20), 
COLOR VARCHAR2(20),
OWNER VARCHAR2(20),
C_SIZE CHAR(3) CONSTRAINT c_c_size 
               CHECK (C_SIZE IN ('XS','S','M','L','XL','XXL')),
GENDER CHAR(1) CONSTRAINT c_gender CHECK (GENDER IN ('M','F')),
COUNT  NUMBER  CONSTRAINT c_count CHECK (COUNT BETWEEN 1 AND 9999),
M_DATE DATE
);

- 제한조건 추가, 삭제
//NOT NULL 추가
ALTER TABLE NIKE MODIFY style NOT NULL;
ALTER TABLE NIKE MODIFY style CONSTRAINT nn_style NOT NULL;
ALTER TABLE NIKE MODIFY style NULL;

//CHECK, UNIQUE, PK, FK 추가
ALTER TABLE NIKE 
ADD CONSTRAINT c_color CHECK (color in ('yellow', 'blue', 'red'));
ALTER TABLE NIKE
ADD CONSTRAINT u_color UNIQUE (color);

// 제한조건 삭제
ALTER TABLE NIKE
DROP CONSTRAINT c_color;

- PRIMARY KEY (UNIQUE, NOT NULL) 추가
ALTER TABLE NIKE
ADD CONSTRINT pk_id PRIMARY KEY (ID);

- FOREIGN KEY

CREATE TABLE T_EMP (
EMPNO CHAR(3) PRIMARY KEY,
ENAME VARCHAR2(30),
DEPTNO CHAR(2) CONSTRAINT fk_deptno 
               FOREIGN KEY(DEPTNO) 
               REFERENCE DEPT(DEPTNO)
);

ALTER TABLE T_EMP
ADD CONSTRAINT fk_deptno FOREIGN KEY (DEPTNO)
			 REFERENCE DEPT(DEPTNO);
     
문제3. 다음 테이블(adidas)을 만드시오.
id    : 기본키 (pk)
style : unique
color : 색깔 입력은 항상 존재
owner : 제약 조건 없음     
c_size: XS, S, M, L, XL, XXL만 입력가능 
gender: M, F만 입력 가능
count : 제약 조건 없음                           
m_date  : default sysdate  

 owner  -> not null 추가 
 c_size -> check 조건 삭제
 count  -> check 조건 추가 (0<= count <= 1000) 

CREATE TABLE ADIDAS(
id    	     NUMBER       CONSTRAINT pk_adidas PRIMARY KEY,
style 	     VARCHAR2(20) CONSTRAINT u_style UNIQUE,
color 	     VARCHAR2(10) CONSTRAINT nn_color NOT NULL,
owner        VARCHAR2(10),
c_size       CHAR(3)      
CONSTRAINT ck_c_size CHECK(c_size IN ('XS','S','M','L','XL','XXL')),
gender       CHAR(1)      
CONSTRAINT ck_gender CHECK(gender IN ('F', 'M')),
count        NUMBER(10),
m_date       DATE DEFAULT SYSDATE);

  owner  -> not null 추가 
ALTER TABLE ADIDAS 
MODIFY owner CONSTRAINT adi_own_nn NOT NULL

  c_size -> check 조건 삭제
ALTER TABLE ADIDAS 
DROP CONSTRAINT ck_c_size;

  count  -> check 조건 추가 (0<= count <= 1000) 
ALTER TABLE ADIDAS 
ADD CONSTRAINT ck_count CHECK (COUNT >= 1 AND COUNT <= 1000);


문제4. 
테이블 명 : students  -> 1.student_t 테이블명 변경
STUDENT_NO(PK)    SURNAME        FORENAME -> 2.삭제 FORENAME
20060101          Dickens        Charles                         
20060102          ApGwilym       Dafydd                          
20060103          Zola           Emile                           
20060104          Mann           Thomas                          
20060105          Stevenson      Robert                          

3.FORENAME 생성, 4.UNIQUE, 5.NOT NULL
  charles
  dafydd
  emile
  thomas
  robert

-> 6.student_t 테이블 PK 삭제 
-> 7.PK 새로 추가 
-> 8.STUDENT_NO 에 CHECK (20060001 ~ 20069999) 제약 설정

테이블 명 : modules
MODULE_CODE(PK)  MODULE_NAME
CM0001           Databases
CM0003           Operating Systems
CM0004           Graphics

CM0002           Middle Ware -> 11. 컬럼추가

테이블 명: marks
STUDENT_NO MODULE_CODE  MARK -> 9.MARKS으로 컬럼명 변경, 
                                10. 컬럼타입 변경 (NUMBER(2,0))
				11. marks FK 추가
20060101   CM0001       80
20060101   CM0002       65
20060101   CM0003       50
20060102   CM0001       75
20060102   CM0003       45
20060102   CM0004       70
20060103   CM0001       60
20060103   CM0002       75
20060103   CM0004       60
20060104   CM0001       55
20060104   CM0002       40
20060104   CM0003       45
20060105   CM0001       55
20060105   CM0002       50

20060105   CM0006      65  -> 12. 새로운 로우 데이터 추가

1. RENAME students TO student_t;
2. ALTER TABLE student_t DROP COLUMN forename;
3. ALTER TABLE student_t ADD (forename VARCHAR2(20));
	UPDATE student_t
	SET forename = 'charles'
	WHERE student_no = '20060101 '; ...

4. ALTER TABLE student_t ADD CONSTRAINT u_forename UNIQUE (forename);
5. ALTER TABLE student_t MODIFY forename NOT NULL;
6. ALTER TABLE student_t DROP CONSTRAINT pk_students;
7. ALTER TABLE student_t ADD CONSTRAINT pk_student_t PRIMARY KEY (student_no);
8. ALTER TABLE student_t ADD CONSTRAINT ck_student_no 
   CHECK (student_no BETWEEN 20060001 AND 20069999);
9. ALTER TABLE marks RENAME COLUMN mark TO marks;
10. ALTER TABLE marks MODIFY (marks NUMBER(2,0));
11. ALTER TABLE marks ADD CONSTRAINT fk_marks
    FOREIGN KEY (module_code) REFERANCE modules(module_code);
12. INSERT INTO marks VALUES ('20060105','CM0006',65);



CREATE TABLE STUDENTS (
STUDENT_NO    CHAR(8) CONSTRAINT PK_STUDENTS PRIMARY KEY,
SURNAME       VARCHAR2(10),
FORENAME      VARCHAR2(10)
);

CREATE TABLE MODULES (
MODULE_CODE   CHAR(10) CONSTRAINT PK_STUDENTS PRIMARY KEY,
MODULE_NAME   VARCHAR2(20)
);

CREATE TABLE MARKS (
STUDENT_NO    CHAR(8),
MODULE_CODE   CHAR(10),
MARK          NUMBER(2)
);

insert into students values ('20060101','Dickens','Charles');
insert into students values ('20060102','ApGwilym','Dafydd');
insert into students values ('20060103','Zola','Emile');
insert into students values ('20060104','Mann','Thomas');
insert into students values ('20060105','Stevenson','Robert');

insert into modules values ('CM0001', 'Databases');
insert into modules values ('CM0002', 'Programming Languages');
insert into modules values ('CM0003', 'Operating Systems');
insert into modules values ('CM0004', 'Graphics');

insert into marks values ('20060101', 'CM0001', 80);
insert into marks values ('20060101', 'CM0002', 65);
insert into marks values ('20060101', 'CM0003', 50);
insert into marks values ('20060102', 'CM0001', 75);
insert into marks values ('20060102', 'CM0003', 45);
insert into marks values ('20060102', 'CM0004', 70);
insert into marks values ('20060103', 'CM0001', 60);
insert into marks values ('20060103', 'CM0002', 75);
insert into marks values ('20060103', 'CM0004', 60);
insert into marks values ('20060104', 'CM0001', 55);
insert into marks values ('20060104', 'CM0002', 40);
insert into marks values ('20060104', 'CM0003', 45);
insert into marks values ('20060105', 'CM0001', 55);
insert into marks values ('20060105', 'CM0002', 50);

commit;

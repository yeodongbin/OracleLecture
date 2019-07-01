CREATE TABLE account (
no            NUMBER(4) PRIMARY KEY,
date          DATE,
code         VARCHAR2(14),
withdrawar NUMBER(8),
deposit      NUMBER(10),
balance      NUMBER(12),
branch_code CHAR(8)
);

문제1. 다음 테이블(nike)을 만드시오.
id    : 문자 10자리
style : 
color : 
owner : 
c_size  : XS, S, M, L, XL, XXL만 입력가능
gender: M, F만 입력 가능
count : 
m_date  : DATE

CREATE TABLE nike (
nike_id       CHAR(10)
                CONSTRAINT nike_no PRIMARY KEY,
nike_style    VARCHAR2(20), 
color          VARCHAR2(20),
nike_owner VARCHAR2(12),
c_size         CHAR(3),
gender       CHAR(1),
nike_count  NUMBER(10),
m_date       DATE
);

DROP TABLE ACCOUNT;

RENAME  STU_NO TO STU_NUMBER;

// 컬럼 이름 변경
ALTER TABLE STU_TEST
RENAEM COLUMN STU_NO TO STU_NUMBER;

//컬럼 추가
ALTER TABLE STU_TEST 
ADD (STU_BMI NUMBER(5,2));

//컬럼 타입 변경
ALTER TABLE STU_TEST
MODIFY (STU_BMI VARCHAR2(20));

//컬럼 삭제
ALTER TABLE STU_TEST
DROP COLUMN STU_BMI;

//제약조건 추가
PK
ALTER TABLE STU_TEST
ADD CONSTRAINTS 
pk_stu_test PRIMARY KEY (STU_NUMBER);

UNIQUE
ALTER TABLE STU_TEST
ADD CONSTRAINT uni_stu_height UNIQUE (STU_height);

//제약조건 삭제
ALTER TABLE STU_TEST 
DROP CONSTRAINT pk_stu_test

CREATE TABLE EMP3 (
EMPNO   NUMBER        CONSTRAINT pk_empno PRIMARY KEY,
ENAME   VARCHAR2(20) CONSTRAINT nn_ename NOT NULL,
JOB        VARCHAR2(20) CONSTRAINT uni_job     UNIQUE,
MGR       NUMBER         CONSTRAINT ck_mgr     CHECK (MGR BETWEEN 1 AND 9999),
HIREDATE DATE             DEFAULT SYSDATE
);

문제2. 다음 테이블(adidas)을 만드시오.
id    : 기본키
style : unique
color : 색깔 입력은 항상 존재
owner : 제약 조건 없음                       -> not null 추가
c_size  : XS, S, M, L, XL, XXL만 입력가능 -> check 조건 삭제
gender: M, F만 입력 가능
count : 제약 조건 없음                       -> check 조건 추가 (0<= count <= 1000)
m_date  : default sysdate                    -> unique 조건 추가 

CREATE TABLE ADIDAS(
adidas_id      NUMBER         CONSTRAINT pk_adidas PRIMARY KEY,
adidas_color  VARCHAR2(10) CONSTRAINT nn_color NOT NULL,
owner          VARCHAR2(10),
c_size           CHAR(3)          CONSTRAINT ck_c_size CHECK(c_size IN ('XS','S','M','L','XL','XXL')),
gender         CHAR(1)          CONSTRAINT ck_gender CHECK (gender IN ('F', 'M')),
adidas_count NUMBER(10),
m_date         DATE DEFAULT SYSDATE
);

not null 추가
ALTER TABLE ADIDAS MODIFY owner NOT NULL;
ALTER TABLE ADIDAS MODIFY owner NULL;
ALTER TABLE ADIDAS MODIFY owner CONSTRAINT nn_color NOT NULL;

check 조건 추가 (0<= count <= 1000)
ALTER TABLE ADIDAS
ADD CONSTRAINT ck_count CHECK (adidas_count >=0 AND adidas_count <=1000)

unique 조건 추가 
ALTER TABLE ADIDAS
ADD CONSTRAINT uni_date UNIQUE (m_date);

check 조건 삭제
ALTER TABLE ADIDAS 
DROP CONSTRAINT ck_c_size;


문제3. 
테이블 명 : students -> 1.student_t 테이블명 변경
STUDENT_NO(PK)   SURNAME        FORENAME -> 2.삭제 FORENAME ->3.FORENAME 생성, 4.UNIQUE, 5.NOT NULL
20060101              Dickens            Charles                                           charles
20060102              ApGwilym         Dafydd                                           dafydd
20060103              Zola                 Emile                                             emile
20060104              Mann               Thomas                                          thomas
20060105              Stevenson         Robert                                            robert
-> 6.students테이블 PK 삭제 -> 7.PK 새로 추가 -> 8.STUDENT_NO 에 CHECK (20060001 ~ 20069999) 제약 설정

테이블 명 : modules
MODULE_CODE(PK)   MODULE_NAME
CM0001           Databases
CM0002           Middle Ware -> 11. 컬럼추가, marks FK 추가
CM0003           Operating Systems
CM0004           Graphics

테이블 명: marks
STUDENT_NO   MODULE_CODE   MARK -> 9.MARKS으로 컬럼명 변경, 10. 컬럼타입 변경 (NUMBER(2,0))
20060105   CM0006      65                   -> 12. 새로운 로우 데이터 추가
20060101   CM0001      80
20060101   CM0002      65
20060101   CM0003      50
20060102   CM0001      75
20060102   CM0003      45
20060102   CM0004      70
20060103   CM0001      60
20060103   CM0002      75
20060103   CM0004      60
20060104   CM0001      55
20060104   CM0002      40
20060104   CM0003      45
20060105   CM0001      55
20060105   CM0002      50

CREATE TABLE STUDENTS (
STUDENT_NO    CHAR(8)         CONSTRAINT PK_STUDENTS PRIMARY KEY,
SURNAME         VARCHAR2(10),
FORENAME       VARCHAR2(10)
);

CREATE TABLE MODULES (
MODULE_CODE    CHAR(10)      CONSTRAINT    PK_STUDENTS PRIMARY KEY,
MODULE_NAME   VARCHAR2(20)
);

CREATE TABLE MARKS (
STUDENT_NO      CHAR(8),
MODULE_CODE   CHAR(10),
MARK                NUMBER(2)
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


1. RENAME students TO student_t;

2. ALTER TABLE student DROP COLUMN forename;

3. ALTER TABLE student ADD (forename VARCHAR2(20));
UPDATE student SET forename = 'charles' WHERE student_no = 20060101;
UPDATE student SET forename = 'dafydd' WHERE student_no = 20060102;
UPDATE student SET forename = 'emile'   WHERE student_no = 20060103;
UPDATE student SET forename = 'thomas' WHERE student_no = 20060104;
UPDATE student SET forename = 'robert'   WHERE student_no = 20060105;

4. alter table student_t add constraint student_uk unique(forename);

5. alter table student_t modify forename not null;

6. alter table student_t drop constraint student_pk;

   select * 
   from user_constraints
   where table_name = 'STUDENT';

7. alter table student_t
   add constraint student_no_pk primary key (student_no);

8. alter table student_t
   add constraint student_no_check check(student_no >= 20060001 and student_no <= 20069999);

9. alter table marks 
   rename column mark to marks;

10. ALTER TABLE marks 
     MODIFY (marks NUMBER(2,0));

11 INSERT INTO modules VALUES ('CM0002', 'Middle Ware');
    ALTER TABLE marks ADD CONSTRAINT mod_fk 
    FOREIGN KEY (module_code) REFERENCES modules(module_code);

12. insert into marks values ('20060105', 'CM0004', 65);

























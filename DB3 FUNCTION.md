TO_CHAR
TO_NUMBER
TO_DATE

select to_char(123456789) + 1 as result
from dual;

select to_char(123456789, '$999999999') 
as result
from dual;

select to_char(123456789, '999,999,999') 
as result
from dual;

select to_char(123456789, 'L999,999,999') 
as result
from dual;

select to_date('26081983','DD-MM-YYYY')
from dual;

NVL
NVL2

select ename, mgr
from emp

SELECT ENAME, NVL(MGR, 1111)
FROM EMP;

SELECT ENAME, NVL(COMM, 0) + SAL AS INCOME
FROM EMP;

SELECT ENAME, NVL2(COMM, SAL+COMM, SAL) AS RESULT
FROM EMP;

문1 모든 사원의 커미션을 200씩
    추가하여 출력하시오.
    NVL, NVL2 모두 이용할 것
SELECT ENAME, NVL(COMM,0) +200
FROM EMP; 

SELECT ENAME, NVL2(COMM, COMM+200, 200) AS COMM
FROM EMP;

문2 mgr (상급자 사원번호)가 없는 사원의 경우
    '사장님'으로 나타나도록 출력하시오.
    단, 사원 이름, 상급자로 출력할 것

SELECT ENAME, NVL(TO_CHAR(MGR),'사장님') AS 상급자
FROM EMP;

SELECT ENAME, NVL2(TO_CHAR(MGR), TO_CHAR(MGR), '사장님') 
              AS 상급자
FROM EMP;

- NULLIF, COALESCE
NULLIF(인수1 ,인수2 ) => nuLL

SELECT NVL(NULLIF('A','A'),'널값') FROM DUAL;

SELECT NVL(NULLIF(TO_CHAR(STU_WEIGHT), '90'),'몸무게 90KG')
FROM STUDENT;

SELECT COALESCE(200, NULL, 10, 100, NULL)
FROM DUAL;

- CASE
SELECT EMPNO, ENAME, SAL, 
       CASE JOB WHEN 'SALESMAN' THEN SAL*1.1
		WHEN 'CLERK'    THEN SAL*1.15
  		WHEN 'MANAGER'  THEN SAL*1.2
                ELSE SAL
       END AS 급여인상
FROM EMP;

- Decode
SELECT EMPNO, ENAME, SAL, 
       DECODE(JOB, 'SALESMAN', SAL*1.1, 
                   'CLERK', SAL*1.15,
                   'MANAGER',SAL*1.2,
                    SAL) AS 급여인상
FROM EMP;

문3 학생들 중에
   기계과 학생의 등록금 1000만원
   전기전자 학생의 등록금 500만원
   컴퓨터정보 학생의 등록금 300만원
   이라고 하자. 
   학번, 이름, 과, 등록금을 출력하시오.
   단, 2013학번만 출력하시오.
-CASE
select stu_no, stu_name, stu_dept,
       case stu_dept when '기계'       then '1000만원'
		     when '전기전자'   then '500만원'
		     when '컴퓨터정보' then '300만원'
                     else '없음'
       end as 등록금
from student
where stu_no like '2013%';

-DECODE
SELECT STU_NO, STU_NAME, STU_DEPT, 
       DECODE(STU_DEPT,'기계','1000만원',
                       '전기전자','500만원',
                       '컴퓨터정보','300만원',
                       '없음')
FROM STUDENT
WHERE STU_NO LIKE '2013%';

문4 학생들의 키가 측정되어 있지 않을 경우,
    '재검'이라고 출력하고, 키 데이터가 있으면
    '필요없음'이라고 검사사항을 출력하시오. 
    출력 항목은 학생이름, 키, 검사사항 입니다.
select stu_name, stu_height,
       case stu_height when NULL then '재검'
                       else '필요없음'
       end as 검사사항
from student;

select stu_name, stu_height, 
       nvl2(stu_height,'필요없음','재검') as 검사사항
from student;



문5 사원들의 사원이름, 사원직무를 연결하여 검색하시오.
   (예: King President )
select initcap(ename) ||' '|| initcap(job)
from emp;

select concat(concat(initcap(ename),' '),initcap(job))
from emp;

문6 사장님의 급여를 2배 
    인상하여 출력하시오.
    (decode)
    이름, 사원번호, 급여

SELECT ENAME, EMPNO, 
       DECODE(MGR, NULL, SAL*2, SAL)
       AS SAL
FROM EMP;

- 그룹함수
SELECT COUNT(EMPNO) FROM EMP;
SELECT COUNT(*) FROM EMP;
SELECT COUNT(MGR) FROM EMP;
SELECT COUNT(COMM) FROM EMP;

SELECT SUM(SAL) FROM EMP;
SELECT AVG(SAL) FROM EMP;
SELECT MAX(SAL) FROM EMP;
SELECT MIN(SAL) FROM EMP;
SELECT STDDEV(SAL) FROM EMP;
SELECT VARIANCE(SAL) FROM EMP;

SELECT AVG(SAL) 
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT MAX(SAL) 
FROM EMP
WHERE JOB = 'SALESMAN';

- GROUP BY
SELECT JOB, ROUND(AVG(SAL),0) AS AVG
FROM EMP
GROUP BY JOB
ORDER BY AVG DESC ;

문7 SALESMAN의 커미션 평균을 출력하시오.
SELECT AVG(NVL(COMM,0))
FROM EMP
WHERE JOB = 'SALESMAN';

문8 직무별 최대 임금을 출력하시오.
SELECT JOB, MAX(SAL)
FROM EMP
GROUP BY JOB;

문9 직무별 평균 급여(SAL+COMM) 를 
   출력하시오.
SELECT JOB, 
       ROUND(AVG(SAL + NVL(COMM,0)),0) AS 평균급여
FROM EMP
GROUP BY JOB
ORDER BY JOB;

5 SELECT 
1 FROM
2 WHERE 조건(단일행)
3 GROUP BY
4 HAVING 조건(그룹)
6 ORDER BY 

SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE SAL > 1000
GROUP BY DEPTNO
HAVING AVG(SAL) > 2000;

문10 직무별(JOB), 직무별 사원들의 인원수를 
출력하시오.
단, 직무인원이 4명이상인 직무만 출력하시오.
10번 답입니다.
select job, count(*)
from emp
group by job
having count(empno) >= 4;


문11 사원수가 5명 이상인 부서의 부서번호와 사원수를 
출력하시오.
select deptno, count(empno) as 사원수
from emp
group by deptno 
having count(empno) >=5;


문12 부서번호, 부서별 평균 임금을 출력하시오.
단, 평균 임금이 2000이하인 부서는 제외
select deptno, round(avg(sal),0)
from emp
group by deptno
having avg(sal) > 2000;

문13 직무중 가장 적게 수입을 가지는 직무의
평균 월급을 출력하시오. (커미션 포함)
select avg(sal+nvl(comm,0))
from emp
group by job
having sum(sal+nvl(comm,0)) = 
              (select min(sum(sal+nvl(comm,0)))
               from emp
               group by job);

문14 직무별 사원 평균 급여, 분산, 표준편차를 
검색하시오.
select job, avg(sal), stddev(sal), variance(sal)
from emp
group by job;


문15 직무별, 부서별 사원의 급여 합이 많은 
     순으로 검색하시오.
select job, deptno, sum(sal+ nvl(comm,0)) as 급여합
from emp
group by job, deptno
order by 급여합 desc


문16 부서별, 직무별 사원들의 급여 편차가
     적은 순으로 검색하시오.
select deptno, job, round(stddev(sal+ nvl(comm,0))) as 급여편차
from emp
group by deptno, job
having count(job) not in (0,1)
order by 급여편차

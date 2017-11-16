select a.stu_no, a.stu_name, a.avg_grade
from (select stu_no, stu_name, avg(enr_grade) as avg_grade
      from enrol natural join student
      where stu_dept = '컴퓨터정보'
      group by stu_no, stu_name
      order by 3 desc) a
where rownum < 2;
      


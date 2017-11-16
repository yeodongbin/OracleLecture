select stu_no, stu_name ,avg(enr_grade)
from student natural join enrol
where stu_dept = '컴퓨터정보'
group by stu_no, stu_name
order by 3 desc;
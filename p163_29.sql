select stu_no, stu_name ,avg(enr_grade)
from student natural join enrol
where stu_dept = '��ǻ������'
group by stu_no, stu_name
order by 3 desc;
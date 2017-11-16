
select stu_no, stu_name, sub_name, enr_grade
from enrol natural join student natural join subject
where enr_grade > (select avg(stu_avg)
                   from (select stu_no, avg(enr_grade) stu_avg
                         from enrol
                         group by stu_no));

select sub_name, sub_prof
from student, subject, enrol
where student.STU_NO = enrol.STU_NO
and subject.sub_no = enrol.sub_no
and stu_name = '±Ë¿Œ¡ﬂ';

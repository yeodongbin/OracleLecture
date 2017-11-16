create or replace function pro8_5
(v_dept student.stu_dept%type)
return number
is
    v_stddev number;
begin
    select stddev(enr_grade) into v_stddev
    from student natural join enrol
    where stu_dept = v_dept;
    return v_stddev;
end pro8_5;
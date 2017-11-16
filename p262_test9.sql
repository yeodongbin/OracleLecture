create or replace procedure test9
(v_sub_no in enrol.sub_no%type)
is
v_stu_no    enrol.stu_no%type;
v_enr_grade enrol.enr_grade%type;

cursor t_cursor(vv_sub_no number) is
    select student.stu_no, enr_grade
    from student, enrol
    where student.stu_no = enrol.stu_no and
        enrol.sub_no = vv_sub_no;
        
begin
    open t_cursor(v_stu_no);
    loop
        fetch t_cursor into v_stu_no, v_enr_grade;
        exit when t_cursor%notfound;
        dbms_output.put_line(v_stu_no||' '|| v_enr_grade);
    end loop;
    close t_cursor;
end test9;
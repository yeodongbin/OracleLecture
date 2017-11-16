create or replace procedure proc1
is
v_empno emp.empno%type;
v_ename emp.ename%type;
v_dname dept.dname%type;

cursor result is
	select empno, ename, dname
	from emp natural join dept
	where sal>2000
	order by dname;
begin

open result;
loop
fetch result into v_empno, v_ename, v_dname
;
exit when result%notfound;
dbms_output.put_line(v_empno ||','|| v_ename ||','|| v_dname);
end loop;
close result;
end proc1;
/

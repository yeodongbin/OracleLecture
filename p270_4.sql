CREATE OR REPLACE FUNCTION pro8_4 RETURN emp.ename%TYPE IS
    v_ename   emp.ename%TYPE;
BEGIN
    SELECT   ename
    INTO     v_ename
    FROM     emp
    WHERE    sal = (SELECT MAX(sal)
                    FROM emp);

    RETURN v_ename;
END pro8_4;
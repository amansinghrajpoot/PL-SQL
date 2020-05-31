DECLARE
    dquery   VARCHAR2(500);
    curid    NUMBER(12);
    emprec   employees%rowtype;
    empid    NUMBER;
    names    VARCHAR2(50);
    exe      NUMBER;
    emp_id   NUMBER;
    ntab     dbms_sql.number_table;
BEGIN
    curid     := dbms_sql.open_cursor;
    emp_id    := &empid;
    dquery    := 'select employee_id, first_name from employees where employee_id = :empid';
    dbms_output.put_line(dquery);
    dbms_sql.parse(curid, dquery, dbms_sql.native);
    dbms_sql.define_column(curid, 1, empid);
    dbms_sql.define_column(curid, 2, names, 50);
    dbms_sql.bind_variable(curid, ':empid', emp_id);
    exe       := dbms_sql.execute(curid);
    LOOP
        EXIT WHEN dbms_sql.fetch_rows(curid)= 0;
        dbms_sql.column_value(curid, 1, empid);
        dbms_sql.column_value(curid, 2, names);
        dbms_output.put_line(empid || ' ' || names);
    END LOOP;

    dbms_sql.close_cursor(curid);
END;
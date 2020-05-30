DECLARE
    cursor_id   INTEGER;
    q           VARCHAR2(500);
    rec         NUMBER;
    col_no      NUMBER;
    coltab      dbms_sql.desc_tab;
    empid       NUMBER;
BEGIN
    cursor_id   := dbms_sql.open_cursor();
    dbms_output.put_line(cursor_id);
    q           := 'select * from employees where employee_id = 100';
    dbms_sql.parse(cursor_id, q, dbms_sql.native);
    dbms_output.put_line(q);
    dbms_output.put_line(rec);
    dbms_sql.describe_columns(cursor_id, col_no, coltab);
    FOR i IN 1..col_no LOOP dbms_output.put_line(coltab(i).col_name || ' ' || coltab(i).col_type);
    END LOOP;

    dbms_sql.define_column(cursor_id, 1, empid);
    empid       := dbms_sql.execute_and_fetch(cursor_id);
    dbms_output.put_line(empid);
    dbms_sql.column_value(cursor_id, 1, empid);
    dbms_output.put_line(empid);
    dbms_sql.close_cursor(cursor_id);
END;
/
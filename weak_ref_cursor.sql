DECLARE
    type refc is ref CURSOR ;      -- weak ref cursor

    TYPE nt IS
        TABLE OF employees%rowtype;
    v     nt;
    
    type refcur is ref cursor return employees%rowtype;    --- ref cursor
    ruf refcur;
    cur refc;
BEGIN
   
    OPEN cur for select * from employees;
    ruf  := cur;
    FETCH cur BULK COLLECT INTO v;
    FOR i IN v.first()..v.last() 
    LOOP dbms_output.put_line(v(i).employee_id);
    END LOOP;

    CLOSE cur;
END;
/
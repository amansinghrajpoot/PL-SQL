create package emptype_pkg as
    type emprec is record ( last_name hr.employees.last_name%type, salary hr.employees.salary%type);
    type emptab is table of emprec;
    end;

/
create or replace function emp_cur(start_eid pls_integer, end_eid pls_integer) return emptype_pkg.emptab pipelined as

        rec emptype_pkg.emprec;
        tab emptype_pkg.emptab;
    refc sys_refcursor;

    begin
        open refc for select LAST_NAME, SALARY from EMPLOYEES where EMPLOYEE_ID between start_eid and end_eid ;
        loop
            fetch refc into rec;
            exit when refc%notfound;
            pipe row ( rec );
        end loop;
        close refc;
        return;
    end;

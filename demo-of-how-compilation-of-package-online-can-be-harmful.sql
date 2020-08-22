-- demo of how compilation of  package online can be harmful.

create or replace package pkg as
    procedure p;
end pkg;
/

create or replace package body pkg as
    g_var number := 42;
    procedure p is
    begin
        null;
    end p;
end pkg;
/

create or replace procedure test_execute as
begin
    pkg.p;
    dbms_session.sleep(20);
end test_execute;
/
create or replace procedure test_compile as
begin
    execute immediate 'alter package pkg compile body';
end test_compile;
/

declare
    v_base_time date := sysdate;
begin
    for i in 1 .. 8
    loop
        dbms_scheduler.create_job(
          job_name   => '"session#' || i || ' (' || 
                        case i when 3 then 'developer' else 'end user' end ||
                        ')"',
          job_type   => 'STORED_PROCEDURE',
          job_action => case i when 3 then 'test_compile' else 'test_execute' end,
          start_date => v_base_time + numtodsinterval(i, 'second'),
          enabled    => true);
    end loop;
end;
/



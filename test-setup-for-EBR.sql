create table people (
  id           number(9)    not null constraint people_pk primary key,
  first_name   varchar2(15) not null,
  last_name    varchar2(20) not null,
  phone_number varchar2(20)
);
/
create or replace package people_dl as
    procedure add
    (
        i_id           in people.id%type,
        i_first_name   in people.first_name%type,
        i_last_name    in people.last_name%type,
        i_phone_number in people.phone_number%type
    );
    procedure remove
    (
        i_id           in people.id%type
    );
end people_dl;
/

create or replace package body people_dl as
    procedure add
    (
        i_id           in people.id%type,
        i_first_name   in people.first_name%type,
        i_last_name    in people.last_name%type,
        i_phone_number in people.phone_number%type
    ) is
    begin
        insert into people (id,first_name,last_name,phone_number)
        values (i_id,i_first_name,i_last_name,i_phone_number);
        --
        dbms_output.new_line;
        dbms_output.put_line('person was added using the BASE version');
        --
    end add;

    procedure remove(i_id in people.id%type) is
    begin
        delete people where id = i_id;
    end remove;
end people_dl;
/




create or replace package app_mgr as
    procedure do_something;
end app_mgr;       
/


create or replace package body app_mgr as
    procedure do_something is
    begin
        people_dl.add(123, 'John', 'Doe', null);
        people_dl.remove(123);
        commit;
    end do_something;
end app_mgr;       
/




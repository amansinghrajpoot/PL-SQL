CREATE TABLE people (
    id             NUMBER(9) NOT NULL
        CONSTRAINT people_pk PRIMARY KEY,
    first_name     VARCHAR2(15) NOT NULL,
    last_name      VARCHAR2(20) NOT NULL,
    phone_number   VARCHAR2(20)
);
/
CREATE OR REPLACE PACKAGE people_dl AS
    PROCEDURE add (
        i_id             IN   people.id%TYPE,
        i_first_name     IN   people.first_name%TYPE,
        i_last_name      IN   people.last_name%TYPE,
        i_phone_number   IN   people.phone_number%TYPE
    );

    PROCEDURE remove (
        i_id IN people.id%TYPE
    );

END people_dl;
/
CREATE OR REPLACE PACKAGE BODY people_dl AS

    PROCEDURE add (
        i_id             IN   people.id%TYPE,
        i_first_name     IN   people.first_name%TYPE,
        i_last_name      IN   people.last_name%TYPE,
        i_phone_number   IN   people.phone_number%TYPE
    ) IS
    BEGIN
        INSERT INTO people (
            id,
            first_name,
            last_name,
            phone_number
        ) VALUES (
            i_id,
            i_first_name,
            i_last_name,
            i_phone_number
        );
        --

        dbms_output.new_line;
        dbms_output.put_line('person was added using the BASE version');
        --
    END add;

    PROCEDURE remove (
        i_id IN people.id%TYPE
    ) IS
    BEGIN
        DELETE people
        WHERE
            id = i_id;

    END remove;

END people_dl;
/
---------------------------------------------------------------

------------------------------------------
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;
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
create noneditionable procedure its_non_ed_proc as 
begin

dbms_output.put_line('This is non editionable procedure');

end;
/
select * from all_editions;
/
create edition v1;
/
alter session set edition = V1;
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;
/
set serveroutput on;
/
exec its_non_ed_proc;     -- single instance shared in all editions
/
alter package people_dl compile;  --- compiling without specifying specs or body compile both specs and body
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;
/
alter package app_mgr compile specification; -- only package specificaion get actualized into edition;
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;
/
create edition v2;
/
select * from all_editions;
/
alter session set edition = V2;
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;
/
alter procedure its_non_ed_proc compile;  -- trying to actualize non ed procedure in edition v2
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;    -- only single instance is usable of its_non_ed_proc
/
alter table people rename to people$base;
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects; -- all object directly depending on table are invalidated in all edition;
/
create editionable view peoplev1 as Select * from people$base;
/
create or replace package people_dl as
    procedure add
    (
        i_id           in peoplev1.id%type,
        i_first_name   in peoplev1.first_name%type,
        i_last_name    in peoplev1.last_name%type,
        i_phone_number in peoplev1.phone_number%type
    );
    procedure remove
    (
        i_id           in peoplev1.id%type
    );
end people_dl;  --compile package and point to the new editionable view
/
create or replace package body people_dl as
    procedure add
    (
        i_id           in peoplev1.id%type,
        i_first_name   in peoplev1.first_name%type,
        i_last_name    in peoplev1.last_name%type,
        i_phone_number in peoplev1.phone_number%type
    ) is
    begin
        insert into peoplev1 (id,first_name,last_name,phone_number)
        values (i_id,i_first_name,i_last_name,i_phone_number);
        --
        dbms_output.new_line;
        dbms_output.put_line('person was added using the v2 version');
        --
    end add;

    procedure remove(i_id in peoplev1.id%type) is
    begin
        delete peoplev1 where id = i_id;
    end remove;
end people_dl;
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;
/
alter package app_mgr compile body; -- recompile dependent objects which are invalidated
/
SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects; -- nothing is invalidated now
    /
---- test new changes work or not

exec app_mgr.do_something; -- everything is working
/
desc people$base;
/
alter table people$base add     --- we have changed table structure in this edition but our apps using editionable view in this edtion, client working on this session will not have interruption
(
 eye_color varchar2(10)
)
/
desc people$base;
/
desc peoplev1;
/

SELECT
    object_name,
    object_type,
    editionable,
    edition_name,
    status
FROM
    user_objects;
    /
alter session set edition = v2;
/
exec app_mgr.do_something; -- everything is working
/








SET SERVEROUTPUT ON;


DECLARE
    a   NUMBER := 8;
    b   NUMBER;

    FUNCTION testoutparam (
        a OUT NUMBER
    ) RETURN NUMBER IS
    BEGIN
        a := 7;
        RAISE no_data_needed;
        RETURN 0;
    END;

BEGIN
    b := testoutparam(a);
    dbms_output.put_line(a);
EXCEPTION
    WHEN no_data_needed THEN
        dbms_output.put_line(a);
END;
/

DECLARE
    a   NUMBER := 8;
    b   NUMBER;

    FUNCTION testoutparam (
        a OUT NOCOPY NUMBER
    ) RETURN NUMBER IS
    BEGIN
        a := 7;
        RAISE no_data_needed;
        RETURN 0;
    END;

BEGIN
    b := testoutparam(a);
    dbms_output.put_line(a);
EXCEPTION
    WHEN no_data_needed THEN
        dbms_output.put_line(a);
END;


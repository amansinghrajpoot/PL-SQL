/*empty_clob vs createtemporary()*/
DECLARE
    elob   CLOB;
    tlob   CLOB;
BEGIN
    IF elob IS NULL THEN
        dbms_output.put_line('elob is null');
    ELSE
        dbms_output.put_line('elob has a locator');
    END IF;

    IF tlob IS NULL THEN
        dbms_output.put_line('tlob is null');
    ELSE
        dbms_output.put_line('tlob has a locator');
    END IF;

    elob := empty_clob;
    dbms_lob.createtemporary(tlob, false);
    
    IF elob IS NULL THEN
        dbms_output.put_line('elob is null');
    ELSE
        dbms_output.put_line('elob has a locator');
    END IF;

    IF tlob IS NULL THEN
        dbms_output.put_line('tlob is null');
    ELSE
        dbms_output.put_line('tlob has a locator');
    END IF;
    
    dbms_lob.freetemporary(elob); -- exception
    dbms_lob.freetemporary(tlob);
END;
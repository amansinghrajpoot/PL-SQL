DECLARE
    h   NUMBER;
    th   NUMBER;
    c   CLOB;
BEGIN
    h := dbms_metadata.open('TABLE');
    dbms_metadata.set_filter(h, 'SCHEMA', 'SCRAP');
    dbms_metadata.set_filter(h, 'NAME', 'EMPLOYEES');
    th := dbms_metadata.add_transform(h, 'DDL');
    c := dbms_metadata.fetch_clob(h);
    dbms_metadata.close(h);
    dbms_output.put_line(c);
END;
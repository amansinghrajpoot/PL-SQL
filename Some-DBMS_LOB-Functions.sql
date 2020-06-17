/*empty_clob vs createtemporary()*/
DECLARE
    elob   CLOB;
    tlob   CLOB;
    amount number;
    output long;
BEGIN
    elob := 'Amansinghrajpoot';
    amount := 2;
    dbms_output.put_line(elob);
    dbms_lob.createtemporary(tlob, false);
    dbms_lob.copy(tlob, elob, 4000);
    dbms_output.put_line(tlob);
    dbms_lob.erase(tlob,amount,2);
    dbms_output.put_line(tlob); 
    dbms_output.put_line(amount);
    dbms_output.put_line(dbms_lob.getchunksize(tlob));
    dbms_output.put_line(dbms_lob.getlength(tlob));
    dbms_output.put_line(dbms_lob.GET_STORAGE_LIMIT(tlob));
    dbms_output.put_line(dbms_lob.isopen(tlob));
    dbms_lob.open(tlob, 1);
    dbms_output.put_line(dbms_lob.isopen(tlob));
    dbms_lob.trim(tlob,2);
    dbms_output.put_line((tlob));
    tlob := 'Amansinghrajpoot';
    dbms_output.put_line((tlob));
    output := dbms_lob.substr(tlob,4,1);
    dbms_output.put_line((output));
    
    
END;
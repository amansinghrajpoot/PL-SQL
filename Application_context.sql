CREATE CONTEXT scrapcon USING conpc;

DROP CONTEXT scrapcon;
/

CREATE OR REPLACE PROCEDURE conpc AS
USERNAME VARCHAR2(20);
BEGIN
     SELECT USER INTO USERNAME FROM DUAL;
    dbms_session.set_context('scrapcon', 'schema', USERNAME);
END;
/
execute conpc;
/

SELECT
    sys_context('SCRAPCON', 'SCHEMA')
FROM
    dual;
    
/
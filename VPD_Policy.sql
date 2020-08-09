CREATE OR REPLACE FUNCTION hr_policy_func (
    schema_name   IN   VARCHAR2,
    object_name   IN   VARCHAR2
) RETURN VARCHAR2 AS
    username    VARCHAR2(200);
    predicate   VARCHAR2(2000);
BEGIN
    SELECT
        user
    INTO username
    FROM
        dual;

    IF username = 'HR' THEN
        predicate := 'EMPLOYEE_ID IS NOT NULL';
    END IF;
    RETURN predicate;
END;
/

BEGIN
    DBMS_RLS.ADD_POLICY(
   object_schema         => 'SCRAP', 
   object_name           => 'VPD_TABLE',
   policy_name           => 'HRPOLICY',
   FUNCTION_SCHEMA       => 'SCRAP',
   policy_function       => 'HR_POLICY_FUNC'
   );
END;
/
EXECUTE sys.dbms_rls.drop_policy('SCRAP', 'VPD_TABLE', 'HRPOLICY');
/



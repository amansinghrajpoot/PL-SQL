BEGIN
    dbms_rls.add_policy(object_schema => 'SCRAP', object_name => 'VPD_TABLE', policy_name => 'HRPOLICY', function_schema => 'SCRAP'
    , policy_function => 'HR_POLICY_FUNC');
END;
/

EXECUTE sys.dbms_rls.drop_policy('SCRAP', 'VPD_TABLE', 'HRPOLICY');
/

BEGIN
    dbms_rls.add_policy_context(object_schema => 'SCRAP', object_name => 'VPD_TABLE', namespace => 'SCRAPCON', attribute => 'SCHEMA'
    );
END;
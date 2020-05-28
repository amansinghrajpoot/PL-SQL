variable empid number;
DECLARE
lv_sql VARCHAR2(500);
lv_employees_name VARCHAR2(50);
ln_employees_no number;
ln_salary NUMBER;
ln_manager NUMBER;
BEGIN
:empid := 100;
Dbms_output.put_line(:empid);
lv_sql := 'SELECT first_name,employee_id,salary FROM employees WHERE employee_id = :empid';
EXECUTE IMMEDIATE lv_sql INTO lv_employees_name,ln_employees_no, ln_salary using 200;
Dbms_output.put_line('employeesloyee Name:'||lv_employees_name);
Dbms_output.put_line('employeesloyee Number:'||ln_employees_no);
Dbms_output.put_line('Salary:'||ln_salary);
Dbms_output.put_line('Manager ID:'||ln_manager);
END;
/
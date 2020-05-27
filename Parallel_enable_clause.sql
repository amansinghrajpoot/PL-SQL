CREATE OR REPLACE PACKAGE ppkg AS
    TYPE refcur IS REF CURSOR RETURN bigdata.controlmcopy%rowtype;
FUNCTION curpf(
    pc IN ppkg.refcur
)RETURN NUMBER
    PARALLEL_ENABLE( PARTITION pc BY HASH(jobname));

END;
/

CREATE OR REPLACE PACKAGE BODY ppkg AS

    FUNCTION curpf(
        pc IN ppkg.refcur
    )RETURN NUMBER
        PARALLEL_ENABLE(PARTITION pc by hash(jobname))AS

    n      NUMBER := 0;
    recm   bigdata.controlmcopy%rowtype;
    TYPE vtype IS
        TABLE OF recm%TYPE;
    v      vtype;
BEGIN
    FETCH pc BULK COLLECT INTO v;
    FOR i IN v.first..v.last LOOP v(i).jobname := v(i).jobname;
    END LOOP;

    n := pc%rowcount;
    CLOSE pc;
    RETURN n;
END;

END;
/
DECLARE
    cur   ppkg.refcur;
    n     NUMBER;
BEGIN
    OPEN cur FOR SELECT *
                 FROM bigdata.controlmcopy;

    n := ppkg.curpf(cur);
    dbms_output.put_line(n);
END;
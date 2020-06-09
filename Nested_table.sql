CREATE OR REPLACE TYPE pnrow AS OBJECT(
    contact_type   CHAR(10),
    contact        NUMBER(13)
);
/
CREATE OR REPLACE TYPE pnarray IS
    TABLE OF pnrow;
/

CREATE TABLE pn(
    names VARCHAR2(20),
    pnumber pnarray)
    nested table pnumber store as pnumbertable;
/
desc pn;

insert into pn values('Alex', pnarray(pnrow('Home',54998), pnrow('Work',989878)));
/
select pn.names, f.*
from pn cross join table (pnumber) f;
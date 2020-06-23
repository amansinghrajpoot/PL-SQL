CREATE OR REPLACE TYPE person AS OBJECT(
    names   VARCHAR2(20),
    age     NUMBER(4, 2)
);
/

CREATE TABLE person_table OF person;

/
INSERT INTO person_table VALUES(
    person('Aman', 24)
);

INSERT INTO person_table VALUES(
    person('Will', 24)
);

SELECT 
       e.names,
       e.age
FROM person_table e;


DROP TABLE person_table PURGE;

DROP TYPE person;
CREATE TABLE TBL_STUDENT
(
	UID SERIAL PRIMARY KEY,
	NAME VARCHAR(20),
	AGE INT
);

INSERT INTO TBL_STUDENT(NAME, AGE)
VALUES
	('PUNIT KUMAR', 20),
	('ANAND', 26),
	('SAHIL', 22),
	('PRISHA', 23);

---------- Experiment 07 -------------------
-- MEDIUM: 
-- Design a Trigger: Whenever there is an insertion on student table then currently, inserted or deleted 
-- Row Should be printed as it as on the output console window.

-- Solution:

CREATE OR REPLACE FUNCTION FN_TRG_STUDENT()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN
	IF TG_OP = 'INSERT' THEN
		RAISE NOTICE 'ID: % NAME: % AGE: %', NEW.uid, NEW.name, NEW.age;
		RETURN NEW;

	ELSIF TG_OP = 'DELETE' THEN
		RAISE NOTICE 'ID: % NAME: % AGE: %', OLD.uid, OLD.name, OLD.age;
		RETURN OLD;

	END IF;

	RETURN NULL;
END;
$$;


CREATE OR REPLACE TRIGGER TRG_STUDENT
AFTER INSERT OR DELETE
ON TBL_STUDENT
FOR EACH ROW
EXECUTE FUNCTION FN_TRG_STUDENT();



-- HARD
-- DESIGN A PORSTGRESQL TRIGGERS THAT: 

-- Whenever a new employee is inserted in tbl_employee, a record should be added to tbl_employee_audit like:
-- "Employee name <emp_name> has been added at <current_time>"

-- Whenever an employee is deleted from tbl_employee, a record should be added to tbl_employee_audit like:
-- "Employee name <emp_name> has been deleted at <current_time>"

CREATE TABLE tbl_employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    emp_salary NUMERIC
);

CREATE TABLE tbl_employee_audit (
    sno SERIAL PRIMARY KEY,
    message TEXT
);



CREATE OR REPLACE FUNCTION audit_employee_changes()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS 
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES ('Employee name ' || NEW.emp_name || ' has been added at ' || NOW());
        RETURN NEW;
        
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES ('Employee name ' || OLD.emp_name || ' has been deleted at ' || NOW());
        RETURN OLD;
    END IF;
    
    RETURN NULL;
END;
$$



CREATE TRIGGER trg_employee_audit
AFTER INSERT OR DELETE 
ON 
tbl_employee
FOR EACH ROW
EXECUTE FUNCTION audit_employee_changes();



--TESTING THE TRIGGER
-- Insert an employee
INSERT INTO tbl_employee(emp_name, emp_salary) VALUES ('Aman', 50000);

-- Delete an employee
DELETE FROM tbl_employee WHERE emp_name = 'Aman';

-- Check audit log
SELECT * FROM tbl_employee_audit;













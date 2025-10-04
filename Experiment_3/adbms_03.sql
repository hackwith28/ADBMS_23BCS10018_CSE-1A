--------------------EXPERIMENT 03: (MEDIUM LEVEL)--------------------------------------
CREATE TABLE deptt (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employee3 (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES deptt(id)
);


-- Insert into Department Table
INSERT INTO deptt VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employee3 VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2);

INSERT INTO employee3 VALUES
(4, 'ABC', 90000, 1);

SELECT e.id, e.name, d.dept_name, d.id, e.salary
FROM deptt as d
JOIN
employee3 as e
ON d.id=e.department_id
WHERE salary in 
(SELECT max(salary) from employee3
group by department_id
)

SELECT e.id, e.name, d.dept_name, d.id, e.salary
FROM deptt as d
JOIN
employee3 as e
ON d.id=e.department_id
WHERE salary in 
(SELECT max(e2.salary) 
from employee3 as e2
where e2.department_id=e.department_id
)

--------------------EXPERIMENT 03: (HARD LEVEL)--------------------------------------
CREATE TABLE A(
EmpID int primary key,
Ename varchar(50),
Salary int
);

CREATE TABLE B(
EmpID int primary key,
Ename varchar(50),
Salary int
);

INSERT INTO A VALUES
(1,'AA',1000),
(2,'BB',300);

INSERT INTO B VALUES
(2,'BB',400),
(3,'CC',100);


SELECT EmpID, Ename, min(Salary) as Min_Salary
FROM
(SELECT* FROM A
UNION
SELECT* FROM B) AS X
GROUP BY EmpID, Ename;
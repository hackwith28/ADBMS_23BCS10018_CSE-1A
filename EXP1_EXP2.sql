/*
 THE MIN NUMBER OF TABLES REQUIRS FOR JOINS AS WELL AS FK: 1
 COND: ATLEAST ONE COMMON COLUMN SHOULD BE THERE(NAME FO THE COL CAN BE DIFF/ VALUES SHOULD BE SAME ((ATLEAST 1))
 
 TYPES:
 1. INNER JOIN: COMMON DATA ONLY (ONLY THE MATCHING RECORDS)
 2. LEFT OUTER JOIN: LEFT TABLE WHOLE DATA + COMMON DATA
 3. RIGHT OUTER JOIN
 4. FULL OUTER JOIN : L + R + COMMON DATA
 5. SELF JOIN (TABLE)
 6. LEFT EXCLUSIVE JOIN
 7. RIGHT EXCLUSIVE JOIN
 */
--SYNTAX:
--USE SQUARE BRACKETS IF YOU WANT TO GIVE NAME TO THE COLUMN
CREATE TABLE Employee(
    Emp_ID INT identity(1, 1) PRIMARY KEY,
    Ename varchar(30) NOT NULL,
    Department varchar(20),
    ManagerID INT,
    foreign key (ManagerID) references Employee(Emp_ID)
);
insert into employee(Ename, Department, ManagerID)
values ('Alice', 'HR', null),
    ('Bob', 'Finance', 1),
    ('Charlie', 'IT', 1),
    ('David', 'Finance', 2),
    ('Eve', 'IT', 3),
    ('Frank', 'HR', 1)
select E1.EName as [Employee_Name],
    E2.EName as [Manager_Name],
    E1.Department as [Emp_Department],
    E2.Department as [Manager_Dept]
from Employee as E1
    left outer join Employee as E2 on E1.ManagerID = E2.Emp_ID;
--always put foreign key column on the left side always works 
--Hard Question
create table Year_tbl(ID INT not null, Year INT, NPV INT);
create table Queries_tbl(ID int NOT NULL, Year INT);
insert into Year_tbl(ID, Year, NPV)
values (1, 2018, 100),
    (7, 2020, 30),
    (13, 2019, 40),
    (1, 2019, 113),
    (2, 2008, 121),
    (3, 2009, 112),
    (11, 2020, 99),
    (7, 2019, 0)
insert into Queries_tbl(ID, Year)
values (1, 2019),
    (2, 2008),
    (3, 2009),
    (7, 2018),
    (7, 2019),
    (7, 2020),
    (13, 2019)
select Y.ID as [ID],
    Y.Year as [Year],
    isnull(Q.npv, 0)
from Queries_tbl as Y
    left outer join Year_tbl as Q on Y.ID = Q.ID
    and Y.Year = Q.Year;

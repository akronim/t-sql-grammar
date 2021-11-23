use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

IF OBJECT_ID('dbo.tblDepartment', 'U') IS NOT NULL 
  DROP TABLE dbo.tblDepartment;

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

Create table tblDepartment
(
    ID int primary key,
    DepartmentName nvarchar(50),
    City nvarchar(50)
)
Go

Insert into tblDepartment
values
    (1, 'IT', 'London'),
    (2, 'Payroll', 'Delhi'),
    (3, 'HR', 'New York'),
    (4, 'Other Department', 'Sydney')
Go

Create table tblEmployee
(
    ID int primary key,
    Name nvarchar(50),
    Gender nvarchar(50),
    Salary int,
    Age int,
    DepartmentId int foreign key references tblDepartment(Id)
)
Go

Insert into tblEmployee
values
    (1, 'Tom', 'Male', 4000, 25, 1),
    (2, 'Pam', 'Female', 3000, 25, 3),
    (3, 'John', 'Male', 5500, 30, 1),
    (4, 'Samantha', 'Female', 6500, 30, 2),
    (5, 'Todd', 'Male', 9800, 55, 2),
    (6, 'Betty', 'Female', 7000, 55, 1),
    (7, 'Sara', 'Female', 4800, 28, 3),
    (8, 'Victor', 'Male', 5500, 28, 1),
    (9, 'James', 'Male', 7500, 33, 2),
    (10, 'Christine', 'Female', 8800, 33, 1)
Go

-- HAVING clause is used to filter groups
-- HAVING comes after GROUP BY
-- HAVING clause work with aggregate functions like sum, min, max, avg, etc
-- HAVING is slower than WHERE and should be avoided when possible

-- agregatne funkcije mogu se koristiti u HAVING clause
select ID, Salary
from tblEmployee
GROUP BY ID, Salary
HAVING SUM(Salary) > 5000


select COUNT(e.ID) as TotalEmployees, d.DepartmentName
from tblEmployee as e
    join tblDepartment as d
    on e.DepartmentId = d.ID
GROUP by d.DepartmentName
HAVING COUNT(e.ID) > 2


-- combine WHERE and HAVING
Select Age, Count(*) as TotalEmployees, SUM(Salary) as TotalSalary
from tblEmployee
Where Gender = 'Male'
group by Age
Having Age > 25


-- combine WHERE and HAVING + join
select COUNT(e.ID) as TotalEmployees, d.DepartmentName
from tblEmployee as e
    join tblDepartment as d
    on e.DepartmentId = d.ID
WHERE e.Age > 25
GROUP by d.DepartmentName
HAVING COUNT(e.ID) > 2



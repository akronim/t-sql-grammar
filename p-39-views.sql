use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- A view is nothing more than a saved SQL query

-- CREATE VIEW vwViewName AS
-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE condition;

-- SELECT * FROM vwViewName;

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

CREATE TABLE tblEmployee
(
    Id int Primary Key,
    Name nvarchar(30),
    Salary int,
    Gender nvarchar(10),
    DepartmentId int
)

IF OBJECT_ID('dbo.tblDepartment', 'U') IS NOT NULL 
  DROP TABLE dbo.tblDepartment;

CREATE TABLE tblDepartment
(
    DeptId int Primary Key,
    DeptName nvarchar(20)
)

Insert into tblDepartment
values
    (1, 'IT'),
    (2, 'Payroll'),
    (3, 'HR'),
    (4, 'Admin')


Insert into tblEmployee
values
    (1, 'John', 5000, 'Male', 3),
    (2, 'Mike', 3400, 'Male', 2),
    (3, 'Pam', 6000, 'Female', 1),
    (4, 'Todd', 4800, 'Male', 4),
    (5, 'Sara', 3200, 'Female', 1),
    (6, 'Ben', 4800, 'Male', 3)
GO

Create View vWEmployeesByDepartment
as
    Select Id, Name, Salary, Gender, DeptName
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
GO

SELECT *
from vWEmployeesByDepartment
GO


-- View that returns only IT department employees:
Create View vWITDepartment_Employees
as
    Select Id, Name, Salary, Gender, DeptName
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
    where tblDepartment.DeptName = 'IT'
GO

SELECT *
from vWITDepartment_Employees
GO

-- View that returns all columns except Salary column:
Create View vWEmployeesNonConfidentialData
as
    Select Id, Name, Gender, DeptName
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
GO

SELECT *
from vWEmployeesNonConfidentialData
GO


-- View that returns summarized data, Total number of employees by Department
Create View vWEmployeesCountByDepartment
as
    Select DeptName, COUNT(Id) as TotalEmployees
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
    Group By DeptName
GO

SELECT *
from vWEmployeesCountByDepartment
GO

-- To look at view definition - sp_helptext vWName
-- To modify a view - ALTER VIEW statement 
-- To Drop a view - DROP VIEW vWName




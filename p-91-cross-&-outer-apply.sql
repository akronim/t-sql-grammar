use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


IF OBJECT_ID('dbo.Department', 'U') IS NOT NULL 
  DROP TABLE dbo.Department;


Create table Department
(
    Id int primary key,
    DepartmentName nvarchar(50)
)
Go

Insert into Department
values
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Payroll'),
    (4, 'Administration'),
    (5, 'Sales')
Go


IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL 
  DROP TABLE dbo.Employee;


Create table Employee
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10),
    Salary int,
    DepartmentId int foreign key references Department(Id)
)
Go

Insert into Employee
values
    (1, 'Mark', 'Male', 50000, 1),
    (2, 'Mary', 'Female', 60000, 3),
    (3, 'Steve', 'Male', 45000, 2),
    (4, 'John', 'Male', 56000, 1),
    (5, 'Sara', 'Female', 39000, 2)
GO

-- retrieve all the matching rows between Department and Employee tables
Select D.DepartmentName, E.Name, E.Gender, E.Salary
from Department D
    Inner Join Employee E
    On D.Id = E.DepartmentId
GO


-- retrieve all the matching rows between Department and Employee tables +
-- the non-matching rows from the LEFT table (Department)
Select D.DepartmentName, E.Name, E.Gender, E.Salary
from Department D
    Left Join Employee E
    On D.Id = E.DepartmentId
GO

-- Table Valued function
Create function fn_GetEmployeesByDepartmentId(@DepartmentId int)
Returns Table
as
Return
(
    Select Id, Name, Gender, Salary, DepartmentId
from Employee
where DepartmentId = @DepartmentId
)
Go

-- employees of the department with Id =1.
Select *
from fn_GetEmployeesByDepartmentId(1)
GO


-- error
-- you can not perform a join between a table and a function
Select D.DepartmentName, E.Name, E.Gender, E.Salary
from Department D
    Inner Join fn_GetEmployeesByDepartmentId(D.Id) E
    On D.Id = E.DepartmentId
GO


-- Cross Apply is semantically equivalent to Inner Join 
-- and Outer Apply is semantically equivalent to Left Outer Join


-- Cross Apply retrieves only the matching rows
Select D.DepartmentName, E.Name, E.Gender, E.Salary
from Department D
Cross Apply fn_GetEmployeesByDepartmentId(D.Id) E
GO


-- Outer Apply
Select D.DepartmentName, E.Name, E.Gender, E.Salary
from Department D
Outer Apply fn_GetEmployeesByDepartmentId(D.Id) E
GO
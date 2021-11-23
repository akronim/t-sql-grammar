use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO


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

Insert into tblEmployee
values
    (1, 'John', 5000, 'Male', 3),
    (2, 'Mike', 3400, 'Male', 2),
    (3, 'Pam', 6000, 'Female', 1),
    (4, 'Todd', 4800, 'Male', 4),
    (5, 'Sara', 3200, 'Female', 1),
    (6, 'Ben', 4800, 'Male', 3)
GO

Create view vWEmployeesDataExceptSalary
as
    Select Id, Name, Gender, DepartmentId
    from tblEmployee
GO

Select *
from vWEmployeesDataExceptSalary

-- update Name column from Mike to Mikey
Update vWEmployeesDataExceptSalary 
Set Name = 'Mikey' Where Id = 2

-- delete and insert rows from the base table
Delete from vWEmployeesDataExceptSalary where Id = 2
Insert into vWEmployeesDataExceptSalary
values
    (2, 'Mikey', 'Male', 2)


-- what happens if our view is based on multiple base tables
-- it may not update the underlying base tables correctly (use INSTEAD OF triggers)
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
GO

-- View that joins tblEmployee and tblDepartment
Create view vwEmployeeDetailsByDepartment
as
    Select Id, Name, Salary, Gender, DeptName
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
GO

Select *
from vwEmployeeDetailsByDepartment
GO

-- update John's department, from HR to IT
Update vwEmployeeDetailsByDepartment 
set DeptName='IT' where Name = 'John'














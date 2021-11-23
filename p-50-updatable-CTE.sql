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
    Gender nvarchar(10),
    DepartmentId int
)

Insert into tblEmployee
values
    (1, 'John', 'Male', 3),
    (2, 'Mike', 'Male', 2),
    (3, 'Pam', 'Female', 1),
    (4, 'Todd', 'Male', 4),
    (5, 'Sara', 'Female', 1),
    (6, 'Ben', 'Male', 3)
GO

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


-- Is it possible to UPDATE a CTE?
-- Yes & No, depending on the number of base tables, the CTE is created upon, 
-- and the number of base tables affected by the UPDATE statement


With
    Employees_Name_Gender
    as
    (
        Select Id, Name, Gender
        from tblEmployee
    )
Select *
from Employees_Name_Gender
GO


-- working - CTE is created on one base table
-- Let's now, UPDATE JOHN's gender from Male to Female
With
    Employees_Name_Gender
    as
    (
        Select Id, Name, Gender
        from tblEmployee
    )
Update Employees_Name_Gender Set Gender = 'Female' where Id = 1



-- CTE, that returns Employees by Department
With
    EmployeesByDepartment
    as
    (
        Select Id, Name, Gender, DeptName
        from tblEmployee
            join tblDepartment
            on tblDepartment.DeptId = tblEmployee.DepartmentId
    )
Select *
from EmployeesByDepartment
GO

-- working - CTE is based on 2 tables and UPDATE affects only one base table
-- Let's update this CTE
With
    EmployeesByDepartment
    as
    (
        Select Id, Name, Gender, DeptName
        from tblEmployee
            join tblDepartment
            on tblDepartment.DeptId = tblEmployee.DepartmentId
    )
Update EmployeesByDepartment set Gender = 'Male' where Id = 1
GO


-- not allowed - CTE is based on multiple tables, and UPDATE statement affects more than 1 base table
With
    EmployeesByDepartment
    as
    (
        Select Id, Name, Gender, DeptName
        from tblEmployee
            join tblDepartment
            on tblDepartment.DeptId = tblEmployee.DepartmentId
    )
Update EmployeesByDepartment set 
Gender = 'Female', DeptName = 'IT'
where Id = 1
GO


-- update may not work as you expect
-- if a CTE is based on multiple tables, and if the UPDATE statement affects only 
-- one base table
With
    EmployeesByDepartment
    as
    (
        Select Id, Name, Gender, DeptName
        from tblEmployee
            join tblDepartment
            on tblDepartment.DeptId = tblEmployee.DepartmentId
    )
Update EmployeesByDepartment set 
DeptName = 'IT' where Id = 1
-- Select *
-- from EmployeesByDepartment
GO
























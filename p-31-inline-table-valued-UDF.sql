use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- Inline Table Valued function returns a table
IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL DROP TABLE dbo.tblEmployee;
Create table tblEmployee
(
    ID int primary key,
    [Name] nvarchar(50),
    [DOB] datetime,
    Gender NVARCHAR(10),
    DepartmentId int
) 
Go

Insert into tblEmployee
values
    (1, 'Tom', '1980-12-30 00:00:00.000', 'Male', 1) ,
    (2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 1) ,
    (3, 'John', '1985-08-22 12:03:30.370', 'Male', 1) ,
    (4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3) ,
    (5, 'Mark', '1979-11-29 12:59:30.670', 'Male', 1)  
Go

-- Create a function that returns EMPLOYEES by GENDER
-- The function body is not enclosed between BEGIN and END block
CREATE FUNCTION fnEmployeesByGender(@Gender nvarchar(10)) 
RETURNS TABLE
AS
  RETURN (SELECT Id, [Name], DOB, Gender, DepartmentId
FROM tblEmployee
WHERE Gender = @Gender)
GO

Select *
from fnEmployeesByGender('Male')


-- 1. Inline Table Valued functions can be used to achieve 
-- the functionality of parameterized views.
-- 2. The table returned by the table valued function can also be used 
-- in joins with other tables.

IF OBJECT_ID('dbo.tblDepartment', 'U') IS NOT NULL DROP TABLE dbo.tblDepartment;
Create table tblDepartment
(
    ID int primary key,
    [DepartmentName] nvarchar(50),
    [Location] NVARCHAR(50),
    DepartmentHead NVARCHAR(50)
) 
Go

Insert into tblDepartment
values
    (1, 'IT', 'London', 'Rick') ,
    (2, 'Payroll', 'Delhi', 'Ron') ,
    (3, 'HR', 'New York', 'Christie') ,
    (4, 'Other', 'Sydney', 'Cindrella') 
Go

-- Joining the Employees returned by the function, with the Departments table
Select Name, Gender, DepartmentName
from fnEmployeesByGender('Male') E
    Join tblDepartment D on D.Id = E.DepartmentId









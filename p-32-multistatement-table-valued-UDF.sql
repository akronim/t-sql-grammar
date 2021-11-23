use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

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

-- Inline Table Valued function(ILTVF):
Create Function fn_ILTVF_GetEmployees()
Returns Table
as
Return (Select Id, Name, Cast(DOB as Date)
as _DOB
From tblEmployee)
GO


-- Multi-statement Table Valued function(MSTVF):
Create Function fn_MSTVF_GetEmployees()
Returns @Table Table (Id int,
    Name nvarchar(20),
    _DOB Date)
as
Begin
    Insert into @Table
    Select Id, Name, Cast(DOB as Date)
    From tblEmployee
    Return
End
GO

--Calling the Inline Table Valued Function:
Select *
from fn_ILTVF_GetEmployees()

--Calling the Multi-statement Table Valued Function:
Select *
from fn_MSTVF_GetEmployees()


-- MSTVF: we can specify the structure of the table that gets returned
-- MSTVF: can have BEGIN and END block
-- ILTVF are better for performance, than MSTVF
-- ILTVF: It's possible to update the underlying table (MSTVF: No)

Update fn_ILTVF_GetEmployees() set Name='Sam1' Where Id = 1

Select *
from fn_ILTVF_GetEmployees()
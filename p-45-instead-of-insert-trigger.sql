use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- INSTEAD OF triggers are usually used to correctly update views 
-- that are based on multiple tables

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


Create view vWEmployeeDetails
as
    Select Id, Name, Gender, DeptName
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
GO


Select *
from vWEmployeeDetails

-- Error
Insert into vWEmployeeDetails
values(7, 'Valarie', 'Female', 'IT')
GO

-- Solution
-- INSTEAD OF INSERT trigger:
Create trigger tr_vWEmployeeDetails_InsteadOfInsert
on vWEmployeeDetails
Instead Of Insert
as
Begin
    Declare @DeptId int

    --Check if there is a valid DepartmentId
    --for the given DepartmentName
    Select @DeptId = DeptId
    from tblDepartment
        join inserted
        on inserted.DeptName = tblDepartment.DeptName

    --If DepartmentId is null throw an error
    --and stop processing
    if(@DeptId is null)
Begin
        Raiserror('Invalid Department Name. Statement terminated', 16, 1)
        return
    End
    --Finally insert into tblEmployee table
    Insert into tblEmployee
        (Id, Name, Gender, DepartmentId)
    Select Id, Name, Gender, @DeptId
    from inserted
End
GO

-- execute the insert query
Insert into vWEmployeeDetails
values(7, 'Valarie', 'Female', 'IT')

Select *
from vWEmployeeDetails


-- The instead of trigger correctly inserts the record into tblEmployee table. 
-- Since we are inserting a row, the inserted table contains the newly added row, 
-- whereas the deleted table will be empty.




use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- An INSTEAD OF DELETE trigger gets fired instead of the DELETE event, on a table or a view

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
GO

-- error
Delete from vWEmployeeDetails where Id = 1
GO


-- INSTEAD OF DELETE trigger:
Create Trigger tr_vWEmployeeDetails_InsteadOfDelete
on vWEmployeeDetails
instead of delete
as
Begin
    Delete tblEmployee 
from tblEmployee
        join deleted
        on tblEmployee.Id = deleted.Id

--Subquery
--Delete from tblEmployee 
--where Id in (Select Id from deleted)
End
GO

Delete from vWEmployeeDetails where Id = 1 
GO

Select *
from vWEmployeeDetails
GO

-- DELETED table contains all the rows that we tried to DELETE from the view. 
-- So, we are joining the DELETED table with tblEmployee to delete the rows.












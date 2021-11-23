use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- An INSTEAD OF UPDATE triggers gets fired instead of an update event, on a table or a view.

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

-- Error
Update vWEmployeeDetails 
set Name = 'Johny', DeptName = 'IT'
where Id = 1
GO

-- no error, but didn't work as expected
Update vWEmployeeDetails 
set DeptName = 'IT'
where Id = 1
GO


Select *
from vWEmployeeDetails
GO


-- solution
-- correcting things
Update tblDepartment set DeptName = 'HR' where DeptId = 3
GO


-- INSTEAD OF UPDATE trigger:
Create Trigger tr_vWEmployeeDetails_InsteadOfUpdate
on vWEmployeeDetails
instead of update
as
Begin
    -- if EmployeeId is updated
    if(Update(Id))
Begin
        Raiserror('Id cannot be changed', 16, 1)
        Return
    End

    -- If DeptName is updated
    if(Update(DeptName)) 
Begin
        Declare @DeptId int

        Select @DeptId = DeptId
        from tblDepartment
            join inserted
            on inserted.DeptName = tblDepartment.DeptName

        if(@DeptId is NULL )
Begin
            Raiserror('Invalid Department Name', 16, 1)
            Return
        End

        Update tblEmployee set DepartmentId = @DeptId
from inserted
            join tblEmployee
            on tblEmployee.Id = inserted.id
    End

    -- If gender is updated
    if(Update(Gender))
Begin
        Update tblEmployee set Gender = inserted.Gender
from inserted
            join tblEmployee
            on tblEmployee.Id = inserted.id
    End

    -- If Name is updated
    if(Update(Name))
Begin
        Update tblEmployee set Name = inserted.Name
from inserted
            join tblEmployee
            on tblEmployee.Id = inserted.id
    End
End
GO


Update vWEmployeeDetails 
set DeptName = 'IT'
where Id = 1
GO


Select *
from vWEmployeeDetails
GO


Update vWEmployeeDetails 
set Name = 'Johny', Gender = 'Female', DeptName = 'IT' 
where Id = 1












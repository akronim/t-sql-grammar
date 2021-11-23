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
    Gender nvarchar(50),
    DepartmentId int
) 
Go

Insert into tblEmployee
values
    (1, 'Tom', 'Male', 1) ,
    (2, 'Pam', 'Female', 1) ,
    (3, 'John', 'Male', 3) ,
    (4, 'Sam', 'Male', 2) ,
    (5, 'Todd', 'Male', 3) ,
    (6, 'Ben', 'Male', 2) ,
    (7, 'Sara', 'Female', 1) ,
    (8, 'Valarie', 'Female', 2) ,
    (9, 'James', 'Male', 1) ,
    (10, 'Russell', 'Male', 2) 
Go

Create Procedure spGetEmployeeCountByGender
    @Gender nvarchar(20),
    @EmployeeCount int Output
as
Begin
    Select @EmployeeCount = COUNT(Id)
    from tblEmployee
    where Gender = @Gender
End
GO

Declare @EmployeeTotal int
Execute spGetEmployeeCountByGender 'Female', @EmployeeTotal output
-- Execute spGetEmployeeCountByGender @EmployeeCount = @EmployeeTotal OUT, @Gender = 'Male'
if(@EmployeeTotal is null)
    Print '@EmployeeTotal is null'
else
    Print '@EmployeeTotal is not null'
Print @EmployeeTotal



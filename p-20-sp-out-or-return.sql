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

-- out
Create Procedure spGetTotalCountOfEmployees1
    @TotalCount int output
as
Begin
    Select @TotalCount = COUNT(ID)
    from tblEmployee
End
GO

Declare @TotalEmployees int
Execute spGetTotalCountOfEmployees1 @TotalEmployees Output
Select @TotalEmployees
GO

-- return
Create Procedure spGetTotalCountOfEmployees2
as
Begin
    return (
    Select COUNT(ID)
    from tblEmployee
    )
End
GO

Declare @TotalEmployees int
Execute @TotalEmployees = spGetTotalCountOfEmployees2
Select @TotalEmployees
GO


-- OUT
Create Procedure spGetNameById1
    @Id int,
    @Name nvarchar(20) Output
as
Begin
    Select @Name = [Name]
    from tblEmployee
    Where Id = @Id
End
GO

Declare @EmployeeName nvarchar(20)
Execute spGetNameById1 3, @EmployeeName out
Print 'Name of the Employee = ' + @EmployeeName
GO


-- return
-- not possible: 
-- using return values, we can only return integers, and that too, only one integer
Create Procedure spGetNameById2
    @Id int
as
Begin
    Return (Select Name
    from tblEmployee
    Where Id = @Id)
End
GO

Declare @EmployeeName nvarchar(20)
Execute @EmployeeName = spGetNameById2 1
Print 'Name of the Employee = ' + @EmployeeName
GO
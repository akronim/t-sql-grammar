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

Create Procedure spNameOfProc
as
Begin
    Begin Try
        Begin Transaction
    -- CODE
        Commit Transaction
    End Try
    Begin Catch
        Rollback Transaction
    End Catch
End
GO

-- simple stored procedure without any parameters 
Create Procedure spGetEmployees
AS
Begin
    SELECT [Name],
        Gender
    FROM tblEmployee
END
-- To execute the stored procedure 
-- 1. spGetEmployees
-- 2. EXEC spGetEmployees 
-- 3. Execute spGetEmployees 

EXEC spGetEmployees
GO

-- stored procedure with input parameters
Create Procedure spGetEmployeesByGenderAndDepartment
    @Gender nvarchar(50),
    @DepartmentId int
as
Begin
    Select Name, Gender
    from tblEmployee
    Where Gender = @Gender and DepartmentId = @DepartmentId
End

EXECUTE spGetEmployeesByGenderAndDepartment 'Male', 1
-- OR
EXECUTE spGetEmployeesByGenderAndDepartment @DepartmentId=1, @Gender ='Male'
GO

-- To view the text of the stored procedure
sp_helptext
'spGetEmployeesByGenderAndDepartment'
GO

-- View the information about the stored procedure
sp_help 'spGetEmployeesByGenderAndDepartment'
GO

-- View the dependencies of the stored procedure
sp_depends 'spGetEmployeesByGenderAndDepartment'
GO

-- To change the stored procedure, use ALTER PROCEDURE statement:
Alter Procedure spGetEmployeesByGenderAndDepartment
    @Gender nvarchar(50),
    @DepartmentId int
as
Begin
    Select [Name], Gender
    from tblEmployee
    Where Gender = @Gender and DepartmentId = @DepartmentId
    order by [Name]
End
GO

-- To encrypt the text of the SP
Alter Procedure spGetEmployeesByGenderAndDepartment
    @Gender nvarchar(50),
    @DepartmentId int
WITH
    ENCRYPTION
as
Begin
    Select Name, Gender
    from tblEmployee
    Where Gender = @Gender and DepartmentId = @DepartmentId
End
GO

-- To delete the SP 
DROP PROC dbo.spGetEmployeesByGenderAndDepartment
GO
--or 
DROP PROCEDURE dbo.spGetEmployeesByGenderAndDepartment
GO


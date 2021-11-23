use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- Deterministic and Nondeterministic Functions

-- Deterministic
-- Sum(), AVG(), Square(), Power() and Count()

-- Nondeterministic
-- GetDate() and CURRENT_TIMESTAMP


IF OBJECT_ID('dbo.tblEmployees', 'U') IS NOT NULL DROP TABLE dbo.tblEmployees;
CREATE TABLE [dbo].[tblEmployees]
(
    [Id] [int] Primary Key,
    [Name] [nvarchar](50) NULL,
    [DateOfBirth] [datetime] NULL,
    [Gender] [nvarchar](10) NULL,
    [DepartmentId] [int] NULL
)

Insert into tblEmployees
values(1, 'Sam', '1980-12-30 00:00:00.000', 'Male', 1)
Insert into tblEmployees
values(2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2)
Insert into tblEmployees
values(3, 'John', '1985-08-22 12:03:30.370', 'Male', 1)
Insert into tblEmployees
values(4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3)
Insert into tblEmployees
values(5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1)
GO

-- you can encrypt a function text
-- Scalar Function without encryption option:
Create Function fn_GetEmployeeNameById(@Id int)
Returns nvarchar(20)
as
Begin
    Return (Select Name
    from tblEmployees
    Where Id = @Id)
End
GO

-- To view text of the function:
sp_helptext fn_GetEmployeeNameById
GO

-- alter the function to use WITH ENCRYPTION OPTION
Alter Function fn_GetEmployeeNameById(@Id int)
Returns nvarchar(20)
With Encryption
as
Begin
    Return (Select Name
    from tblEmployees
    Where Id = @Id)
End
GO


-- WITH SCHEMABINDING option
Drop Table tblEmployees
GO

-- error
SELECT dbo.fn_GetEmployeeNameById(1)

IF OBJECT_ID('dbo.tblEmployees', 'U') IS NOT NULL DROP TABLE dbo.tblEmployees;
CREATE TABLE [dbo].[tblEmployees]
(
    [Id] [int] Primary Key,
    [Name] [nvarchar](50) NULL,
    [DateOfBirth] [datetime] NULL,
    [Gender] [nvarchar](10) NULL,
    [DepartmentId] [int] NULL
)

Insert into tblEmployees
values(1, 'Sam', '1980-12-30 00:00:00.000', 'Male', 1)
Insert into tblEmployees
values(2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2)
Insert into tblEmployees
values(3, 'John', '1985-08-22 12:03:30.370', 'Male', 1)
Insert into tblEmployees
values(4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3)
Insert into tblEmployees
values(5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1)
GO


Alter Function fn_GetEmployeeNameById(@Id int)
Returns nvarchar(20)
With SchemaBinding
as
Begin
    Return (Select Name
    from dbo.tblEmployees
    Where Id = @Id)
End
GO

-- try to drop the table
-- Cannot DROP TABLE 'tblEmployees' because it is being referenced by object 'fn_GetEmployeeNameById'. 
Drop Table tblEmployees










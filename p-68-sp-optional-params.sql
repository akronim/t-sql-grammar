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
    Id int IDENTITY PRIMARY KEY,
    Name nvarchar(50),
    Email nvarchar(50),
    Age int,
    Gender nvarchar(50),
    HireDate date,
)
GO

Insert into tblEmployee
values
    ('Sara Nan', 'Sara.Nan@test.com', 35, 'Female', '1999-04-04')
,
    ('James Histo', 'James.Histo@test.com', 33, 'Male', '2008-07-13')
,
    ('Mary Jane', 'Mary.Jane@test.com', 28, 'Female', '2005-11-11')
,
    ('Paul Sensit', 'Paul.Sensit@test.com', 29, 'Male', '2007-10-23')
GO


-- Name, Email, Age and Gender parameters of spSearchEmployees stored procedure are optional. 
-- We have set defaults for all the parameters, and in the "WHERE" clause 
-- we are checking if the respective parameter IS NULL
Create Proc spSearchEmployees
    @Name nvarchar(50) = NULL,
    @Email nvarchar(50) = NULL,
    @Age int = NULL,
    @Gender nvarchar(50) = NULL
as
Begin
    Select *
    from tblEmployee
    where
([Name] = @Name OR @Name IS NULL) AND
        (Email = @Email OR @Email IS NULL) AND
        (Age = @Age OR @Age IS NULL) AND
        (Gender = @Gender OR @Gender IS NULL)
End
GO

-- Testing
-- This command will return all the rows
Execute spSearchEmployees

-- Retruns only Male employees
Execute spSearchEmployees @Gender = 'Male'

-- Retruns Male employees whose age is 29
Execute spSearchEmployees @Gender = 'Male', @Age = 29 

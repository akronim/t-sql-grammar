use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- 1. You cannot pass parameters to a view

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;


CREATE TABLE tblEmployee
(
    Id int Primary Key,
    Name nvarchar(30),
    Salary int,
    Gender nvarchar(10),
    DepartmentId int
)

Insert into tblEmployee
values
    (1, 'John', 5000, 'Male', 3),
    (2, 'Mike', 3400, 'Male', 2),
    (3, 'Pam', 6000, 'Female', 1),
    (4, 'Todd', 4800, 'Male', 4),
    (5, 'Sara', 3200, 'Female', 1),
    (6, 'Ben', 4800, 'Male', 3)
GO

-- Error : Cannot pass Parameters to Views
-- Create View vWEmployeeDetails
-- @Gender nvarchar(20)
-- as
-- Select Id, Name, Gender, DepartmentId
-- from  tblEmployee
-- where Gender = @Gender

-- Table Valued functions can be used as a replacement for parameterized views.
Create function fnEmployeeDetails(@Gender nvarchar(20))
Returns Table
as
Return 
(Select Id, Name, Gender, DepartmentId
from tblEmployee
where Gender = @Gender)
GO

-- Calling the function
Select *
from dbo.fnEmployeeDetails('Male')
GO

-- 2. Rules and Defaults cannot be associated with views.


-- 3. The ORDER BY clause is invalid in views unless TOP or FOR XML is also specified.
Create View vWEmployeeDetailsSorted
as
    Select Id, Name, Gender, DepartmentId
    from tblEmployee
    order by Id
GO


-- 4. Views cannot be based on temporary tables.
Create Table ##TestTempTable
(
    Id int,
    Name nvarchar(20),
    Gender nvarchar(10)
)

Insert into ##TestTempTable
values
    (101, 'Martin', 'Male'),
    (102, 'Joe', 'Female'),
    (103, 'Pam', 'Female'),
    (104, 'James', 'Male')
GO

-- Error: Cannot create a view on Temp Tables
Create View vwOnTempTable
as
    Select Id, Name, Gender
    from ##TestTempTable 






















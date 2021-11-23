use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO



-- Table Valued Parameter allows a table (i.e multiple rows of data) to be passed 
-- as a parameter to a stored procedure from T-SQL code or from an application.


Create Table Employees
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

-- Step 1 : Create User-defined Table Type 
CREATE TYPE EmpTableType AS TABLE
(
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10)
)
Go

-- Step 2 : Use the User-defined Table Type as a parameter in the stored procedure. 
-- Table valued parameters must be passed as read-only to stored procedures, functions etc. 
-- This means you cannot perform DML operations like INSERT, UPDATE or DELETE 
-- on a table-valued parameter in the body of a function, stored procedure etc.

CREATE PROCEDURE spInsertEmployees
    @EmpTableType EmpTableType READONLY
AS
BEGIN
    INSERT INTO Employees
    SELECT *
    FROM @EmpTableType
END
GO


-- Step 3 : Declare a table variable, insert the data and then pass the table variable 
-- as a parameter to the stored procedure.
DECLARE @EmployeeTableType EmpTableType

INSERT INTO @EmployeeTableType
VALUES
    (1, 'Mark', 'Male'),
    (2, 'Mary', 'Female'),
    (3, 'John', 'Male'),
    (4, 'Sara', 'Female'),
    (5, 'Rob', 'Male')

EXECUTE spInsertEmployees @EmployeeTableType


SELECT *
FROM Employees
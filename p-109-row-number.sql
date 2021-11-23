use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- Returns the sequential number of a row starting at 1
-- ORDER BY clause is required
-- PARTITION BY clause is optional
-- When the data is partitioned, row number is reset to 1 when the partition changes
-- Syntax : ROW_NUMBER() OVER (ORDER BY Col1, Col2)


Create Table Employees
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10),
    Salary int
)
Go

Insert Into Employees
Values
    (1, 'Mark', 'Male', 5000),
    (2, 'John', 'Male', 4500),
    (3, 'Pam', 'Female', 5500),
    (4, 'Sara', 'Female', 4000),
    (5, 'Todd', 'Male', 3500),
    (6, 'Mary', 'Female', 5000),
    (7, 'Ben', 'Male', 6500),
    (8, 'Jodi', 'Female', 7000),
    (9, 'Tom', 'Male', 5500),
    (10, 'Ron', 'Male', 5000)
Go

-- Row_Number function without PARTITION BY
SELECT Name, Gender, Salary,
    ROW_NUMBER() OVER (ORDER BY Gender) AS RowNumber
FROM Employees

-- Row_Number function with PARTITION BY
SELECT Name, Gender, Salary,
    ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY Gender) AS RowNumber
FROM Employees


-- Deleting all duplicate rows except one from a sql server table
Create table tblEmployees
(
    ID int,
    FirstName nvarchar(50),
    LastName nvarchar(50),
    Gender nvarchar(50),
    Salary int
)
GO

Insert into tblEmployees
values
    (1, 'Mark', 'Hastings', 'Male', 60000),
    (1, 'Mark', 'Hastings', 'Male', 60000),
    (1, 'Mark', 'Hastings', 'Male', 60000),
    (2, 'Mary', 'Lambeth', 'Female', 30000),
    (2, 'Mary', 'Lambeth', 'Female', 30000),
    (3, 'Ben', 'Hoskins', 'Male', 70000),
    (3, 'Ben', 'Hoskins', 'Male', 70000),
    (3, 'Ben', 'Hoskins', 'Male', 70000)

WITH
    EmployeesCTE
    AS
    (
        SELECT *, ROW_NUMBER()OVER(PARTITION BY ID ORDER BY ID) AS RowNumber
        FROM tblEmployees
    )
DELETE FROM EmployeesCTE WHERE RowNumber > 1

SELECT *
from tblEmployees
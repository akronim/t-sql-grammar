use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- SQL Server 2012
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


-- SQL Query to compute running total without partitions
SELECT Name, Gender, Salary,
    SUM(Salary) OVER (ORDER BY ID) AS RunningTotal
FROM Employees


-- SQL Query to compute running total with partitions
-- It is better to use a column that has unique data in the ORDER BY clause
SELECT Name, Gender, Salary,
    SUM(Salary) OVER (PARTITION BY Gender ORDER BY ID) AS RunningTotal
FROM Employees

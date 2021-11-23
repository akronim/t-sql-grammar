use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO



Create table Departments
(
    DepartmentId int primary key,
    DepartmentName nvarchar(50)
)
Go

Insert into Departments
values
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Payroll')
Go

Create table Employees
(
    Id int primary key,
    Name nvarchar(100),
    Gender nvarchar(10),
    Salary int,
    DeptId int foreign key references Departments(DepartmentId)
)
Go

Insert into Employees
values
    (1, 'Mark', 'Male', 50000, 1),
    (2, 'Sara', 'Female', 65000, 2),
    (3, 'Mike', 'Male', 48000, 3),
    (4, 'Pam', 'Female', 70000, 1),
    (5, 'John', 'Male', 55000, 2)
Go

-- The SELECT INTO statement in SQL Server, selects data from one table 
-- and inserts it into a NEW table.

-- tablice nastale s SELECT INTO nemaju indekse, PKs, default vrijednosti i sl.

-- 1. Copy all rows and columns from an existing table into a new table. 
-- This is extremely useful when you want to make a backup copy of the existing table.
SELECT *
INTO EmployeesBackup
FROM Employees

-- 2. Copy all rows and columns from an existing table into a new table 
-- in an external database.
SELECT *
INTO HRDB.dbo.EmployeesBackup
FROM Employees

-- 3. Copy only selected columns into a new table
SELECT Id, Name, Gender
INTO EmployeesBackup
FROM Employees

-- 4. Copy only selected rows into a new table
SELECT *
INTO EmployeesBackup
FROM Employees
WHERE DeptId = 1

-- 5. Copy columns from 2 or more table into a new table
SELECT *
INTO EmployeesBackup
FROM Employees
    INNER JOIN Departments
    ON Employees.DeptId = Departments.DepartmentId

-- 6. Create a new table whose columns and datatypes match with an existing table. 
SELECT *
INTO EmployeesBackup
FROM Employees
WHERE 1 <> 1

-- 7. Copy all rows and columns from an existing table into a new table 
-- on a different SQL Server instance. 
-- For this, create a linked server and use the 4 part naming convention
SELECT *
INTO TargetTable
FROM [SourceServer].[SourceDB].[dbo].[SourceTable]


-- You cannot use SELECT INTO statement to select data into an existing table. 
-- For this you will have to use INSERT INTO statement.
INSERT INTO ExistingTable
    (ColumnList)
SELECT ColumnList
FROM SourceTable
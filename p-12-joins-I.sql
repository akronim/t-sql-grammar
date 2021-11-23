use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

IF OBJECT_ID('dbo.tblDepartment', 'U') IS NOT NULL 
  DROP TABLE dbo.tblDepartment;

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

Create table tblDepartment
(
    ID int primary key,
    DepartmentName nvarchar(50),
    City nvarchar(50),
    DepartmentHead nvarchar(50)
)
Go

Insert into tblDepartment
values
    (1, 'IT', 'London', 'Rick'),
    (2, 'Payroll', 'Delhi', 'Ron'),
    (3, 'HR', 'New York', 'Christie'),
    (4, 'Other Department', 'Sydney', 'Cindrella')
Go

Create table tblEmployee
(
    ID int primary key,
    Name nvarchar(50),
    Gender nvarchar(50),
    Salary int,
    DepartmentId int foreign key references tblDepartment(Id)
)
Go

Insert into tblEmployee
values
    (1, 'Tom', 'Male', 4000, 1),
    (2, 'Pam', 'Female', 3000, 3),
    (3, 'John', 'Male', 3500, 1),
    (4, 'Sam', 'Male', 4500, 2),
    (5, 'Todd', 'Male', 2800, 2),
    (6, 'Ben', 'Male', 7000, 1),
    (7, 'Sara', 'Female', 4800, 3),
    (8, 'Valarie', 'Female', 5500, 1),
    (9, 'James', 'Male', 6500, NULL),
    (10, 'Russell', 'Male', 8800, NULL)
Go

-- 1. CROSS JOIN
-- 2. INNER JOIN or JOIN
-- 3. OUTER JOIN : 3.1 LEFT, 3.2 RIGHT, 3.3 FULL


-- CROSS JOIN:
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
CROSS JOIN tblDepartment


-- JOIN or INNER JOIN
-- returns only the matching rows between both the tables
-- prvo se uzme tablica iz FROM dijela te se izaberu svi njeni reci
-- zatim se u tablici iz JOIN dijela traži odgovarajući redak za svaki redak iz prve tablice
-- tako spojeni reci ulaze u privremenu tablicu u SELECT dijelu
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
    INNER JOIN tblDepartment
    ON tblEmployee.DepartmentId = tblDepartment.Id
--OR
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
    JOIN tblDepartment
    ON tblEmployee.DepartmentId = tblDepartment.Id


-- LEFT JOIN or LEFT OUTER JOIN    
-- returns all the matching rows + non matching rows from the left table
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
    LEFT JOIN tblDepartment
    ON tblEmployee.DepartmentId = tblDepartment.Id

-- RIGHT JOIN or RIGHT OUTER JOIN
-- returns all the matching rows + non matching rows from the right table
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
    RIGHT JOIN tblDepartment
    ON tblEmployee.DepartmentId = tblDepartment.Id

-- FULL JOIN or FULL OUTER JOIN
-- returns all rows from both the left and right tables, including the non matching rows
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
    FULL JOIN tblDepartment
    ON tblEmployee.DepartmentId = tblDepartment.Id
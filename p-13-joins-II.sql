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
    Location nvarchar(50),
    DepartmentHead nvarchar(50)
)
Go

Insert into tblDepartment
values
    (1, 'IT', 'London', 'Rick')
Insert into tblDepartment
values
    (2, 'Payroll', 'Delhi', 'Ron')
Insert into tblDepartment
values
    (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment
values
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
    (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee
values
    (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee
values
    (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee
values
    (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee
values
    (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee
values
    (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee
values
    (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee
values
    (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee
values
    (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee
values
    (10, 'Russell', 'Male', 8800, NULL)
Go

-- retrieve only the non matching rows from the left table
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee E
    LEFT JOIN tblDepartment D
    ON E.DepartmentId = D.Id
WHERE D.Id IS NULL

-- retrieve only the non matching rows from the right table
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee E
    RIGHT JOIN tblDepartment D
    ON E.DepartmentId = D.Id
WHERE E.DepartmentId IS NULL

-- retrieve only the non matching rows from both the left and right table
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee E
    FULL JOIN tblDepartment D
    ON E.DepartmentId = D.Id
WHERE E.DepartmentId IS NULL
    OR D.Id IS NULL


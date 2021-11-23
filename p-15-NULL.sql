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

create table tblEmployee
(
    EmployeeId int primary key,
    [Name] nvarchar (50) null,
    Salary int null,
    ManagerId int null
);

insert into tblEmployee
values
    (1, 'Mirko', 1250, 7),
    (2, 'Slavko', 1550, 4),
    (3, 'Ana', 2250, 4),
    (4, 'Josip', 1750, 6),
    (5, 'Slavica', 1210, 4),
    (6, 'Marina', 2350, null),
    (7, 'Filip', 1900, 6),
    (8, 'Luka', 2800, 7),
    (9, 'Ivana', 1420, 4),
    (10, 'Vedran', 1600, 4)


SELECT *
FROM tblEmployee
where ManagerId IS NULL
GO

SELECT *
FROM tblEmployee
where ManagerId IS NOT NULL
GO


-- ISNULL()
SELECT E.Name as Employee, ISNULL(M.Name,'No Manager') as Manager
FROM tblEmployee E
    LEFT JOIN tblEmployee M
    ON E.ManagerID = M.EmployeeID

-- CASE
SELECT E.Name as Employee,
    CASE WHEN M.Name IS NULL THEN 'No Manager' 
	ELSE M.Name END as Manager
FROM tblEmployee E
    LEFT JOIN tblEmployee M
    ON E.ManagerID = M.EmployeeID

-- COALESCE()
SELECT E.Name as Employee, COALESCE(M.Name, 'No Manager') as Manager
FROM tblEmployee E
    LEFT JOIN tblEmployee M
    ON E.ManagerID = M.EmployeeID
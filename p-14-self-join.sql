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
    (1, 'Jacob', 1250, 7),
    (2, 'Frankie', 1550, 4),
    (3, 'Aron', 2250, 4),
    (4, 'Lily', 1750, 6),
    (5, 'Sharon', 1210, 4),
    (6, 'Peyton', 2350, null),
    (7, 'Julian', 1900, 6),
    (8, 'Tessa', 2800, 7),
    (9, 'Lukas', 1420, 4),
    (10, 'Reese', 1600, 4)

Select E.Name as Employee, M.Name as Manager
from tblEmployee E
    Left Join tblEmployee M
    On E.ManagerId = M.EmployeeId


select m.Name as Manager, SUM(e.Salary)
from tblEmployee e
    left join tblEmployee m
    on e.ManagerId = m.EmployeeId
group by m.Name
order by m.Name


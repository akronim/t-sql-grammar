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
    Id int primary key,
    FirstName nvarchar (50) null,
    MiddleName nvarchar (50) null,
    LastName nvarchar (50) null
);

insert into tblEmployee
values
    (1, 'Sam', null, null),
    (2, null, 'Todd', 'Tanzan'),
    (3, null, null, 'Sara'),
    (4, 'Ben', 'Parker', null),
    (5, 'James', 'Nick', 'Nancy')

-- COALESCE() returns the first Non NULL value
SELECT Id, COALESCE(FirstName, MiddleName, LastName) AS Name
FROM tblEmployee
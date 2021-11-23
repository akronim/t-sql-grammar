use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


IF OBJECT_ID('dbo.tblPerson', 'U') IS NOT NULL 
  DROP TABLE dbo.tblPerson;

CREATE TABLE tblPerson
(
    ID INT NOT NULL PRIMARY KEY,
    [Name] nvarchar(50),
    Age int,
    Email nvarchar(50),
    City nvarchar(50),
    [Date] DATETIME
)

INSERT INTO tblPerson
    (ID, [Name], Age, Email, City, [Date])
VALUES
    (1, 'Mark', 20, 'mark@mark.com', 'London', '1980-12-30 00:00:00.000'),
    (2, 'Sam', 29, 'sam@sam.com', 'Zagreb', '1982-12-30 00:00:00.000'),
    (3, 'Mark', 23, 'mark@mark.com', 'London', '1984-12-30 00:00:00.000'),
    (4, 'John', 25, 'j@j.com', 'Mumbai', '1986-12-30 00:00:00.000'),
    (5, 'Adam', 26, 'adam@adam.com', 'Berlin', '1988-12-30 00:00:00.000'),
    (6, 'Bob', 21, 'bob@bob.com', 'Oslo', '1990-12-30 00:00:00.000'),
    (7, 'Christine', 27, 'c@c.com', 'Zagreb', '1992-12-30 00:00:00.000')
GO

select *
from tblPerson
where Age BETWEEN 20 and 25

select *
from tblPerson
where [Date] BETWEEN '1980-12-30' and '1986-12-30' 
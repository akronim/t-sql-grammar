use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

--prije kreiranja tablice obriši drugu ako postoji pod istim imenom
IF OBJECT_ID('dbo.tblPerson', 'U') IS NOT NULL 
  DROP TABLE dbo.tblPerson;

CREATE TABLE tblPerson
(
    ID INT NOT NULL PRIMARY KEY,
    [Name] nvarchar(50),
    Age int,
    Email nvarchar(50),
    City nvarchar(50)
)

INSERT INTO tblPerson
    (ID, [Name], Age, Email, City)
VALUES
    (1, 'Mark', 20, 'mark@mark.com', 'London'),
    (2, 'Sam', 29, 'sam@sam.com', 'Zagreb'),
    (3, 'Mark', 23, 'mark@mark.com', 'London'),
    (4, 'John', 25, 'j@j.com', 'Mumbai'),
    (5, 'Adam', 26, 'adam@adam.com', 'Berlin'),
    (6, 'Bob', 21, 'bob@bob.com', 'Oslo'),
    (7, 'Christine', 27, 'c@c.com', 'Zagreb')
GO

select *
from tblPerson
GO

select ALL [Name]
from tblPerson
GO

select distinct [Name], City
from tblPerson




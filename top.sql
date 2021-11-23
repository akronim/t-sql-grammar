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

select top 10
    *
from tblPerson

select top 10
    [Name], Age
from tblPerson

select top 50 percent
    *
from tblPerson

select TOP 1
    *
from tblPerson
order by Age desc


-- WITH TIES
--Create temporary table
CREATE TABLE #MyTable
(
    Purchase_Date DATETIME,
    Amount INT
)
--Insert few rows to hold
INSERT INTO #MyTable
    SELECT '11/11/2011', 100
UNION ALL
    SELECT '11/12/2011', 110
UNION ALL
    SELECT '11/13/2011', 120
UNION ALL
    SELECT '11/14/2011', 130
UNION ALL
    SELECT '11/11/2011', 150

--Get all records which has minimum purchase date (i.e. 11/11/2011)
SELECT *
FROM #MyTable
WHERE Purchase_Date IN
(SELECT MIN(Purchase_Date)
FROM #MyTable)

-- We can also get our desired results by using TOP…WITH TIES
SELECT TOP(1) WITH TIES
    *
FROM #MyTable
ORDER BY Purchase_Date
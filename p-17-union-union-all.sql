use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


IF OBJECT_ID('dbo.tblIndiaCustomers', 'U') IS NOT NULL
DROP TABLE dbo.tblIndiaCustomers
GO

CREATE TABLE dbo.tblIndiaCustomers
(
    Id int PRIMARY KEY,
    [Name] NVARCHAR(50),
    Email NVARCHAR(50)
);
GO

INSERT INTO dbo.tblIndiaCustomers
    (Id, [Name], Email)
VALUES
    (1, 'Raj', 'R@R.com'),
    (2, 'Sam', 'S@S.com')

IF OBJECT_ID('dbo.tblUKCustomers', 'U') IS NOT NULL
DROP TABLE dbo.tblUKCustomers
GO

CREATE TABLE dbo.tblUKCustomers
(
    Id int PRIMARY KEY,
    [Name] NVARCHAR(50),
    Email NVARCHAR(50)
);
GO

INSERT INTO dbo.tblUKCustomers
    (Id, [Name], Email)
VALUES
    (1, 'Ben', 'B@B.com'),
    (2, 'Sam', 'S@S.com')

-- For UNION and UNION ALL to work, 
-- the Number, Data types, and the order of the columns 
-- in the select statements should be same.

-- UNION ALL
    Select Id, Name, Email
    from tblIndiaCustomers
UNION ALL
    Select Id, Name, Email
    from tblUKCustomers

-- UNION
-- removes duplicate rows
    Select Id, Name, Email
    from tblIndiaCustomers
UNION
    Select Id, Name, Email
    from tblUKCustomers


-- If you want to sort, the results of UNION or UNION ALL, 
-- the ORDER BY clause should be used on the last SELECT statement 
    Select Id, Name, Email
    from tblIndiaCustomers
UNION ALL
    Select Id, Name, Email
    from tblUKCustomers
Order by Name


-- with WHERE
    Select Id, Name, Email
    from tblIndiaCustomers
    WHERE Id = 1
UNION
    Select Id, Name, Email
    from tblUKCustomers
    WHERE Id = 2

-- union vs join
-- UNION combines ROWS from 2 or more tables, 
-- whereas JOINS combine COLUMNS from 2 or more table
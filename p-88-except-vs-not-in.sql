use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO



Create Table TableA
(
    Id int,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableA
values
    (1, 'Mark', 'Male'),
    (2, 'Mary', 'Female'),
    (3, 'Steve', 'Male')
Go

Create Table TableB
(
    Id int,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableB
values
    (2, 'Mary', 'Female'),
    (3, 'Steve', 'Male')
GO




    Select Id, Name, Gender
    From TableA
Except
    Select Id, Name, Gender
    From TableB

-- The same result can also be achieved using NOT IN operator.
Select Id, Name, Gender
From TableA
Where Id NOT IN (Select Id
from TableB)


-- Except filters duplicates and returns only DISTINCT rows from the left query 
-- that aren’t in the right query’s results, whereas NOT IN does not filter the duplicates.
Insert into TableA
values
    (1, 'Mark', 'Male')


    Select Id, Name, Gender
    From TableA
Except
    Select Id, Name, Gender
    From TableB



Select Id, Name, Gender
From TableA
Where Id NOT IN (Select Id
from TableB)


-- EXCEPT operator expects the same number of columns in both the queries, 
-- whereas NOT IN compares a single column from the outer query with a single column 
-- from the subquery

-- error
    Select Id, Name, Gender
    From TableA
Except
    Select Id, Name
    From TableB

-- error
Select Id, Name, Gender
From TableA
Where Id NOT IN (Select Id, Name
from TableB)
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
    (3, 'Steve', 'Male'),
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
    (3, 'Steve', 'Male'),
    (4, 'John', 'Male')
Go



-- UNION operator returns all the unique rows from both the queries. 
-- Notice the duplicates are removed. 
    Select Id, Name, Gender
    from TableA
UNION
    Select Id, Name, Gender
    from TableB


-- UNION ALL operator returns all the rows from both the queries, including the duplicates. 
    Select Id, Name, Gender
    from TableA
UNION ALL
    Select Id, Name, Gender
    from TableB


-- INTERSECT operator retrieves the common unique rows from both the left and the right query. 
-- Notice the duplicates are removed. 
    Select Id, Name, Gender
    from TableA
INTERSECT
    Select Id, Name, Gender
    from TableB


-- EXCEPT operator returns unique rows from the left query that aren’t in the right query’s 
-- results. 
    Select Id, Name, Gender
    from TableA
EXCEPT
    Select Id, Name, Gender
    from TableB


-- For all these 3 operators to work the following 2 conditions must be met
    -- • The number and the order of the columns must be same in both the queries 
    -- • The data types must be same or at least compatible
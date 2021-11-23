use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- retrieves the common records from both the left and the right query
-- • Introduced in SQL Server 2005 
-- • The number and the order of the columns must be same in both the queries 
-- • The data types must be same or at least compatible 

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
Go


    Select Id, Name, Gender
    from TableA
Intersect
    Select Id, Name, Gender
    from TableB


-- same thing using INNER join
Select TableA.Id, TableA.Name, TableA.Gender
From TableA Inner Join TableB
    On TableA.Id = TableB.Id


-- INTERSECT filters duplicates and returns only DISTINCT rows that are common between 
-- the LEFT and Right Query, whereas INNER JOIN does not filter the duplicates
Insert into TableA
values
    (2, 'Mary', 'Female')


    Select Id, Name, Gender
    from TableA
Intersect
    Select Id, Name, Gender
    from TableB


Select TableA.Id, TableA.Name, TableA.Gender
From TableA Inner Join TableB
    On TableA.Id = TableB.Id


-- You can make the INNER JOIN behave like INTERSECT operator by using the DISTINCT operator 
Select DISTINCT TableA.Id, TableA.Name, TableA.Gender
From TableA Inner Join TableB
    On TableA.Id = TableB.Id


-- INNER JOIN treats two NULLS as two different values. 
-- So if you are joining two tables based on a nullable column and if both tables have NULLs 
-- in that joining column, then INNER JOIN will not include those rows in the result-set, 
-- whereas INTERSECT treats two NULLs as a same value and it returns all matching rows.

Insert into TableA
values(NULL, 'Pam', 'Female')
Insert into TableB
values(NULL, 'Pam', 'Female')


    Select Id, Name, Gender
    from TableA
Intersect
    Select Id, Name, Gender
    from TableB


Select TableA.Id, TableA.Name, TableA.Gender
From TableA Inner Join TableB
    On TableA.Id = TableB.Id






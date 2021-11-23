use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- EXCEPT operator returns unique rows from the left query that aren’t 
-- in the right query’s results.
--     • Introduced in SQL Server 2005 
--     • The number and the order of the columns must be the same in all queries 
--     • The data types must be same or compatible 
--     • This is similar to minus operator in oracle


Create Table TableA
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableA
values
    (1, 'Mark', 'Male'),
    (2, 'Mary', 'Female'),
    (3, 'Steve', 'Male'),
    (4, 'John', 'Male'),
    (5, 'Sara', 'Female')
Go

Create Table TableB
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableB
values
    (4, 'John', 'Male'),
    (5, 'Sara', 'Female'),
    (6, 'Pam', 'Female'),
    (7, 'Rebeka', 'Female'),
    (8, 'Jordan', 'Male')
GO

-- unique rows from the left query that aren’t in the right query’s results
    Select Id, Name, Gender
    From TableA
Except
    Select Id, Name, Gender
    From TableB


-- rows from Table B that does not exist in Table A
    Select Id, Name, Gender
    From TableB
Except
    Select Id, Name, Gender
    From TableA


-- You can also use Except operator on a single table
Create table tblEmployees
(
    Id int identity primary key,
    Name nvarchar(100),
    Gender nvarchar(10),
    Salary int
)
Go

Insert into tblEmployees
values
    ('Mark', 'Male', 52000),
    ('Mary', 'Female', 55000),
    ('Steve', 'Male', 45000),
    ('John', 'Male', 40000),
    ('Sara', 'Female', 48000),
    ('Pam', 'Female', 60000),
    ('Tom', 'Male', 58000),
    ('George', 'Male', 65000),
    ('Tina', 'Female', 67000),
    ('Ben', 'Male', 80000)
Go

    select Id, Name, Gender, Salary
    from tblEmployees
    where Salary >=50000
except
    select Id, Name, Gender, Salary
    from tblEmployees
    where Salary >=60000


-- Order By clause should be used only once after the right query
    Select Id, Name, Gender, Salary
    From tblEmployees
    Where Salary >= 50000
Except
    Select Id, Name, Gender, Salary
    From tblEmployees
    Where Salary >= 60000
order By Name


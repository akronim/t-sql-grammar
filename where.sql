use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- used to filter records/rows
-- WHERE clause can be used with - Select, Insert, Update, Delete statements
-- WHERE clause filters ROWS BEFORE aggregate calculations are performed
-- Aggregate functions (sum, min, max, avg, ...) cannot be used in the WHERE clause
-- WHERE comes before GROUP BY and is applied before the GROUP BY clause

IF OBJECT_ID('dbo.tblPerson', 'U') IS NOT NULL 
  DROP TABLE dbo.tblPerson;

CREATE TABLE tblPerson
(
    ID INT NOT NULL PRIMARY KEY,
    [Name] nvarchar(50),
    Age int,
    Email nvarchar(50),
    City nvarchar(50),
    [Date] DATETIME,
    Salary int,
    Gender nvarchar(50),
)

INSERT INTO tblPerson
    (ID, [Name], Age, Email, City, [Date], Salary, Gender)
VALUES
    (1, 'Mark', 20, 'mark@mark.com', 'London', '1980-12-30 00:00:00.000', 4000, 'Male'),
    (2, 'Samantha', 29, 'samantha@samantha.com', 'Zagreb', '1982-12-30 00:00:00.000', 3000, 'Female'),
    (3, 'Mary', 23, 'mary@mary.com', 'London', '1984-12-30 00:00:00.000', 3500, 'Female'),
    (4, 'John', 25, 'j@j.com', 'Mumbai', '1986-12-30 00:00:00.000', 4500, 'Male'),
    (5, 'Adam', 26, 'adam@adam.com', 'Berlin', '1988-12-30 00:00:00.000', 2800, 'Male'),
    (6, 'Bob', 21, 'bob@bob.com', 'Oslo', '1990-12-30 00:00:00.000', 7000, 'Male'),
    (7, 'Christine', 27, 'c@c.com', 'Zagreb', '1992-12-30 00:00:00.000', 4800, 'Female')
GO

select *
from tblPerson
where City='London'

select *
from tblPerson
where City <>'London'

select *
from tblPerson
where City != 'London'

select *
from tblPerson
where NOT City = 'London'

select *
from tblPerson
where Age = 20 or Age = 23 or Age=29

select *
from tblPerson
where (City = 'London' or City = 'Mumbai') and Age > 20;
GO

-- WHERE clause filters rows before aggregate calculations (SUM(Salary)) are performed
Select City, SUM(Salary) as TotalSalary
from tblPerson
Where City = 'London'
group by City

--Filtering groups using HAVING clause, after all aggrgations take place
Select City, SUM(Salary) as TotalSalary
from tblPerson
group by City
Having City = 'London'

--combine WHERE and HAVING
Select City, SUM(Salary) as TotalSalary
from tblPerson
Where Gender = 'Male'
group by City
Having City = 'London'

-- error
-- agregatne funkcije ne mogu se koristiti u WHERE clause
select *
from tblPerson
where SUM(Salary) > 5000


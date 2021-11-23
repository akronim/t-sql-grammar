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

Create table tblEmployee
(
  ID int primary key,
  [Name] nvarchar(50),
  Gender nvarchar(50),
  Salary int,
  City NVARCHAR(50)
)
Go

Insert into tblEmployee
values
  (1, 'Tom', 'Male', 4000, 'London'),
  (2, 'Pam', 'Female', 3000, 'New York'),
  (3, 'John', 'Male', 3500, 'London'),
  (4, 'Sam', 'Male', 4500, 'London'),
  (5, 'Todd', 'Male', 2800, 'Sydney'),
  (6, 'Ben', 'Male', 7000, 'New York'),
  (7, 'Sara', 'Female', 4800, 'Sydney'),
  (8, 'Valarie', 'Female', 5500, 'New York'),
  (9, 'James', 'Male', 6500, 'London'),
  (10, 'Russell', 'Male', 8800, 'London'),
  (11, NULL, NULL, NULL, NULL)
Go

-- SQL aggregate functions return a single value, calculated from values in a column
-- often used with GROUP BY clause (can be used without the "GROUP BY" clause)
-- dozvoljene samo u SELECT i HAVING
-- AVG, COUNT, MIN, MAX, SUM


SELECT AVG(CAST(Salary as float)) avg_salary
FROM tblEmployee;

Select SUM(Salary) as TotalSalary
from tblEmployee

Select SUM(Salary) as TotalSalary
from tblEmployee
WHERE Gender = 'Male'

-- total salaries by city
Select City, SUM(Salary) as TotalSalary
from tblEmployee
Group by City

-- total salaries by city and by gender (first by city and then by gender)
Select City, Gender, SUM(Salary) as TotalSalary
from tblEmployee
group by City, Gender

-- total salaries and total number of employees by City, and by gender
Select City, Gender, SUM(Salary) as TotalSalary, COUNT(ID) as TotalEmployees
from tblEmployee
group by City, Gender

-- Filtering rows using WHERE clause, before aggregations take place
Select City, SUM(Salary) as TotalSalary
from tblEmployee
Where City = 'London'
group by City

--Filtering groups using HAVING clause, after all aggrgations take place
Select City, SUM(Salary) as TotalSalary
from tblEmployee
group by City
Having City = 'London'

--combine WHERE and HAVING
Select City, SUM(Salary) as TotalSalary
from tblEmployee
Where Gender = 'Male'
group by City
Having City = 'London'

-- agregatne funkcije ne mogu se koristiti u WHERE clause
select *
from tblEmployee
where SUM(Salary) > 5000

-- agregatne funkcije mogu se koristiti u HAVING clause
select ID, Salary
from tblEmployee
GROUP BY ID, Salary
HAVING SUM(Salary) > 5000




-- Difference between WHERE and HAVING clause:
-- 1. WHERE clause can be used with - Select, Insert, and Update statements, 
-- whereas HAVING clause can only be used with the Select statement.
-- 2. WHERE filters ROWS BEFORE aggregation (GROUPING), whereas HAVING filters groups 
-- AFTER the aggregations are performed.
-- 3. Aggregate functions cannot be used in the WHERE clause, 
-- unless it is in a sub query contained in a HAVING clause, whereas aggregate functions 
-- can be used in HAVING clause.


-- WHERE clause doesn’t work with aggregate functions like sum, min, max, avg, etc
-- (WHERE clause cannot be used with aggregates whereas HAVING can)
-- error
-- SELECT Product, SUM(SaleAmount) AS TotalSales
-- FROM Sales
-- GROUP BY Product
-- WHERE SUM
-- (SaleAmount) > 1000
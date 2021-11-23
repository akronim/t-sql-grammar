use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

Create table Sales
(
    Product nvarchar(50),
    SaleAmount int
)
Go

Insert into Sales
values
    ('iPhone', 500),
    ('Laptop', 800),
    ('iPhone', 1000),
    ('Speakers', 400),
    ('Laptop', 600)
Go

SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Product
GO


SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Product
HAVING SUM(SaleAmount) > 1000
GO

-- error
-- WHERE clause doesn’t work with aggregate functions like sum, min, max, avg, etc
-- SELECT Product, SUM(SaleAmount) AS TotalSales
-- FROM Sales
-- GROUP BY Product
-- WHERE SUM(SaleAmount) > 1000


-- WHERE clause filters rows before aggregate calculations are performed 
-- whereas HAVING clause filters groups after aggregate calculations are performed.

-- Calculate Total sales of iPhone and Speakers using WHERE clause
-- WHERE clause retrieves only iPhone and Speaker products and then performs the sum
SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE Product in ('iPhone', 'Speakers')
GROUP BY Product


-- Calculate Total sales of iPhone and Speakers using HAVING clause
-- This example retrieves all rows from Sales table, performs the sum 
-- and then removes all products except iPhone and Speakers.
SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Product
HAVING Product in ('iPhone', 'Speakers')
GO

-- HAVING is slower than WHERE and should be avoided when possible


-- WHERE comes before GROUP BY and HAVING comes after GROUP BY


-- Difference between WHERE and Having
-- 1. WHERE clause cannot be used with aggregates whereas HAVING can. 
-- This means WHERE clause is used for filtering individual rows 
-- whereas HAVING clause is used to filter groups.

-- 2. WHERE comes before GROUP BY. This means WHERE clause filters rows before 
-- aggregate calculations are performed. HAVING comes after GROUP BY. This means HAVING clause
-- filters rows after aggregate calculations are performed. So from a performance standpoint, 
-- HAVING is slower than WHERE and should be avoided when possible.

-- 3. WHERE and HAVING can be used together in a SELECT query. In this case WHERE clause 
-- is applied first to filter individual rows. The rows are then grouped and 
-- aggregate calculations are performed, and then the HAVING clause filters the groups.
select Product, SUM(SaleAmount) as TotalSales
from Sales
WHERE Product IN ('iPhone','Speakers')
group by Product
HAVING SUM(SaleAmount) > 1000
GO
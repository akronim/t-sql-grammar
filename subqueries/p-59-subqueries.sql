use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

IF OBJECT_ID('dbo.tblProducts', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProducts;

Create Table tblProducts
(
    [Id] int primary key,
    [Name] nvarchar(50),
    [Description] nvarchar(250)
)

Insert into tblProducts
values
    (1, 'TV', '52 inch black color LCD TV'),
    (2, 'Laptop', 'Very thin black color acer laptop'),
    (3, 'Desktop', 'HP high performance desktop')
GO

IF OBJECT_ID('dbo.tblProductSales', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProductSales;

Create Table tblProductSales
(
    Id int primary key,
    ProductId int foreign key references tblProducts(Id),
    UnitPrice int,
    QuantitySold int
)

Insert into tblProductSales
values
    (1, 3, 450, 5),
    (2, 2, 250, 7),
    (3, 3, 450, 4),
    (4, 3, 450, 9)
GO

select *
from tblProducts
select *
from tblProductSales


SELECT *
from tblProducts P
WHERE P.Id = 
(SELECT PS.ProductId
FROM tblProductSales PS
WHERE PS.QuantitySold = 9)

SELECT *
from tblProducts P
WHERE P.Id IN 
(SELECT PS.ProductId
FROM tblProductSales PS
WHERE PS.QuantitySold = 7 OR PS.QuantitySold = 9)


SELECT *
FROM tblProductSales PS
WHERE PS.QuantitySold > 
(SELECT AVG(PS.QuantitySold)
FROM tblProductSales PS)

-- query to retrieve products that are not sold at all - using join
Select tblProducts.[Id], [Name], [Description]
from tblProducts
    left join tblProductSales
    on tblProducts.Id = tblProductSales.ProductId
where tblProductSales.ProductId IS NULL
GO

-- using a subquery in WHERE clause
Select [Id], [Name], [Description]
from tblProducts
where Id not in (Select Distinct ProductId
from tblProductSales)
GO

-- using a subquery in the SELECT clause
Select [Name],
    (Select SUM(QuantitySold)
    from tblProductSales
    where tblProductSales.ProductId = tblProducts.Id) as TotalQuantity
from tblProducts
order by Name
GO

-- using join that produces the same result.
Select [Name], SUM(QuantitySold) as TotalQuantity
from tblProducts
    left join tblProductSales
    on tblProducts.Id = tblProductSales.ProductId
group by [Name]
order by Name
GO

-- subquery is simply a select statement, that returns a single value and 
-- can be nested inside a SELECT, UPDATE, INSERT, or DELETE statement

-- It is also possible to nest a subquery inside another subquery

-- Subqueries are always encolsed in paranthesis
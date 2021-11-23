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
    (3, 'Desktop', 'HP high performance desktop'),
    (4, 'ABCD', 'asdf asdf asdf')
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
    (3, 1, 450, 4),
    (4, 3, 450, 9),
    (5, 1, 350, 4)
GO

-- The operator must be a standard comparison operator: =, <>, !=, >, >=, <, or <=

-- The ANY operator returns true if any subquery values meet the condition
-- if 1 = any(1, 2, 3)
-- je li Id jednak nekom ProductId-u iz subquery-ja
SELECT
    *
FROM tblProducts
WHERE Id = ANY 
(SELECT ProductId
FROM tblProductSales
WHERE QuantitySold >= 6)

-- ALL compares a single value against a set of data from a query
-- The ALL operator returns true if all subquery values meet the condition
-- je li Id jednak svim ProductId-vima iz subquery-ja
SELECT
    *
FROM tblProducts
WHERE Id = ALL 
(SELECT ProductId
FROM tblProductSales
-- WHERE QuantitySold >= 6)
WHERE QuantitySold = 4)

-- find the products that were sold with more than two units in a sales order
use BikeStores;
GO

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id = ANY (
        SELECT
    product_id
FROM
    sales.order_items
WHERE
            quantity >= 2
    )
ORDER BY
    product_name;
GO


-- get a list average list prices of products for each brand
use BikeStores;
GO

-- find the products whose list prices are bigger than the average list price 
-- of products of all brands
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > ALL (
        SELECT
    AVG (list_price)
FROM
    production.products
GROUP BY
            brand_id
    )
ORDER BY
    list_price;















use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- When you create an index on a view, the view gets materialized. 
-- This means, the view is now, capable of storing data. 
-- In SQL server, we call them Indexed views and in Oracle, Materialized views.


IF OBJECT_ID('dbo.tblProduct', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProduct;


Create Table tblProduct
(
    ProductId int primary key,
    Name nvarchar(20),
    UnitPrice int
)


Insert into tblProduct
Values
    (1, 'Books', 20),
    (2, 'Pens', 14),
    (3, 'Pencils', 11),
    (4, 'Clips', 10)


IF OBJECT_ID('dbo.tblProductSales', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProductSales;

Create Table tblProductSales
(
    ProductId int,
    QuantitySold int
)

Insert into tblProductSales
values
    (1, 10),
    (3, 23),
    (4, 21),
    (2, 12),
    (1, 13),
    (3, 12),
    (4, 13),
    (1, 11),
    (2, 12),
    (1, 14)
GO

-- RULES
-- 1. The view should be created with SchemaBinding option
-- 2. If an Aggregate function in the SELECT LIST references an expression, 
--      and if there is a possibility for that expression to become NULL, 
--      then, a replacement value should be specified. 
--      In this example, we are using, ISNULL() function, to replace NULL values with ZERO.
-- 3. If GROUP BY is specified, the view select list must contain a COUNT_BIG(*) expression
-- 4. The base tables in the view, should be referenced with 2 part name. 
--      In this example, tblProduct and tblProductSales are referenced using dbo.tblProduct 
--      and dbo.tblProductSales respectively.

-- Create a view which returns Total Sales and Total Transactions by Product
Create view vWTotalSalesByProduct
with
    SchemaBinding
as
    Select [Name],
        SUM(ISNULL((QuantitySold * UnitPrice), 0)) as TotalSales,
        COUNT_BIG(*) as TotalTransactions
    from dbo.tblProductSales
        join dbo.tblProduct
        on dbo.tblProduct.ProductId = dbo.tblProductSales.ProductId
    group by [Name]
GO


Select *
from vWTotalSalesByProduct
GO

-- create an Index on the view
Create Unique Clustered Index UIX_vWTotalSalesByProduct_Name
on vWTotalSalesByProduct([Name])

-- Indexed views are ideal for scenarios, where the underlying data is not frequently changed
-- The cost of maintaining an indexed view is much higher 
-- than the cost of maintaining a table index







































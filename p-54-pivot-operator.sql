use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- Pivot is a sql server operator that can be used to turn unique values from one column, 
-- into multiple columns in the output, there by effectively rotating a table.

IF OBJECT_ID('dbo.tblProductSales', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProductSales;

Create Table tblProductSales
(
    SalesAgent nvarchar(50),
    SalesCountry nvarchar(50),
    SalesAmount int
)
GO

Insert into tblProductSales
values
    ('Tom', 'UK', 200),
    ('John', 'US', 180),
    ('John', 'UK', 260),
    ('David', 'India', 450),
    ('Tom', 'India', 350),
    ('David', 'US', 200),
    ('Tom', 'US', 130),
    ('John', 'India', 540),
    ('John', 'UK', 120),
    ('David', 'UK', 220),
    ('John', 'UK', 420),
    ('David', 'US', 320),
    ('Tom', 'US', 340),
    ('Tom', 'UK', 660),
    ('John', 'India', 430),
    ('David', 'India', 230),
    ('David', 'India', 280),
    ('Tom', 'UK', 480),
    ('John', 'US', 360),
    ('David', 'UK', 140)
GO


Select *
from tblProductSales
GO

Select SalesCountry, SalesAgent, SUM(SalesAmount) as Total
from tblProductSales
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent
GO



-- Query using PIVOT operator:
Select SalesAgent, India, US, UK
from tblProductSales
-- This PIVOT query is converting the unique column values (India, US, UK) 
-- in SALESCOUNTRY column into Columns in the output, 
-- along with performing aggregations on the SALESAMOUNT column
Pivot
(
   Sum(SalesAmount) for SalesCountry in ([India],[US],[UK])
) as PivotTable
GO



-- example 2
Create Table tblProductsSale
(
    Id int primary key,
    SalesAgent nvarchar(50),
    SalesCountry nvarchar(50),
    SalesAmount int
)
GO

Insert into tblProductsSale
values
    (1, 'Tom', 'UK', 200),
    (2, 'John', 'US', 180),
    (3, 'John', 'UK', 260),
    (4, 'David', 'India', 450),
    (5, 'Tom', 'India', 350),
    (6, 'David', 'US', 200),
    (7, 'Tom', 'US', 130),
    (8, 'John', 'India', 540),
    (9, 'John', 'UK', 120),
    (10, 'David', 'UK', 220),
    (11, 'John', 'UK', 420),
    (12, 'David', 'US', 320),
    (13, 'Tom', 'US', 340),
    (14, 'Tom', 'UK', 660),
    (15, 'John', 'India', 430),
    (16, 'David', 'India', 230),
    (17, 'David', 'India', 280),
    (18, 'Tom', 'UK', 480),
    (19, 'John', 'US', 360),
    (20, 'David', 'UK', 140)
GO


Select SalesAgent, India, US, UK
from
    (
   Select SalesAgent, SalesCountry, SalesAmount
    from tblProductsSale
) as SourceTable
Pivot
(
 Sum(SalesAmount) for SalesCountry in (India, US, UK)
) as PivotTable
GO

-- UNPIVOT performs the opposite operation to PIVOT by rotating columns 
-- of a table-valued expression into column values.


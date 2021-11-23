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
    [Id] int identity primary key,
    [Name] nvarchar(50),
    [Description] nvarchar(250)
)

IF OBJECT_ID('dbo.tblProductSales', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProductSales;

Create Table tblProductSales
(
    Id int primary key identity,
    ProductId int foreign key references tblProducts(Id),
    UnitPrice int,
    QuantitySold int
)



Insert into tblProducts
values
    ('TV', '52 inch black color LCD TV'),
    ('Laptop', 'Very thin black color acer laptop'),
    ('Desktop', 'HP high performance desktop')
GO

Insert into tblProductSales
values(3, 450, 5),
    (2, 250, 7),
    (3, 450, 4),
    (3, 450, 9)
GO

-- non-corelated subquery: can be executed independently of the outer query
Select [Id], [Name], [Description]
from tblProducts
where Id not in (Select Distinct ProductId
from tblProductSales)
GO

-- correlated subquery: depends on the outer query for its values
Select [Name],
    (Select SUM(QuantitySold)
    from tblProductSales
    where ProductId = p.Id) as TotalQuantity
from tblProducts p
order by Name
GO

-- Correlated subqueries get executed, once for every row that is selected by the outer query. 
-- Corelated subquery, cannot be executed independently of the outer query.














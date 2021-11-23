use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- A successful transaction must pass the "ACID" test, that is, it must be
-- A - Atomic
-- C - Consistent
-- I - Isolated
-- D - Durable

IF OBJECT_ID('dbo.tblProduct', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProduct;

Create Table tblProduct
(
    ProductId int NOT NULL primary key,
    Name nvarchar(50),
    UnitPrice int,
    QtyAvailable int
)
GO

Insert into tblProduct
values
    (1, 'Laptops', 2340, 100),
    (2, 'Desktops', 3467, 50)
GO


IF OBJECT_ID('dbo.tblProductSales', 'U') IS NOT NULL 
  DROP TABLE dbo.tblProductSales;

Create Table tblProductSales
(
    ProductSalesId int primary key,
    ProductId int,
    QuantitySold int
)
GO


Create Procedure spUpdateInventory_and_Sell
as
Begin
    Begin Try
    Begin Transaction
      Update tblProduct set QtyAvailable = (QtyAvailable - 10)
      where ProductId = 1

      Insert into tblProductSales
    values(3, 1, 10)
    Commit Transaction
  End Try
  Begin Catch 
    Rollback Transaction
  End Catch
End
GO




Exec spUpdateInventory_and_Sell
GO














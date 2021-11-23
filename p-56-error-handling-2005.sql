use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- Syntax:
-- BEGIN TRY
--      { Any set of SQL statements }
-- END TRY
-- BEGIN CATCH
--      [ Optional: Any set of SQL statements ]
-- END CATCH
-- [Optional: Any other SQL Statements]

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


CREATE Procedure spSellProduct
    @ProductId int,
    @QuantityToSell int
as
Begin
    -- Check the stock available, for the product we want to sell
    Declare @StockAvailable int
    Select @StockAvailable = QtyAvailable
    from tblProduct
    where ProductId = @ProductId

    if(@StockAvailable IS null)
  Begin
        Raiserror('(@StockAvailable IS NULL',16,1)
    End

    -- Throw an error to the calling application, if enough stock is not available
    if(@StockAvailable < @QuantityToSell)
  Begin
        Raiserror('Not enough stock available',16,1)
    End
-- If enough stock available
Else
  Begin
        Begin Try
    Begin Transaction

DECLARE @ProductIdExsits int
SET @ProductIdExsits = -1

SELECT @ProductIdExsits = ProductId
        FROM tblProduct
        WHERE ProductId=@ProductId
IF(@ProductIdExsits = -1)
    Raiserror('ProductId does not exist',16,1)

        -- First reduce the quantity available
Update tblProduct set QtyAvailable = (QtyAvailable - @QuantityToSell)
where ProductId = @ProductId

Declare @MaxProductSalesId int
-- Calculate MAX ProductSalesId 
Select @MaxProductSalesId = Case When 
MAX(ProductSalesId) IS NULL 
Then 0 else MAX(ProductSalesId) end
        from tblProductSales
--Increment @MaxProductSalesId by 1, so we don't get a primary key violation
Set @MaxProductSalesId = @MaxProductSalesId + 1
Insert into tblProductSales
        values(@MaxProductSalesId, @ProductId, @QuantityToSell)
    Commit Transaction
   End Try
   Begin Catch 
Rollback Transaction
Select
            ERROR_NUMBER() as ErrorNumber,
            ERROR_MESSAGE() as ErrorMessage,
            ERROR_PROCEDURE() as ErrorProcedure,
            ERROR_STATE() as ErrorState,
            ERROR_SEVERITY() as ErrorSeverity,
            ERROR_LINE() as ErrorLine
   End Catch
    End
End
GO

Exec spSellProduct 2, 1
GO

SELECT *
from dbo.tblProduct
SELECT *
from dbo.tblProductSales
GO













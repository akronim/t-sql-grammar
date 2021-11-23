use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- If Table exists drop the tables
If (Exists (select *
from information_schema.tables
where table_name = 'tblProductSales'))
Begin
    Drop Table tblProductSales
End

If (Exists (select *
from information_schema.tables
where table_name = 'tblProducts'))
Begin
    Drop Table tblProducts
End



-- Recreate tables
Create Table tblProducts
(
    [Id] int identity primary key,
    [Name] nvarchar(50),
    [Description] nvarchar(250)
)

Create Table tblProductSales
(
    Id int primary key identity,
    ProductId int foreign key references tblProducts(Id),
    UnitPrice int,
    QuantitySold int
)

--Insert Sample data into tblProducts table
Declare @Id int
Set @Id = 1

While(@Id <= 12000)
Begin
    Insert into tblProducts
    values('Product - ' + CAST(@Id as nvarchar(20)),
            'Product - ' + CAST(@Id as nvarchar(20)) + ' Description')

    Print @Id
    Set @Id = @Id + 1
End

-- Declare variables to hold a random ProductId, 
-- UnitPrice and QuantitySold
declare @RandomProductId int
declare @RandomUnitPrice int
declare @RandomQuantitySold int

-- Declare and set variables to generate a 
-- random ProductId between 1 and 12000
declare @UpperLimitForProductId int
declare @LowerLimitForProductId int

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 12000

-- Declare and set variables to generate a 
-- random UnitPrice between 1 and 100
declare @UpperLimitForUnitPrice int
declare @LowerLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 100

-- Declare and set variables to generate a 
-- random QuantitySold between 1 and 10
declare @UpperLimitForQuantitySold int
declare @LowerLimitForQuantitySold int

set @LowerLimitForQuantitySold = 1
set @UpperLimitForQuantitySold = 10

--Insert Sample data into tblProductSales table
Declare @Counter int
Set @Counter = 1

While(@Counter <= 20000)
Begin

    -- We use the Rand() function which returns the values between 0 and 1 and multiplied it by the result of upper limits – lower limits. 
    -- This returns the values between the specified limits. However these values are in decimal. 
    -- To convert it into integer we use the Round function. We specify the second attribute as 0. This rounds the number to zero decimal places. 

    select @RandomProductId = Round(((@UpperLimitForProductId - @LowerLimitForProductId) * Rand() + @LowerLimitForProductId), 0)
    select @RandomUnitPrice = Round(((@UpperLimitForUnitPrice - @LowerLimitForUnitPrice) * Rand() + @LowerLimitForUnitPrice), 0)
    select @RandomQuantitySold = Round(((@UpperLimitForQuantitySold - @LowerLimitForQuantitySold) * Rand() + @LowerLimitForQuantitySold), 0)

    Insert into tblProductsales
    values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

    Print @Counter
    Set @Counter = @Counter + 1
End
GO


Select *
from tblProducts
Select *
from tblProductSales



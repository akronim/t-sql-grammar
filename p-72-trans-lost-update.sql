use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- Lost update problem happens when 2 transactions read and update the same data

Create table tblInventory
(
    Id int identity primary key,
    Product nvarchar(100),
    ItemsInStock int
)
Go

Insert into tblInventory
values
    ('iPhone', 10)
GO


-- Open 2 instances of SQL Server Management studio. 
-- From the first window execute Transaction 1 code 
-- and from the second window, execute Transaction 2 code.

-- At the end of both the transactions ItemsInStock must be 7, but we have a value of 9.

-- Transaction 1
Begin Tran
Declare @ItemsInStock int

Select @ItemsInStock = ItemsInStock
from tblInventory
where Id=1

-- Transaction takes 10 seconds
Waitfor Delay '00:00:10'
Set @ItemsInStock = @ItemsInStock - 1

Update tblInventory 
Set ItemsInStock = @ItemsInStock where Id=1

Print @ItemsInStock

Commit Transaction

-- Transaction 2
Begin Tran
Declare @ItemsInStock int

Select @ItemsInStock = ItemsInStock
from tblInventory
where Id=1

-- Transaction takes 1 second
Waitfor Delay '00:00:1'
Set @ItemsInStock = @ItemsInStock - 2

Update tblInventory 
Set ItemsInStock = @ItemsInStock where Id=1

Print @ItemsInStock

Commit Transaction


-- solution
-- For both the above transactions, set Repeatable Read Isolation Level:
-- Set Transaction Isolation level repeatable read
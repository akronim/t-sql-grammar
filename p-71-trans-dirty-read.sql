use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- when one transaction is permitted to read data that has been modified 
-- by another transaction that has not yet been committed

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


--Transaction 1 : 
Begin Tran
Update tblInventory set ItemsInStock = 9 where Id=1
-- Billing the customer
Waitfor Delay '00:00:15'
-- Insufficient Funds. Rollback transaction
Rollback Transaction

--Transaction 2 :
Set Transaction Isolation Level Read Uncommitted
Select *
from tblInventory
where Id=1


-- The query below is equivalent to the query in Transaction 2. 
Select *
from tblInventory (NOLOCK)
where Id=1





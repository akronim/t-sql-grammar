use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- Phantom read happens when one transaction executes a query twice 
-- and it gets a different number of rows in the result set each time.
-- This happens when a second transaction inserts a new row that matches the WHERE clause 
-- of the query executed by the first transaction.



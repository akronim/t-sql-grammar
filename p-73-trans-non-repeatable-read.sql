use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- Non repeatable read problem happens when one transaction reads the same data twice 
-- and another transaction updates that data in between the first and second read of transaction one.



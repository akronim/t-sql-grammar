use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- Gets the list of tables only
Select *
from SYSOBJECTS
where XTYPE='U'

-- Gets the list of tables only
Select *
from SYS.TABLES

-- Gets the list of tables and views
Select *
from INFORMATION_SCHEMA.TABLES

-- To get the list of different object types (XTYPE) in a database
Select Distinct XTYPE
from SYSOBJECTS



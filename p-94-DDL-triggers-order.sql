use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- Server scoped triggers will always fire before any of the database scoped triggers. 
-- This execution order cannot be changed.

-- database-scoped
CREATE TRIGGER tr_DatabaseScopeTrigger
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    Print 'Database Scope Trigger'
END
GO


-- server-scoped
CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE
AS
BEGIN
    Print 'Server Scope Trigger'
END
GO


Create Table Test
(
    Id int
)
GO

-- Using the sp_settriggerorder stored procedure, 
-- you can set the execution order of server-scoped or database-scoped triggers















use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- In SQL Server there are 4 types of triggers 
-- 1. DML Triggers - Data Manipulation Language. 
-- 2. DDL Triggers - Data Definition Language
-- 3. CLR triggers - Common Language Runtime
-- 4. Logon triggers


-- DDL triggers fire in response to DDL events - CREATE, ALTER, and DROP 
-- (Table, Function, Index, Stored Procedure etc...)

-- What is the use of DDL triggers
--     • If you want to execute some code in response to a specific DDL event
--     • To prevent certain changes to your database schema
--     • Audit the changes that the users are making to the database structure


-- Syntax for creating DDL trigger
-- CREATE TRIGGER [Trigger_Name]
-- ON [Scope (Server|Database)]
-- FOR [EventType1, EventType2, EventType3, ...],
-- AS
-- BEGIN
-- 	-- Trigger Body
-- END


-- DDL triggers scope : DDL triggers can be created in a specific database 
-- or at the server level



-- The following trigger will fire in response to CREATE_TABLE DDL event. 
CREATE TRIGGER trMyFirstTrigger
ON Database
FOR CREATE_TABLE
AS
BEGIN
    Print '[+] New table created '
END

Create Table Test
(
    Id int
)
GO


-- If you want the trigger to be fired for multiple events
ALTER TRIGGER trMyFirstTrigger
ON Database
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    Print '[+] A table has just been created, modified or deleted'
END
GO


Drop TABLE Test
GO


-- how to prevent users from creating, altering or dropping tables
ALTER TRIGGER trMyFirstTrigger
ON Database
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    Rollback
    Print '[+] You cannot create, alter or drop a table'
END
GO

-- To disable trigger
DISABLE TRIGGER trMyFirstTrigger ON DATABASE
GO

-- To enable trigger
ENABLE TRIGGER trMyFirstTrigger ON DATABASE
GO

-- To drop trigger
DROP TRIGGER trMyFirstTrigger ON DATABASE
GO

-- The following trigger will be fired when ever you rename a database object 
-- using sp_rename system stored procedure.
CREATE TRIGGER trRenameTable
ON DATABASE
FOR RENAME
AS
BEGIN
    Print '[+] You just renamed something'
END
GO



Create Table Test
(
    Id int
)
GO

sp_rename 'Test', 'NewTestTable'
GO

sp_rename
'NewTestTable.Id', 'NewId', 'column'
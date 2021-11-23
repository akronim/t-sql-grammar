use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO



-- When you create a server scoped DDL trigger, it will fire in response to the DDL events 
-- happening in all of the databases on that server

CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    ROLLBACK
    Print 'You cannot create, alter or drop a table in any database on the server'
END
GO

-- To disable Server-scoped ddl trigger
DISABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER
GO

-- To enable Server-scoped ddl trigger
ENABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER 
GO

-- To drop Server-scoped ddl trigger
DROP TRIGGER tr_ServerScopeTrigger ON ALL SERVER
GO


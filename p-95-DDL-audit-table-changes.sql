use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

Create table TableChanges
(
    DatabaseName nvarchar(250),
    TableName nvarchar(250),
    EventType nvarchar(250),
    LoginName nvarchar(250),
    SQLCommand nvarchar(2500),
    AuditDateTime datetime
)
Go


-- The following trigger audits all table changes in all databases on a SQL Server
-- using a DDL trigger
CREATE TRIGGER tr_AuditTableChanges
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    DECLARE @EventData XML
    SELECT @EventData = EVENTDATA()

    INSERT INTO SampleDB.dbo.TableChanges
        (DatabaseName, TableName, EventType, LoginName,
        SQLCommand, AuditDateTime)
    VALUES
        (
            @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(250)'),
            @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(250)'),
            @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(250)'),
            @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(250)'),
            @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2500)'),
            GetDate()
    )
END 
GO
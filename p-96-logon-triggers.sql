use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO




-- Logon triggers fire in response to a LOGON event. 
-- Logon triggers fire after the authentication phase of logging in finishes, 
-- but before the user session is actually established.

-- Logon triggers can be used for
-- 1. Tracking login activity
-- 2. Restricting logins to SQL Server
-- 3. Limiting the number of sessions for a specific login 

-- An attempt to make a fourth connection, will be blocked. 
CREATE TRIGGER tr_LogonAuditTriggers
ON ALL SERVER
FOR LOGON
AS
BEGIN
    DECLARE @LoginName NVARCHAR(100)

    Set @LoginName = ORIGINAL_LOGIN()

    IF (SELECT COUNT(*)
    FROM sys.dm_exec_sessions
    WHERE is_user_process = 1
        AND original_login_name = @LoginName) > 3
    BEGIN
        Print 'Fourth connection of ' + @LoginName + ' blocked'
        ROLLBACK
    END
END
GO


-- The trigger error message will be written to the error log. 

-- Execute the following command to read the error log.
Execute sp_readerrorlog
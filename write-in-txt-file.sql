use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- Step 1: Enable Ole Automation Procedures
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO

-- Step 2: Write Text File
DECLARE @OLE INT
DECLARE @FileID INT
EXECUTE sp_OACreate 'Scripting.FileSystemObject', @OLE OUT
EXECUTE sp_OAMethod @OLE, 'OpenTextFile', @FileID OUT, 'E:\Documents\sqltotext.text', 8, 1
EXECUTE sp_OAMethod @FileID, 'WriteLine', Null, 'Today is wonderful day'
EXECUTE sp_OADestroy @FileID
EXECUTE sp_OADestroy @OLE
GO

-- Step 3: Disable Ole Automation Procedures
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 0;
GO
RECONFIGURE;
GO
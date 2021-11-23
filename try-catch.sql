use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

BEGIN TRY
	-- try / catch requires SQLServer 2005 
	PRINT(2/0)
END TRY
BEGIN CATCH
	PRINT 'Error Number: ' + str(error_number()) 
	PRINT 'Line Number: ' + str(error_line())
	PRINT error_message()
	-- handle error condition
END CATCH
use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

--DECLARE and SET Varibales
DECLARE @Mojo int

SET @Mojo = 1

SELECT @Mojo = Column_C
FROM Table_T
WHERE Id=1
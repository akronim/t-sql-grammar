use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- A transaction is a group of commands that change the data stored in a database. 
-- A transaction is treated as a single unit of work. 
-- A transaction ensures that, either all of the commands succeed, or none of them.


IF OBJECT_ID('dbo.Accounts', 'U') IS NOT NULL 
  DROP TABLE dbo.Accounts;


Create table Accounts
(
    Id int primary key,
    AccountName nvarchar(20),
    Balance int
)
GO

INSERT INTO Accounts
values
    (1, 'Mark', 1000),
    (2, 'Mary', 1000)



BEGIN TRY
    BEGIN TRANSACTION
         UPDATE Accounts SET Balance = Balance - 100 WHERE Id = 1
         UPDATE Accounts SET Balance = Balance + 100 WHERE Id = 2
    COMMIT TRANSACTION
    PRINT 'Transaction Committed'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Transaction Rolled back'
END CATCH


SELECT *
FROM Accounts
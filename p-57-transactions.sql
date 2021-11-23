use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- A transaction is a group of commands that change the data stored in a database. 
-- A transaction, is treated as a single unit.

-- BEGIN TRY
--     BEGIN TRANSACTION
--         -- CODE
--     COMMIT TRANSACTION
--     PRINT 'Transaction Committed'
-- END TRY
-- BEGIN CATCH
--     ROLLBACK TRANSACTION
--     PRINT 'Transaction Rolled back'
-- END CATCH


-- Create Procedure spNameOfProc
-- as
-- Begin
--     Begin Try
--         Begin Transaction
--     -- CODE
--         Commit Transaction
--     End Try
--     Begin Catch
--         Rollback Transaction
--     End Catch
-- End
-- GO

Create Table tblMailingAddress
(
    AddressId int NOT NULL primary key,
    EmployeeNumber int,
    HouseNumber nvarchar(50),
    StreetAddress nvarchar(50),
    City nvarchar(10),
    PostalCode nvarchar(50)
)

Insert into tblMailingAddress
values
    (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')



Create Table tblPhysicalAddress
(
    AddressId int NOT NULL primary key,
    EmployeeNumber int,
    HouseNumber nvarchar(50),
    StreetAddress nvarchar(50),
    City nvarchar(10),
    PostalCode nvarchar(50)
)

Insert into tblPhysicalAddress
values
    (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')
GO

Create Procedure spUpdateAddress
as
Begin
    Begin Try
Begin Transaction
Update tblMailingAddress set City = 'LONDON' 
where AddressId = 1 and EmployeeNumber = 101

Update tblPhysicalAddress set City = 'LONDON' 
where AddressId = 1 and EmployeeNumber = 101
Commit Transaction
End Try
Begin Catch
Rollback Transaction
End Catch
End
GO


Exec spUpdateAddress
GO


-- will fail
Alter Procedure spUpdateAddress
as
Begin
    Begin Try
Begin Transaction
Update tblMailingAddress set City = 'LONDON12' 
where AddressId = 1 and EmployeeNumber = 101

Update tblPhysicalAddress set City = 'LONDON LONDON' 
where AddressId = 1 and EmployeeNumber = 101
Commit Transaction
End Try
Begin Catch
Rollback Transaction
End Catch
End
GO


SELECT *
from tblMailingAddress
SELECT *
from tblPhysicalAddress














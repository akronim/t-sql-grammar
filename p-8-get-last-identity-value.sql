--There are several ways to retrieve the last identity value that is generated.

use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


IF OBJECT_ID('dbo.tblPerson', 'U') IS NOT NULL 
  DROP TABLE dbo.tblPerson;

Create Table tblPerson
(
    PersonId int Identity(1,1) Primary Key,
    Name nvarchar(20)
)

Insert into tblPerson
values
    ('Sam')

Insert into tblPerson
values
    ('Sara')

-- 3 approaches
-- returns the last identity value that is created in the same session and in the same scope
Select SCOPE_IDENTITY()
-- returns the last identity value that is created in the same session and across any scope
Select @@IDENTITY
-- returns the last identity value that is created for a specific table across any session and any scope
Select IDENT_CURRENT('tblPerson')
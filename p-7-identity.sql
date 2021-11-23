use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

--prije kreiranja tablice obriši drugu ako postoji pod istim imenom
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


--To explicitly supply a value for identity column
-- 1. Turn on identity insert 
SET Identity_Insert tblPerson ON
-- 2. In the insert query specify the column list
Insert into tblPerson
    (PersonId, Name)
values(3, 'John')


-- turn off Identity_Insert
SET Identity_Insert tblPerson OFF

delete from tblPerson

-- reset the identity column value
DBCC CHECKIDENT(tblPerson, RESEED, 0) 



-- We use UNIQUE constraint to enforce uniqueness of a column i.e the column shouldn't 
-- allow any duplicate values.

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
  FullName nvarchar(20)
)


Alter Table tblPerson
Add Constraint UQ_tblPerson_FullName Unique(FullName)

Insert into tblPerson
values
  ('Sam'),
  ('Sam')

-- To drop the constraint
Alter Table tblPerson
Drop CONSTRAINT UQ_tblPerson_FullName


-- Example 2
CREATE TABLE Country
(
  CountryID int IDENTITY(1,1) NOT NULL,
  Iso varchar(2) NOT NULL,
  Name varchar(80) NOT NULL,
  Iso3 varchar(3) NULL,
  NumCode int NULL,
  PhoneCode int NOT NULL,
  CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([CountryID] ASC),
  CONSTRAINT [UQ_Country_Iso] UNIQUE NONCLUSTERED ([Iso] ASC)
)
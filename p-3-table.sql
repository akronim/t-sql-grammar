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

CREATE TABLE tblPerson
(
    ID INT NOT NULL PRIMARY KEY,
    [Name] nvarchar(50),
    Email nvarchar(50),
    GenderID int NULL,
    Salary decimal(18,2) NULL
)

Create Table tblGender
(
    ID int Not Null Primary Key,
    Gender nvarchar(50)
)

--To add a column in a table, the ALTER TABLE syntax in SQL is:
ALTER TABLE tblPerson
ADD [Address] nvarchar(150) NULL;

--To add a foreign key reference using a query
Alter table tblPerson add constraint FK_tblPerson_tblGender
FOREIGN KEY (GenderId) references tblGender(ID)

--To DROP a FOREIGN KEY Constraint
ALTER TABLE tblPerson
DROP CONSTRAINT FK_tblPerson_tblGender

--dodavanje više redaka u tablicu
Insert into tblPerson
    (ID,[Name],Email)
values
    (1, 'Sam', 's@s.com'),
    (2, 'Sam', 's@s.com')


-- update
UPDATE tblPerson
SET [Name] = 'John'
WHERE Id = 2

--brisanje pojedinačnog retka iz tablice
delete from tblPerson where ID = 1

--brisanje svih zapisa iz tablice
delete from tblPerson

--brisanje svih zapisa iz tablice
TRUNCATE TABLE tblPerson

--brisanje pojedine kolone iz tablice
alter table tblPerson drop COLUMN GenderID
GO

-- brisanje tablice
DROP TABLE tblPerson

-- alter column type
Alter table tblPerson
Alter column Salary int
GO

--To rename a column in an existing table:
--sp_rename 'table_name.old_column', 'new_name', 'COLUMN';
sp_rename 'tblPerson.Address', 'Address_New', 'COLUMN';
GO

--To rename a table:
--For SQL Server (using the stored procedure called sp_rename):
sp_rename 'tblPerson', 'new_tblPerson';

--Add a NULL Constraint
ALTER TABLE tblPerson ALTER COLUMN Email int NOT NULL;
GO

--ovo će izlistati sve tablice u bazi:
select *
from information_schema.tables


-- check for the column existence
if not exists(Select *
from INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME='EmailAddress' and TABLE_NAME = 'tblEmployee' and TABLE_SCHEMA='dbo') 
Begin
    ALTER TABLE tblEmployee
ADD EmailAddress nvarchar(50)
End
Else
BEgin
    Print 'Column EmailAddress already exists'
End
GO


-- Col_length() function can also be used to check for the existence of a column
If col_length('tblEmployee','EmailAddress') is not null
Begin
    Print 'Column already exists'
End
Else
Begin
    Print 'Column does not exist'
End




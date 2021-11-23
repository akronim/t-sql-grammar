-- The default constraint is used to insert a default value into a column.

use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

CREATE TABLE tblPerson
(
    ID INT NOT NULL PRIMARY KEY,
    [Name] nvarchar(50),
    Email nvarchar(50),
    GenderID int NULL,
    DateModified DATETIME NOT NULL
)

-- Altering an existing column to add a default constraint:
ALTER TABLE tblPerson 
ADD CONSTRAINT DF_tblPerson_DateModified
DEFAULT GETDATE() FOR DateModified
GO

-- Altering an existing column to add a default constraint:
ALTER TABLE tblPerson
ADD CONSTRAINT DF_tblPerson_GenderId
DEFAULT 1 FOR GenderId
GO

Insert into tblPerson
    (ID,[Name],Email)
values(5, 'Sam', 's@s.com')


SELECT *
FROM tblPerson


-- Adding a new column, with default value, to an existing table:
ALTER TABLE tblPerson
ADD [Address] NVARCHAR(150) NULL
CONSTRAINT DF_tblPerson_Address DEFAULT 'ABC 10'

Insert into tblPerson
    (ID,[Name],Email)
values(6, 'Sam', 's@s.com')

--To drop a constraint
ALTER TABLE tblPerson
DROP CONSTRAINT DF_tblPerson_GenderId
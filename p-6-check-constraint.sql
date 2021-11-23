-- CHECK constraint is used to limit the range of the values that can be entered for a column.

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

-- Example 1
CREATE TABLE tblPerson
(
  ID INT NOT NULL PRIMARY KEY,
  [Name] nvarchar(50),
  Email nvarchar(50),
  Age int NOT NULL
)

-- The following check constraint, limits the age between ZERO and 150.
ALTER TABLE tblPerson
ADD CONSTRAINT CK_tblPerson_Age CHECK (Age > 0 AND Age < 150)

-- To drop the CHECK constraint:
ALTER TABLE tblPerson
DROP CONSTRAINT CK_tblPerson_Age

-- example 2
Create TABLE Employee
(
  Emp_Id Int identity(1,1),
  First_Name Nvarchar(MAX) Not NUll,
  Last_Name Nvarchar(MAX) Not Null,
  Salary Int Not Null check(Salary>20000),
  City Nvarchar(Max) Not Null
)
GO

-- example 3
Create TABLE tblEmployee
(
  Emp_Id Int identity(1,1),
  First_Name Nvarchar(MAX) Not NUll,
  Last_Name Nvarchar(MAX) Not Null,
  Salary Int Not Null,
  City Nvarchar(Max) Not Null,
  CONSTRAINT chk_salary CHECK(Salary>20000)
)
GO
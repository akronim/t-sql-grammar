use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

Create table tblEmployee
(
  ID int primary key identity,
  Name nvarchar(50),
  Gender nvarchar(50),
  Salary nvarchar(50)
)
GO


Insert into tblEmployee
values('Sara Nani', 'Female', '4500'),
  ('James Histo', 'Male', '5300'),
  ('Mary Jane', 'Female', '6200'),
  ('Paul Sensit', 'Male', '4200'),
  ('Mike Jen', 'Male', '5500')
GO


Select Gender, Sum(Salary) as Total
from tblEmployee
Group by Gender
GO


-- solution
Alter table tblEmployee
Alter column Salary int
GO









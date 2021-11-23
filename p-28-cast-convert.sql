use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- Syntax of CAST and CONVERT functions from MSDN:
-- CAST ( expression AS data_type [ ( length ) ] )
-- CONVERT ( data_type [ ( length ) ] , expression [ , style ] )

-- The general guideline is to use CAST(), unless you want to take advantage 
-- of the style functionality in CONVERT()

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL DROP TABLE dbo.tblEmployee;
Create table tblEmployee
(
    ID int primary key,
    [Name] nvarchar(50),
    [DOB] datetime
) 
Go

Insert into tblEmployee
values
    (1, 'Tom', '1980-12-30 00:00:00.000') ,
    (2, 'Pam', '1982-09-01 12:02:36.260') ,
    (3, 'John', '1985-08-22 12:03:30.370') ,
    (4, 'Sara', '1979-11-29 12:59:30.670') ,
    (5, 'Mark', '1979-11-29 12:59:30.670')  
Go

-- CAST
Select Id, Name, DOB, CAST(DOB as nvarchar) as ConvertedDOB
from tblEmployee

--CONVERT
Select Id, Name, DOB, Convert(nvarchar, DOB) as ConvertedDOB
from tblEmployee

--CONVERT (103: dd/mm/yyyy)
Select Id, Name, DOB, Convert(nvarchar, DOB, 104) as ConvertedDOB
from tblEmployee

--To get just the date part, from DateTime
SELECT CONVERT(VARCHAR(10),GETDATE(),104)

-- Date datatype
SELECT CAST(GETDATE() as DATE)
SELECT CONVERT(DATE, GETDATE())

-- CAST int to nvarchar
Select Id, [Name], [Name] + ' - ' + CAST(Id AS NVARCHAR) AS [Name-Id]
FROM tblEmployee


IF OBJECT_ID('dbo.tblRegistrations', 'U') IS NOT NULL DROP TABLE dbo.tblRegistrations;
Create table tblRegistrations
(
    ID int primary key,
    [Name] nvarchar(50),
    RegisteredDate datetime
) 
Go

Insert into tblRegistrations
values
    (1, 'Tom', '2012-08-24 00:00:00.000') ,
    (2, 'Pam', '2012-08-25 12:02:36.260') ,
    (3, 'John', '2012-08-25 12:03:30.370') ,
    (4, 'Sara', '2012-08-24 12:59:30.670') ,
    (5, 'Mark', '2012-08-24 12:59:30.670') ,
    (6, 'Mike', '2012-08-26 12:59:30.670')  
Go

-- Write a query which returns the total number of registrations by day
SELECT CAST(RegisteredDate as DATE) as RegistrationDate, COUNT(Id) as TotalRegistrations
from tblRegistrations
GROUP BY CAST(RegisteredDate as DATE)
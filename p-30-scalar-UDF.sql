use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- user defined functions - UDF
-- 3 types of UDF
-- 1. Scalar functions
-- 2. Inline table-valued functions
-- 3. Multistatement table-valued functions

-- Scalar functions may or may not have parameters, but always return a single (scalar) value. 
-- The returned value can be of any data type, except text, ntext, image, cursor, and timestamp.

CREATE FUNCTION Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN
    DECLARE @Age INT
    SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
    CASE WHEN (MONTH(@DOB) > MONTH(GETDATE()))
        OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) 
        THEN 1 ELSE 0 
        END
    RETURN @Age
END
GO

-- you must supply a two-part name, OwnerName.FunctionName
Select dbo.Age('10/08/1982')

Select TestDB.dbo.Age('10/08/1982')



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

-- in the Select clause
Select Name, DOB, dbo.Age(DOB) as Age
from tblEmployee

-- in the Where clause
Select Name, DOB, dbo.Age(DOB) as Age
from tblEmployee
Where dbo.Age(DOB) > 37

-- To alter a function we use ALTER FUNCTION FuncationName statement 
-- and to delete it, we use DROP FUNCTION FuncationName.
-- To view the text of the function use sp_helptext FunctionName 
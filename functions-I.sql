use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

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
    (4, 'Sara', '1979-11-29 12:59:30.670')   
Go

-- Write a query to compute the age of a person
CREATE FUNCTION fnComputeAge(@DOB DATETIME)
RETURNS NVARCHAR(50)
AS
BEGIN

    DECLARE @tempdate DATETIME, @years INT, @months INT, @days INT
    SELECT @tempdate = @DOB

    SELECT @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END
    SELECT @tempdate = DATEADD(YEAR, @years, @tempdate)

    SELECT @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - CASE WHEN DAY(@DOB) > DAY(GETDATE()) THEN 1 ELSE 0 END
    SELECT @tempdate = DATEADD(MONTH, @months, @tempdate)

    SELECT @days = DATEDIFF(DAY, @tempdate, GETDATE())

    DECLARE @Age NVARCHAR(50)
    SET @Age = Cast(@years AS  NVARCHAR(4)) + ' Years ' + Cast(@months AS NVARCHAR(2))+ ' Months ' +  Cast(@days AS  NVARCHAR(2))+ ' Days Old'
    RETURN @Age

End
GO

SELECT dbo.fnComputeAge('11/30/2005');

Select Id, [Name], DOB, dbo.fnComputeAge(DOB) as Age
from tblEmployee
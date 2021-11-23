use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- https://www.sqlshack.com/sql-while-loop-with-simple-examples/

DECLARE @Counter INT
SET @Counter=1
WHILE ( @Counter <= 10)
BEGIN
    PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
    SET @Counter  = @Counter  + 1
END
GO

-- The following query prints 10 random numbers between 1 and 100.
Declare @Counter INT
Set @Counter = 1
While(@Counter <= 10)
Begin
    Print FLOOR(RAND() * 100)
    Set @Counter = @Counter + 1
End
GO

-- BREAK statement
-- exit the current iteration of the loop immediately when certain conditions occur
DECLARE @Counter INT
SET @Counter=1
WHILE ( @Counter <= 10)
BEGIN
    PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
    IF @Counter >=7
        BEGIN
        PRINT '@Counter >=7';
        BREAK
    END

    SET @Counter  = @Counter  + 1
END
GO

-- CONTINUE statement
-- stop the current iteration of the loop when certain conditions occur, 
-- and then it starts a new iteration from the beginning of the loop
DECLARE @Counter INT
SET @Counter=1
WHILE ( @Counter <= 20)
BEGIN

    IF @Counter % 2 <> 0
  BEGIN
        SET @Counter  = @Counter  + 1
        CONTINUE
    END
    PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
    SET @Counter  = @Counter  + 1
END
GO


-- Reading table records through the WHILE loop
DROP TABLE IF EXISTS SampleTable

CREATE TABLE SampleTable
(
    Id INT,
    CountryName NVARCHAR(100),
    ReadStatus TINYINT
)
GO

INSERT INTO SampleTable
    ( Id, CountryName, ReadStatus)
Values
    (1, 'Germany', 0),
    (2, 'France', 0),
    (3, 'Italy', 0),
    (4, 'Netherlands', 0) ,
    (5, 'Poland', 0)

SELECT *
FROM SampleTable


DECLARE @Counter INT , @MaxId INT, 
        @CountryName NVARCHAR(100)

SELECT @Counter = min(Id) , @MaxId = max(Id)
FROM SampleTable

WHILE(@Counter IS NOT NULL
    AND @Counter <= @MaxId)
BEGIN
    SELECT @CountryName = CountryName
    FROM SampleTable
    WHERE Id = @Counter

    PRINT CONVERT(VARCHAR,@Counter) + '. country name is ' + @CountryName
    SET @Counter  = @Counter  + 1
END
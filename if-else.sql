use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- The formal for the IF…ELSE statement
-- IF (condition)
-- BEGIN
--    -- code block run when condition is TRUE
-- END
-- ELSE
-- BEGIN
--    -- code block run when condition is FALSE
-- END


-- if you just need to execute one statement,
-- you can omit the BEGIN END statement blocks

-- Condition: TRUE
IF (1=1)
PRINT 'IF STATEMENT: CONDITION IS TRUE'
ELSE
PRINT 'ELSE STATEMENT: CONDITION IS FALSE'


-- Condition: FLASE
IF (1=2)
PRINT 'IF STATEMENT: CONDITION IS TRUE'
ELSE
PRINT 'ELSE STATEMENT: CONDITION IS FALSE'


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

-- IF...ELSE with the variable in Boolean Expression

DECLARE @Country_ID INT = 4

IF (@Country_ID = 4)
    Select *
from SampleTable
where Id = 4
ELSE
    Select *
from SampleTable
where Id != 4


-- IF...ELSE with Begin End
DECLARE @Country_ID INT = 2

IF (@Country_ID <=2)
	BEGIN
    Select *
    from SampleTable
    where Id = 1
    Select *
    from SampleTable
    where Id = 2
END
ELSE
	BEGIN
    Select *
    from SampleTable
    where Id = 3
    Select *
    from SampleTable
    where Id = 4
END


-- IF statement with No Else
DECLARE @Country_ID INT = 2

IF (@Country_ID <=2)
	Select *
from SampleTable
where Id = 1


-- Nested IF…Else Statements
DECLARE @age INT;
SET @age = 60;

IF @age < 18
   PRINT 'underage';
ELSE
BEGIN
    IF @age < 50
      PRINT 'You are below 50';
   ELSE
      PRINT 'Senior';
END;


--IF / ELSE IF / ELSE Statement
IF 2 < 1
  BEGIN
    PRINT '2 < 1'
END
ELSE IF 2 = 1
  BEGIN
    PRINT '2 < 1'
END
ELSE
  BEGIN
    PRINT '2 > 1'
END
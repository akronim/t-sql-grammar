use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO


Select ASCII('A')

-- CHAR(Integer_Expression) - Converts an int ASCII code to a character
Declare @Number int
Set @Number = 1
While(@Number <= 255)
Begin
    Print CHAR(@Number)
    Set @Number = @Number + 1
End
GO


-- Printing uppercase alphabets using CHAR() function:
Declare @Number int
Set @Number = 65
While(@Number <= 90)
Begin
    Print CHAR(@Number)
    Set @Number = @Number + 1
End
GO

-- printing lower case alphabets using CHAR() and LOWER() functions.
Declare @Number int
Set @Number = 65
While(@Number <= 90)
Begin
    Print LOWER(CHAR(@Number))
    Set @Number = @Number + 1
End
GO

-- LTRIM(Character_Expression) 
-- Removes blanks on the left handside of the given character expression.
Select LTRIM('   Hello')

-- RTRIM(Character_Expression)
Select RTRIM('Hello   ')

Select LTRIM(RTRIM('   Hello   '))

-- LOWER(Character_Expression)
Select LOWER('CONVERT This String Into Lower Case')

-- UPPER(Character_Expression)
Select UPPER('CONVERT This String Into upper Case')

-- REVERSE('Any_String_Expression')
Select REVERSE('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

-- LEN(String_Expression) 
-- Returns the count of total characters in the given string expression, 
-- excluding the blanks at the end of the expression.
Select LEN('SQL Functions   ')

-- LEFT(Character_Expression, Integer_Expression) - 
-- Returns the specified number of characters from the left hand side 
-- of the given character expression.
Select LEFT('ABCDE', 3)

Select RIGHT('ABCDE', 3)

-- CHARINDEX('Expression_To_Find', 'Expression_To_Search', 'Start_Location') 
-- Returns the starting position of the specified expression in a character string
Select CHARINDEX('@','sara@aaa.com',1)

-- SUBSTRING('Expression', 'Start', 'Length')
Select SUBSTRING('John@bbb.com',6, 7)
-- II
Select SUBSTRING('John@bbb.com',
    (CHARINDEX('@', 'John@bbb.com') + 1), 
    (LEN('John@bbb.com') - CHARINDEX('@','John@bbb.com')))


IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL
DROP TABLE dbo.tblEmployee
GO

CREATE TABLE dbo.tblEmployee
(
    Id int PRIMARY KEY identity(1,1),
    [Name] NVARCHAR(50),
    Email NVARCHAR(50)
);
GO

INSERT INTO dbo.tblEmployee
VALUES
    ('Sam', 'sam@aaa.com'),
    ('Pam', 'pam@aaa.com'),
    ('Sara', 'sara@ccc.com'),
    ('Todd', 'todd@bbb.com'),
    ('John', 'john@aaa.com'),
    ('Sana', 'sana@ccc.com'),
    ('James', 'jaes@bbb.com'),
    ('Rob', 'rob@ccc.com'),
    ('Steve', 'steve@aaa.com'),
    ('Mary', 'mary@bbb.com')
GO

-- query to find out total number of emails, by domain
Select SUBSTRING(Email, CHARINDEX('@', Email) + 1,
LEN(Email) - CHARINDEX('@', Email)) as EmailDomain,
    COUNT(Email) as Total
from tblEmployee
Group By SUBSTRING(Email, CHARINDEX('@', Email) + 1,
LEN(Email) - CHARINDEX('@', Email))


-- REPLICATE(String_To_Be_Replicated, Number_Of_Times_To_Replicate)
SELECT REPLICATE('Pragim', 3)

Select [Name], SUBSTRING(Email, 1, 2) + REPLICATE('*',5) + 
SUBSTRING(Email, CHARINDEX('@',Email), LEN(Email) - CHARINDEX('@',Email)+1) as Email
from tblEmployee

-- SPACE(Number_Of_Spaces) - Returns number of spaces
-- insert 5 spaces between Name and Email
Select [Name] + SPACE(5) + Email as NameEmail
From tblEmployee

-- PATINDEX('%Pattern%', Expression)
-- Returns the starting position of the first occurrence of a pattern in a specified expression
Select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from tblEmployee
Where PATINDEX('%@aaa.com', Email) > 0

-- REPLACE(String_Expression, Pattern , Replacement_Value)
-- Replaces all occurrences of a specified string value with another string value.
Select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from tblEmployee

UPDATE tblEmployee
SET Email = REPLACE(Email, '.com', '.net')
-- WHERE ...

-- STUFF(Original_Expression, Start, Length, Replacement_expression)
-- inserts Replacement_expression, at the start position specified, 
-- along with removing the charactes specified using Length parameter
Select Name, Email, STUFF(Email, 2, 3, '*****') as StuffedEmail
From tblEmployee
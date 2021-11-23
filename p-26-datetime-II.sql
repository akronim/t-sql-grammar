use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- ISDATE() - Checks if the given value, is a valid date, time, or datetime. 
-- Returns 1 for success, 0 for failure.
Select ISDATE('PRAGIM')
Select ISDATE(Getdate())
Select ISDATE('2012-08-31 21:02:04.167')
-- For datetime2 values, IsDate returns ZERO
Select ISDATE('2012-09-01 11:34:21.1918447')


-- Day() - Returns the 'Day number of the Month' of the given date
Select DAY(GETDATE())
Select DAY('01/31/2012')

-- Month() - Returns the 'Month number of the year' of the given date
Select Month(GETDATE())
Select Month('01/31/2012')

-- Year() - Returns the 'Year number' of the given date
Select Year(GETDATE())
Select Year('01/31/2012')


-- DateName(DatePart, Date) - Returns a string, that represents a part of the given date.
Select DATENAME(Day, GETDATE())
Select DATENAME(WEEKDAY, GETDATE())
Select DATENAME(MONTH, GETDATE())


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

Select [Name], DOB, DateName(WEEKDAY,DOB) as [Day],
    Month(DOB) as MonthNumber,
    DateName(MONTH, DOB) as [MonthName],
    Year(DOB) as [Year]
From tblEmployee


-- Example 2
IF OBJECT_ID( 'tempdb..#Course' ) IS NOT NULL DROP TABLE #Course;
CREATE TABLE #Course
(
    course_name varchar(10),
    course_date datetime
);
INSERT INTO #Course
VALUES
    ('Java', '2015-10-06 11:16:10.496'),
    ('MySQL', '2015-10-07 00:00:00.000'),
    ('SQL SERVER', '2015-10-07 11:26:10.193' ),
    ('PostgreSQL', '2015-10-07 12:36:10.393'),
    ('Oracle', '2015-10-08 00:00:00.000')

-- get all courses which are on '2015-10-07'

-- wrong (because SQL server will use '00:00:00.000" for time
SELECT *
FROM #Course
WHERE course_date = '2015-10-07'

-- wrong (because BETWEEN clause will always pull any values of next date midnight)
SELECT *
FROM #Course
WHERE course_date between '2015-10-07' and '2015-10-08'


-- right (always use >= and < to compare dates)
SELECT *
FROM #Course
WHERE course_date >= '2015-10-07' and course_date < '2015-10-08'


SELECT *
FROM #Course
WHERE course_date > '2015-10-07 11:26:10.100' 


















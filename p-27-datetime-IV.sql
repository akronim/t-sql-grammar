use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- dohvati prvi dan u mjesecu za određeni datum:
SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) AS res
-- ako je select GETDATE(): 2019-07-22 10:04:32.093
-- 1) select DATEDIFF(MONTH, 0, GETDATE()) -- > number of months from 1900-01-01: 1434
-- 2) select DATEADD(MONTH, 1434, 0) -- > 1434 mjeseca dodajemo 1900-01-01: 2019-07-01 00:00:00.000

-- dohvati zadnji dan u mjesecu za određeni datum:
SELECT DATEADD(s, -1, DATEADD(mm, DATEDIFF(m, 0, getdate()) +1, 0)) AS res

-- dohvati samo date komponentu za određeni datum:
SELECT DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0) AS res
-- ako je select GETDATE(): 2019-07-22 10:04:32.093
-- 1) SELECT DATEDIFF(dd, 0, GETDATE()) AS res -- > broj dana od 1900-01-01: npr. 43666
-- 2) SELECT DATEADD(dd, 43666, 0) AS res -- > -- > 43666 dana dodajemo 1900-01-01: 2019-07-22 00:00:00.000


--Months
SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
-- First day of previous month

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), -1)
-- Last Day of previous month

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
-- First day of this month

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, -1)
-- Last day of this month

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0)
-- First day of next month

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 2, -1)
-- Last day of next month

--Quarters
SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) -1, 0)
-- First day of previous quarter

SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), -1)
-- Last day of previous quarter

SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), 0)
-- First day of this quarter

SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) + 1, -1)
-- Last day of this quarter

SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) + 1, 0)
-- First day of next quarter

SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) + 2, -1)
-- Last day of next quarter

SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, 0)
-- First day of 1st quarter of previous year

SELECT DATEADD(QUARTER, 1, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, -1))
-- Last day of 1st quarter of previous year

SELECT DATEADD(QUARTER, 1, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, 0))
-- First day of 2nd quarter of previous year

SELECT DATEADD(QUARTER, 2, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, -1))
-- Last day of 2nd quarter of previous year

SELECT DATEADD(QUARTER, 2, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, 0))
-- First day of 3rd quarter of previous year

SELECT DATEADD(QUARTER, 3, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, -1))
-- Last day of 3rd quarter of previous year

SELECT DATEADD(QUARTER, 3, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, 0))
-- First day of 4th quarter of previous year

SELECT DATEADD(QUARTER, 4, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) - 1, -1))
-- Last day of 4th quarter of previous year

SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0)
-- First day of 1st quarter of current year

SELECT DATEADD(QUARTER, 1, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), -1))
-- Last day of 1st quarter of current year

SELECT DATEADD(QUARTER, 1, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0))
-- First day of 2nd quarter of current year

SELECT DATEADD(QUARTER, 2, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), -1))
-- Last day of 2nd quarter of current year

SELECT DATEADD(QUARTER, 2, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0))
-- First day of 3rd quarter of current year

SELECT DATEADD(QUARTER, 3, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), -1))
-- Last day of 3rd quarter of current year

SELECT DATEADD(QUARTER, 3, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0))
-- First day of 4th quarter of current year

SELECT DATEADD(QUARTER, 4, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), -1))
-- Last day of 4th quarter of current year

--Years
SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) -1, 0)
-- First day of previous year

SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), -1)
-- Last day of previous year

SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0)
-- First day of this year

SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) + 1, -1)
-- Last day of this year

SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) + 1, 0)
-- First day of next year

SELECT DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) + 2, -1)
-- Last day of next year 

--Half Years
SELECT DATEADD(MONTH, 6, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) -1, 0))
-- First day of second half of previous year

SELECT DATEADD(MONTH, 6, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0))
-- First day of second half of this year

SELECT DATEADD(MONTH, 6, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) + 1, 0))
-- First day of second half of next year

--Other
SELECT GETDATE()
-- Now

SELECT DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), -1)
-- Yesterday

SELECT DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0)
-- Today

SELECT DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 1)
-- Tomorrow



SELECT DAY(GETDATE())
-- Day of month



SELECT DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), -30)
-- 30 days ago

SELECT DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), -90)
-- 90 days ago



SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, DAY(GETDATE())-1)
-- 1 months ago since last midnight

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 3, DAY(GETDATE())-1)
-- 3 months ago since last midnight

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 6, DAY(GETDATE())-1)
-- 6 months ago since last midnight

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 12, DAY(GETDATE())-1)
-- 12 months ago since last midnight


-- DATENAME – returns a string corresponding to the datepart specified
SELECT DATENAME(YEAR, GETDATE())        AS 'Year';
SELECT DATENAME(QUARTER, GETDATE())     AS 'Quarter';
SELECT DATENAME(MONTH, GETDATE())       AS 'Month';
SELECT DATENAME(DAYOFYEAR, GETDATE())   AS 'DayOfYear';
SELECT DATENAME(DAY, GETDATE())         AS 'Day';
SELECT DATENAME(WEEK, GETDATE())        AS 'Week';
SELECT DATENAME(WEEKDAY, GETDATE())     AS 'WeekDay';
SELECT DATENAME(HOUR, GETDATE())        AS 'Hour';
SELECT DATENAME(MINUTE, GETDATE())      AS 'Minute';
SELECT DATENAME(SECOND, GETDATE())      AS 'Second';
SELECT DATENAME(MILLISECOND, GETDATE()) AS 'MilliSecond';
SELECT DATENAME(MICROSECOND, GETDATE()) AS 'MicroSecond';
SELECT DATENAME(NANOSECOND, GETDATE())  AS 'NanoSecond';
SELECT DATENAME(ISO_WEEK, GETDATE())    AS 'Week';

-- date and time parts - returns int
SELECT DATEPART(YEAR, GETDATE())        AS 'Year';
SELECT DATEPART(QUARTER, GETDATE())     AS 'Quarter';
SELECT DATEPART(MONTH, GETDATE())       AS 'Month';
SELECT DATEPART(DAYOFYEAR, GETDATE())   AS 'DayOfYear';
SELECT DATEPART(DAY, GETDATE())         AS 'Day';
SELECT DATEPART(WEEK, GETDATE())        AS 'Week';
SELECT DATEPART(WEEKDAY, GETDATE())     AS 'WeekDay';
SELECT DATEPART(HOUR, GETDATE())        AS 'Hour';
SELECT DATEPART(MINUTE, GETDATE())      AS 'Minute';
SELECT DATEPART(SECOND, GETDATE())      AS 'Second';
SELECT DATEPART(MILLISECOND, GETDATE()) AS 'MilliSecond';
SELECT DATEPART(MICROSECOND, GETDATE()) AS 'MicroSecond';
SELECT DATEPART(NANOSECOND, GETDATE())  AS 'NanoSecond';
SELECT DATEPART(ISO_WEEK, GETDATE())    AS 'Week';


-- DAY – returns an integer corresponding to the day specified
-- MONTH– returns an integer corresponding to the month specified
-- YEAR– returns an integer corresponding to the year specified
SELECT DAY(GETDATE())   AS 'Day';
SELECT MONTH(GETDATE()) AS 'Month';
SELECT YEAR(GETDATE())  AS 'Year';


-- date and time from parts
SELECT DATEFROMPARTS(2019,1,1)                         AS 'Date';
-- returns date
SELECT DATETIME2FROMPARTS(2019,1,1,6,0,0,0,1)          AS 'DateTime2';
-- returns datetime2
SELECT DATETIMEFROMPARTS(2019,1,1,6,0,0,0)             AS 'DateTime';
-- returns datetime
SELECT DATETIMEOFFSETFROMPARTS(2019,1,1,6,0,0,0,0,0,0) AS 'Offset';
-- returns datetimeoffset
SELECT SMALLDATETIMEFROMPARTS(2019,1,1,6,0)            AS 'SmallDateTime';
-- returns smalldatetime
SELECT TIMEFROMPARTS(6,0,0,0,0)                        AS 'Time';          -- returns time


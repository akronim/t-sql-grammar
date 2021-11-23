use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- dummy data
IF OBJECT_ID('dbo.student', 'U') IS NOT NULL DROP TABLE dbo.student;
CREATE TABLE student
(
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    total_score INT NOT NULL
)


INSERT INTO student
VALUES
    (1, 'Jolly', 'Female', 20, 500),
    (2, 'Jon', 'Male', 22, 545),
    (3, 'Sara', 'Female', 25, 600),
    (4, 'Laura', 'Female', 18, 400),
    (5, 'Alan', 'Male', 20, 500),
    (6, 'Kate', 'Female', 22, 500),
    (7, 'Joseph', 'Male', 18, 643),
    (8, 'Mice', 'Male', 23, 543),
    (9, 'Wise', 'Male', 21, 499),
    (10, 'Elis', 'Female', 27, 400);


-- Creating A Temporary Table
-- Method 1
SELECT name, age, gender
INTO #MaleStudents
FROM student
WHERE gender = 'Male'

SELECT *
FROM #MaleStudents
GO

DROP TABLE #MaleStudents
GO


-- Creating A Temporary Table
-- Method 2
CREATE TABLE #MaleStudents
(
    name VARCHAR(50),
    age int,
    gender VARCHAR (50)
)

INSERT INTO #MaleStudents
SELECT name, age, gender
FROM student
WHERE gender = 'Male'
GO

SELECT *
FROM #MaleStudents
GO

DROP TABLE #MaleStudents
GO

-- temp table inside a stored procedure II
CREATE TABLE #MaleStudents
(
    name VARCHAR(50),
    age int,
    gender VARCHAR (50)
)
GO

Create Procedure spInsertStudent
    (@Name Varchar(50),
    @Age int,
    @Gender Varchar(50))
As
Begin
    Insert Into #MaleStudents
    Values
        (@Name, @Age, @Gender)
End
GO

CREATE PROCEDURE spListStudent
AS
BEGIN

    SELECT *
    FROM #MaleStudents
    ORDER BY name
END

EXECUTE spInsertStudent Bradley, 45, Male
Execute spListStudent
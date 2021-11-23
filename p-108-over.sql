use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- The OVER clause combined with PARTITION BY is used to break up data into partitions.
-- function (...) OVER (PARTITION BY col1, Col2, ...)


Create Table Employees
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10),
    Salary int
)
Go

Insert Into Employees
Values
    (1, 'Mark', 'Male', 5000),
    (2, 'John', 'Male', 4500),
    (3, 'Pam', 'Female', 5500),
    (4, 'Sara', 'Female', 4000),
    (5, 'Todd', 'Male', 3500),
    (6, 'Mary', 'Female', 5000),
    (7, 'Ben', 'Male', 6500),
    (8, 'Jodi', 'Female', 7000),
    (9, 'Tom', 'Male', 5500),
    (10, 'Ron', 'Male', 5000)
Go


-- retrieve total count of employees by Gender
-- also, we want Average, Minimum and Maximum salary by Gender
SELECT Gender, COUNT(*) AS GenderTotal, AVG(Salary) AS AvgSal,
    MIN(Salary) AS MinSal, MAX(Salary) AS MaxSal
FROM Employees
GROUP BY Gender


-- What if we want non-aggregated values (like employee Name and Salary) 
-- in result set along with aggregated values?


-- 1: One way to achieve this is by including the aggregations in a subquery 
-- and then JOINING it with the main query 
SELECT Name, Salary, Employees.Gender, Genders.GenderTotals,
    Genders.AvgSal, Genders.MinSal, Genders.MaxSal
FROM Employees
    INNER JOIN
    (SELECT Gender, COUNT(*) AS GenderTotals,
        AVG(Salary) AS AvgSal,
        MIN(Salary) AS MinSal, MAX(Salary) AS MaxSal
    FROM Employees
    GROUP BY Gender) AS Genders
    ON Genders.Gender = Employees.Gender
GO

-- 2: Better way of doing this is by using the OVER clause combined with PARTITION BY
SELECT Name, Salary, Gender,
    COUNT(Gender) OVER(PARTITION BY Gender) AS GenderTotals,
    AVG(Salary) OVER(PARTITION BY Gender) AS AvgSal,
    MIN(Salary) OVER(PARTITION BY Gender) AS MinSal,
    MAX(Salary) OVER(PARTITION BY Gender) AS MaxSal
FROM Employees

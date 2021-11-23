use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

IF OBJECT_ID('dbo.tblDepartment', 'U') IS NOT NULL 
  DROP TABLE dbo.tblDepartment;

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

Create table tblDepartment
(
    ID int primary key,
    DepartmentName nvarchar(50),
    City nvarchar(50)
)
Go

Insert into tblDepartment
values
    (1, 'IT', 'London'),
    (2, 'Payroll', 'Delhi'),
    (3, 'HR', 'New York'),
    (4, 'Other Department', 'Sydney')
Go

Create table tblEmployee
(
    ID int primary key,
    Name nvarchar(50),
    Gender nvarchar(50),
    Salary int,
    Age int,
    DepartmentId int foreign key references tblDepartment(Id)
)
Go

Insert into tblEmployee
values
    (1, 'Tom', 'Male', 4000, 25, 1),
    (2, 'Pam', 'Female', 3000, 25, 3),
    (3, 'John', 'Male', 5500, 30, 1),
    (4, 'Samantha', 'Female', 6500, 30, 2),
    (5, 'Todd', 'Male', 9800, 55, 2),
    (6, 'Betty', 'Female', 7000, 55, 1),
    (7, 'Sara', 'Female', 4800, 28, 3),
    (8, 'Victor', 'Male', 5500, 28, 1),
    (9, 'James', 'Male', 7500, 33, 2),
    (10, 'Christine', 'Female', 8800, 33, 1)
Go


-- GROUP BY: often used with aggregate functions (COUNT, MAX, MIN, SUM, AVG) 
-- to group the result-set by one or more columns

-- GROUP BY clause is used with the SELECT statement
-- GROUP BY clause is placed after the WHERE clause
-- GROUP BY clause is placed before ORDER BY clause if used any
-- svaka kolona koja nije dio agregatne funkcije mora biti uključena u GROUP BY
-- GROUP BY može imati kolonu koja nije dio SELECT-a

-- SELECT column_name1, COUNT(column_name2) 
-- FROM table_name 
-- WHERE condition 
-- GROUP BY column_name1 
-- ORDER BY COUNT(column_name2) DESC;

-- average salaries by age
Select Age, AVG(Salary) as AverageSalary
from tblEmployee
Group by Age

-- average salaries by age and by gender (first by age and then by gender)
Select Age, Gender, AVG(Salary) as AverageSalary
from tblEmployee
group by Age, Gender

-- average salaries and total number of employees by age, and by gender
Select Age, Gender, AVG(Salary) as AverageSalary, COUNT(ID) as TotalEmployees
from tblEmployee
group by Age, Gender

-- Filtering rows using WHERE clause, before aggregations take place
Select Age, AVG(Salary) as TotalSalary
from tblEmployee
Where Age = 25
group by Age

--Filtering groups using HAVING clause, after all aggrgations take place
Select Age, AVG(Salary) as TotalSalary
from tblEmployee
group by Age
Having Age = 25

--combine WHERE and HAVING
Select Age, AVG(Salary) as TotalSalary
from tblEmployee
Where Gender = 'Male'
group by Age
Having Age = 25

--combine WHERE and HAVING
select ID, Salary
from tblEmployee
GROUP BY ID, Salary
HAVING SUM(Salary) > 5000


-- join
select COUNT(e.ID) as TotalEmployees, d.DepartmentName
from tblEmployee as e
    join tblDepartment as d
    on e.DepartmentId = d.ID
GROUP by d.DepartmentName

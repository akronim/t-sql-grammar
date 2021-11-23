use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- CASE <Case_Expression>
--      WHEN Value_1 THEN Statement_1
--      WHEN Value_2 THEN Statement_2
--      .
--      .
--      WHEN Value_N THEN Statement_N
--      [ELSE Statement_Else]   
-- END  [AS ALIAS_NAME]


IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

create table tblEmployee
(
  EmployeeId int primary key,
  [Name] nvarchar (50) null,
  Salary int null,
  ManagerId int null
);

insert into tblEmployee
values
  (1, 'Mirko', 1250, 7),
  (2, 'Slavko', 1550, 4),
  (3, 'Ana', 2250, 4),
  (4, 'Josip', 1750, 6),
  (5, 'Slavica', 1210, 4),
  (6, 'Marina', 2350, null),
  (7, 'Filip', 1900, 6),
  (8, 'Luka', 2800, 7),
  (9, 'Ivana', 1420, 4),
  (10, 'Vedran', 1600, 4)


SELECT E.Name as Employee,
  CASE WHEN M.Name IS NULL THEN 'No Manager' 
	ELSE M.Name END as Manager
FROM tblEmployee E
  LEFT JOIN tblEmployee M
  ON E.ManagerID = M.EmployeeID
GO

-- example 2
CREATE TABLE dbo.Employee
(
  EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
  EmployeeName NVARCHAR(100) NOT NULL,
  Gender NVARCHAR(1) NOT NULL,
  Code NVARCHAR(20) NOT NULL,
  Age int,
  Salary decimal(18,2) NOT NULL,
) 
GO


INSERT [dbo].[Employee]
  ([EmployeeName], [Gender], [Code], [Age], [Salary])
VALUES
  (N'Jerome', N'M', N'ABC', 35, 83000.00),
  (N'Ray', N'M', N'BCD', 31, 88000.00),
  (N'Stella', N'F', N'ABC', 24, 76000.00),
  (N'Gilbert', N'M', N'DEF', 33, 42000.00),
  (N'Edward', N'M', N'DEF', 29, 93000.00),
  (N'Ernest', N'F', N'EFG', 27, 64000.00),
  (N'Jorge', N'F', N'BCD', 34, 75000.00),
  (N'Nicholas', N'F', N'EFG', 19, 71000.00),
  (N'Lawrence', N'M', N'ABC', 20, 95000.00),
  (N'Salvador', N'M', N'EFG', 22, 75000.00)
GO

SELECT EmployeeName,
  CASE 
When Gender = 'M' Then 'Male'
When Gender = 'F' Then 'Female'
ELSE 'X' 
END as Gender
FROM Employee
GO

SELECT EmployeeName,
  CASE Gender
When 'M' Then 'Male'
When 'F' Then 'Female'
ELSE 'X' 
END as Gender
FROM Employee
GO

-- The CASE statement and comparison operator
Select EmployeeName,
  CASE
WHEN Salary >=80000 AND Salary <=100000 THEN 'Director'
WHEN Salary >=50000 AND Salary <80000 THEN 'Senior Consultant'
Else 'Assistant'
END AS Designation
from Employee


-- Case Statement with Order by clause
-- For female employees salaries should come in descending order
-- For male employees salaries should come in ascending order
Select EmployeeName, Gender, Salary
from Employee
ORDER BY  
CASE WHEN Gender = 'F' THEN Salary End DESC,
Case WHEN Gender='M' THEN Salary  END ASC


-- inside aggregations 
SELECT
  SUM(CASE WHEN Gender='M' THEN 1 ELSE 0 END) AS NumberOfMaleEmployees,
  SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END) AS NumberOfFemaleEmployees
FROM Employee


-- inside WHERE
SELECT *
FROM Employee
WHERE 
(CASE WHEN Gender='M' THEN Age ELSE 0 END) > 30
  OR
  (CASE WHEN Gender='F' THEN Age ELSE 0 END) > 20


-- Case Statement in SQL with Group by clause
Select
  CASE
WHEN Salary >=80000 AND Salary <=100000 THEN 'Director'
WHEN Salary >=50000 AND Salary <80000 THEN 'Senior Consultant'
Else 'Assistant'
END AS Designation,
  Min(salary) as MinimumSalary,
  Max(Salary) as MaximumSalary
from Employee
Group By
CASE
WHEN Salary >=80000 AND Salary <=100000 THEN 'Director'
WHEN Salary >=50000 AND Salary <80000 THEN 'Senior Consultant'
Else 'Assistant'
END


-- Update statement with a CASE statement
UPDATE employee 
SET Code  = CASE Code
 WHEN 'ABC' THEN 'ABC_1' 
 WHEN 'BCD' THEN 'BCD_1' 
  ELSE  Code + '_2' 
 END

SELECT *
from Employee


-- Insert statement with CASE statement
Declare @EmployeeName varchar(100)
Declare @Gender int
Declare @Code char(2)
DECLARE @Age int
Declare @salary money
Set @EmployeeName='Raj'
Set @Gender=0
Set @Code='GHI'
Set @Age = 39
set @salary=52000

Insert into employee
values
  (@EmployeeName,
    CASE @Gender
WHEN 0 THEN 'M'
WHEN 1 THEN 'F'
end,
    @Code,
    @Age,
    @salary)
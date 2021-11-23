use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO


IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

CREATE TABLE tblEmployee
(
    Id int Primary Key,
    Name nvarchar(30),
    Gender nvarchar(10),
    DepartmentId int
)

Insert into tblEmployee
values
    (1, 'John', 'Male', 3),
    (2, 'Mike', 'Male', 2),
    (3, 'Pam', 'Female', 1),
    (4, 'Todd', 'Male', 4),
    (5, 'Sara', 'Female', 1),
    (6, 'Ben', 'Male', 3)
GO

IF OBJECT_ID('dbo.tblDepartment', 'U') IS NOT NULL 
  DROP TABLE dbo.tblDepartment;

CREATE TABLE tblDepartment
(
    DeptId int Primary Key,
    DeptName nvarchar(20)
)

Insert into tblDepartment
values
    (1, 'IT'),
    (2, 'Payroll'),
    (3, 'HR'),
    (4, 'Admin')
GO



-- A CTE is a temporary result set, that can be referenced within  
-- SELECT, INSERT, UPDATE, or DELETE statement, that immediately follows the CTE.


-- SQL query using CTE:
With
    EmployeeCount(DepartmentId, TotalEmployees)
    as
    (
        Select DepartmentId, COUNT(*) as TotalEmployees
        from tblEmployee
        group by DepartmentId
    )
-- a CTE can only be referenced by a SELECT, INSERT, UPDATE, or DELETE statement, 
-- that immediately follows the CTE
Select DeptName, TotalEmployees
from tblDepartment
    join EmployeeCount
    on tblDepartment.DeptId = EmployeeCount.DepartmentId
order by TotalEmployees
GO


-- 1. We define a CTE, using WITH keyword, followed by the name of the CTE
-- 2. Within parentheses, we specify the columns that make up the CTE
-- 3. These 2 columns map to the columns returned by the SELECT CTE query
-- 4. The column list is followed by the as keyword, and query within a pair of parentheses.


-- It is also, possible to create multiple CTE's using a single WITH clause.
With
    EmployeesCountBy_Payroll_IT_Dept(DepartmentName, Total)
    as
    (
        Select DeptName, COUNT(Id) as TotalEmployees
        from tblEmployee
            join tblDepartment
            on tblEmployee.DepartmentId = tblDepartment.DeptId
        where DeptName IN ('Payroll','IT')
        group by DeptName
    ),
    EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
    as
    (
        Select DeptName, COUNT(Id) as TotalEmployees
        from tblEmployee
            join tblDepartment
            on tblEmployee.DepartmentId = tblDepartment.DeptId
        group by DeptName
    )
    Select *
    from EmployeesCountBy_HR_Admin_Dept
UNION
    Select *
    from EmployeesCountBy_Payroll_IT_Dept
GO









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

-- simple query
Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
from tblEmployee
    join tblDepartment
    on tblEmployee.DepartmentId = tblDepartment.DeptId
group by DeptName, DepartmentId
having COUNT(*) >= 2
GO


-- using view
Create view vWEmployeeCount
as
    Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
    group by DeptName, DepartmentId
GO

Select DeptName, TotalEmployees
from vWEmployeeCount
where  TotalEmployees >= 2
GO


-- using local temporary tables
Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
into #TempEmployeeCount
from tblEmployee
    join tblDepartment
    on tblEmployee.DepartmentId = tblDepartment.DeptId
group by DeptName, DepartmentId
GO

Select DeptName, TotalEmployees
From #TempEmployeeCount
where TotalEmployees >= 2

Drop Table #TempEmployeeCount
GO


-- Using Table Variable:
Declare @tblEmployeeCount table
(DeptName nvarchar(20),
    DepartmentId int,
    TotalEmployees int)

Insert @tblEmployeeCount
Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
from tblEmployee
    join tblDepartment
    on tblEmployee.DepartmentId = tblDepartment.DeptId
group by DeptName, DepartmentId


Select DeptName, TotalEmployees
From @tblEmployeeCount
where  TotalEmployees >= 2
GO


-- Using Derived Tables
-- Derived tables are available only in the context of the current query
Select DeptName, TotalEmployees
from
    (
Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
    from tblEmployee
        join tblDepartment
        on tblEmployee.DepartmentId = tblDepartment.DeptId
    group by DeptName, DepartmentId
) 
as EmployeeCount
where TotalEmployees >= 2
GO


-- Using CTE
With
    EmployeeCount(DeptName, DepartmentId, TotalEmployees)
    as
    (
        Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
        from tblEmployee
            join tblDepartment
            on tblEmployee.DepartmentId = tblDepartment.DeptId
        group by DeptName, DepartmentId
    )

Select DeptName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2
GO

-- A CTE is a temporary result set, that can be referenced within  
-- SELECT, INSERT, UPDATE, or DELETE statement, that immediately follows the CTE.















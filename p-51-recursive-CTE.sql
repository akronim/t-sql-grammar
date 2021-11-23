use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- A CTE that references itself is called as recursive CTE

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

Create Table tblEmployee
(
    EmployeeId int Primary key,
    Name nvarchar(20),
    ManagerId int
)

insert into tblEmployee
values
    (1, 'Tom', 2),
    (2, 'Josh', null),
    (3, 'Mike', 2),
    (4, 'John', 3),
    (5, 'Pam', 1),
    (6, 'Mary', 3),
    (7, 'James', 1),
    (8, 'Sam', 5),
    (9, 'Simon', 1)
GO

-- SELF JOIN QUERY:
Select Employee.Name as [Employee Name],
    IsNull(Manager.Name, 'Super Boss') as [Manager Name]
from tblEmployee Employee
    left join tblEmployee Manager
    on Employee.ManagerId = Manager.EmployeeId
GO


With
    EmployeesCTE (EmployeeId, Name, ManagerId, [Level])
    as
    (
                    Select EmployeeId, Name, ManagerId, 1
            from tblEmployee
            where ManagerId is null

        union all

            Select tblEmployee.EmployeeId, tblEmployee.Name,
                tblEmployee.ManagerId, EmployeesCTE.[Level] + 1
            from tblEmployee
                join EmployeesCTE
                on tblEmployee.ManagerID = EmployeesCTE.EmployeeId
    )
Select EmpCTE.Name as Employee, Isnull(MgrCTE.Name, 'Super Boss') as Manager,
    EmpCTE.[Level]
from EmployeesCTE EmpCTE
    left join EmployeesCTE MgrCTE
    on EmpCTE.ManagerId = MgrCTE.EmployeeId
GO


-- The EmployeesCTE contains 2 queries with UNION ALL operator. 
-- The first query selects the EmployeeId, Name, ManagerId, and 1 as the level 
-- from tblEmployee where ManagerId is NULL. So, here we are giving a LEVEL = 1 
-- for super boss (Whose Manager Id is NULL). In the second query, we are joining 
-- tblEmployee with EmployeesCTE itself, which allows us to loop thru the hierarchy. 
-- Finally to get the reuired output, we are joining EmployeesCTE with itself. 









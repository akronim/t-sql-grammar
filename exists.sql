use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

Create table Department
(
    DepartmentId int primary key,
    DepartmentName nvarchar(50)
)
Go

Insert into Department
values
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Payroll')
Go

Create table Employee
(
    Id int primary key,
    Name nvarchar(100),
    Gender nvarchar(10),
    Salary int,
    DepartmentId int foreign key references Department(DepartmentId)
)
Go

Insert into Employee
values
    (1, 'Mark', 'Male', 50000, 1),
    (2, 'Sara', 'Female', 65000, 2),
    (3, 'Mike', 'Male', 48000, 3),
    (4, 'Pam', 'Female', 70000, 1),
    (5, 'John', 'Male', 55000, 2)
Go


-- The EXISTS operator is used to test for the existence of any record in a subquery.

-- The EXISTS operator returns true if the subquery returns at least one record 
-- and false if no row is selected. 

-- If a single record is matched, the EXISTS operator returns true, 
-- and the associated other query row is selected.

SELECT DepartmentName
FROM Department
WHERE EXISTS (
    SELECT DepartmentId
FROM Employee
WHERE Department.DepartmentId = Employee.DepartmentId
    and Employee.Salary >= 60000);


SELECT DepartmentName
FROM Department
WHERE NOT EXISTS (
    SELECT DepartmentId
FROM Employee
WHERE Department.DepartmentId = Employee.DepartmentId
    and Employee.Salary >= 60000);

use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

CREATE TABLE Departments
(
  DepartmentID INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  Budget decimal NOT NULL
);

CREATE TABLE Employees
(
  EmployeeID INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  DepartmentID INTEGER NOT NULL ,
  foreign key (DepartmentID)  references Departments(DepartmentID)
);

INSERT INTO Departments
  (DepartmentID,Name,Budget)
VALUES(14, 'IT', 65000),
  (37, 'Accounting', 15000),
  (59, 'Human Resources', 240000),
  (77, 'Research', 55000);

INSERT INTO Employees
  (EmployeeID,Name,LastName,DepartmentID)
VALUES('123234877', 'Michael', 'Rogers', 14),
  ('152934485', 'Anand', 'Manikutty', 14),
  ('222364883', 'Carol', 'Smith', 37),
  ('326587417', 'Joe', 'Stevens', 37),
  ('332154719', 'Mary-Anne', 'Foster', 14),
  ('332569843', 'George', 'ODonnell', 77),
  ('546523478', 'John', 'Doe', 59),
  ('631231482', 'David', 'Smith', 77),
  ('654873219', 'Zacary', 'Efron', 59),
  ('745685214', 'Eric', 'Goldsmith', 59),
  ('845657245', 'Elizabeth', 'Doe', 14),
  ('845657246', 'Kumar', 'Swamy', 14)


-- 2.2 Select the last name of all employees, without duplicates.
select distinct LastName
from employees;


-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select *
from Employees
where lastname in ('Smith', 'Doe');

-- 2.7 Select all the data of employees whose last name begins with an "S".
select *
from employees
where LastName like 'S%';


-- 2.8 Select the sum of all the departments' budgets.
select sum(budget)
from Departments;

select Name, sum(Budget)
from Departments
group by Name;


-- 2.9 Select the number of employees in each department (you only need to show the department DepartmentID and the number of employees).
select DepartmentID, count(*)
from employees
group by DepartmentID;

SELECT DepartmentID, COUNT(*)
FROM Employees
GROUP BY DepartmentID;


-- 2.10 Select all the data of employees, including each employee's department's data.
select a.*, b.*
from employees a
  join departments b
  on a.DepartmentID = b.DepartmentID;

SELECT EmployeeID, E.Name AS Name_E, LastName, D.Name AS Name_D, E.DepartmentID, D.DepartmentID, Budget
FROM Employees E
  INNER JOIN Departments D
  ON E.DepartmentID = D.DepartmentID;


-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select a.name, a.lastname, b.name Department_name, b.Budget
from employees a join departments b
  on a.DepartmentID = b.DepartmentID;

/* Without labels */
SELECT Employees.Name, LastName, Departments.Name AS DepartmentsName, Budget
FROM Employees INNER JOIN Departments
  ON Employees.DepartmentID = Departments.DepartmentID;

/* With labels */
SELECT E.Name, LastName, D.Name AS DepartmentsName, Budget
FROM Employees E INNER JOIN Departments D
  ON E.DepartmentID = D.DepartmentID;


-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select name, lastname
from employees
where DepartmentID in (
select DepartmentID
from departments
where Budget>60000
);

/* Without subquery */
SELECT Employees.Name, LastName
FROM Employees INNER JOIN Departments
  ON Employees.DepartmentID = Departments.DepartmentID
    AND Departments.Budget > 60000;

/* With subquery */
SELECT Name, LastName
FROM Employees
WHERE DepartmentID IN
  (SELECT DepartmentID
FROM Departments
WHERE Budget > 60000);


-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select *
from departments
where budget > (
select avg(budget)
from departments
);

SELECT *
FROM Departments
WHERE Budget >
  (
    SELECT AVG(Budget)
FROM Departments
  );


-- 2.14 
-- Select the names of departments with more than two employees.
select b.name
from departments b
where DepartmentID in (
select DepartmentID
from employees
group by DepartmentID
having count(*)>2
);

/* With subquery */
SELECT Name
FROM Departments
WHERE DepartmentID IN
  (
    SELECT DepartmentID
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 2
  );

/* With UNION. This assumes that no two departments have
   the same name */
SELECT Departments.Name
FROM Employees
  INNER JOIN Departments
  ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY Departments.Name
HAVING COUNT(*) > 2;


-- 2.15
-- Very Important
-- Select the name and last name of employees working for departments with second lowest 
-- budget.

WITH
  CTE
  AS
  (
    SELECT *, RN = ROW_NUMBER() OVER (ORDER BY budget ASC)
    FROM dbo.departments
  )
SELECT Employees.Name, Employees.LastName
FROM Employees
  JOIN CTE on CTE.DepartmentID = Employees.DepartmentID
WHERE CTE.RN = 2


-- 2.16
-- Add a new department called "Quality Assurance", with a budget of $40,000 and departmental DepartmentID 11. 
-- Add an employee called "Mary Moore" in that department, with EmployeeID 847-21-9811.
insert into departments
values(11, 'Quality Assurance', 40000);
insert into employees
values(847219811, 'Mary', 'Moore', 11);


-- 2.17
-- Reduce the budget of all departments by 10%.
update departments
set budget
= 0.9 * budget;


-- 2.18
-- Reassign all employees from the Research department (DepartmentID 77) to the IT department (DepartmentID 14).
update employees
set DepartmentID = 14
where DepartmentID = 77;

-- 2.19
-- Delete from the table all employees in the IT department (DepartmentID 14).

delete from employees
where DepartmentID = 14;

-- 2.20
-- Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees
where DepartmentID in (
select DepartmentID
from departments
where budget>=60000
);


-- 2.21
-- Delete from the table all employees.
delete from employees;

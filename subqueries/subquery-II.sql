use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

IF OBJECT_ID('dbo.CUSTOMERS', 'U') IS NOT NULL 
  DROP TABLE dbo.CUSTOMERS;

CREATE TABLE CUSTOMERS
(
  ID INT NOT NULL PRIMARY KEY,
  [Name] nvarchar(50),
  Age int,
  [Address] nvarchar(50),
  Salary Money
)

INSERT INTO CUSTOMERS
  (ID, [Name], Age, [Address], Salary)
VALUES
  (1, 'Ramesh', 35, 'Ahmedabad ', 2000.00),
  (2, 'Khilan', 25, 'Delhi', 1500.00),
  (3, 'kaushik', 23, 'Kota', 2000.00),
  (4, 'Chaitali', 25, 'Mumbai', 6500.00),
  (5, 'Hardik', 27, 'Bhopal', 8500.00),
  (6, 'Komal', 22, 'MP', 4500.00),
  (7, 'Muffy', 24, 'Indore', 10000.00)
GO

-- Subqueries with the SELECT Statement
SELECT *
FROM CUSTOMERS
WHERE ID IN (SELECT ID
FROM CUSTOMERS
WHERE SALARY > 4500);


-- Subqueries with the INSERT Statement
IF OBJECT_ID('dbo.CUSTOMERS_BKP', 'U') IS NOT NULL 
  DROP TABLE dbo.CUSTOMERS_BKP;

CREATE TABLE CUSTOMERS_BKP
(
  ID INT NOT NULL PRIMARY KEY,
  [Name] nvarchar(50),
  Age int,
  [Address] nvarchar(50),
  Salary Money
)


INSERT INTO CUSTOMERS_BKP
SELECT *
FROM CUSTOMERS
WHERE ID IN (SELECT ID
FROM CUSTOMERS);

-- Subqueries with the UPDATE Statement
UPDATE CUSTOMERS
   SET SALARY = SALARY * 0.25
   WHERE AGE IN (SELECT AGE
FROM CUSTOMERS_BKP
WHERE AGE >= 27 );


-- Subqueries with the DELETE Statement
DELETE FROM CUSTOMERS
   WHERE AGE IN (SELECT AGE
FROM CUSTOMERS_BKP
WHERE AGE >= 27 );
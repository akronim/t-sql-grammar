use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

CREATE TABLE Person
(
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    City varchar(255)
);

INSERT INTO Person
    (PersonID, LastName, FirstName, City)
VALUES
    (1 , 'Erichsen', 'Tom', 'Newyork'),
    (2 , 'Cleverly', 'John', 'Texas'),
    (3 , 'George', 'Bill', 'Chicago');

-- Nested SELECT ------

SELECT A.PersonID
FROM (
    SELECT PersonID, LastName, FirstName
    FROM Person
    ) AS A;
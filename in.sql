use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


CREATE TABLE tblPerson
(
    ID INT NOT NULL PRIMARY KEY,
    [Name] nvarchar(50),
    Age int,
    Email nvarchar(50),
    City nvarchar(50)
)

INSERT INTO tblPerson
    (ID, [Name], Age, Email, City)
VALUES
    (1, 'Mark', 20, 'mark@mark.com', 'London'),
    (2, 'Sam', 29, 'sam@sam.com', 'Zagreb'),
    (3, 'Mark', 23, 'mark@mark.com', 'London'),
    (4, 'John', 25, 'j@j.com', 'Mumbai'),
    (5, 'Adam', 26, 'adam@adam.com', 'Berlin'),
    (6, 'Bob', 21, 'bob@bob.com', 'Oslo'),
    (7, 'Christine', 27, 'c@c.com', 'Zagreb')
GO

-- essentially the IN operator is shorthand for multiple OR conditions

SELECT *
FROM tblPerson
WHERE Age IN (20, 21, 23)
GO

SELECT *
FROM tblPerson
WHERE Age NOT IN (20, 21, 23)
GO


-- example 2

Create Table tblProducts
(
    [Id] int identity primary key,
    [Name] nvarchar(50),
    [Description] nvarchar(250)
)

Create Table tblProductSales
(
    Id int primary key identity,
    ProductId int foreign key references tblProducts(Id),
    UnitPrice int,
    QuantitySold int
)

Insert into tblProducts
values
    ('TV', '52 inch black color LCD TV'),
    ('Laptop', 'Very thin black color acer laptop'),
    ('Desktop', 'HP high performance desktop')
GO

Insert into tblProductSales
values
    (3, 450, 5),
    (2, 250, 7),
    (3, 450, 4),
    (3, 450, 9)
GO

SELECT *
FROM tblProducts
WHERE Id IN (SELECT ProductId
from tblProductSales
where QuantitySold > 5)
GO
use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


IF OBJECT_ID('dbo.tblPerson', 'U') IS NOT NULL 
  DROP TABLE dbo.tblPerson;

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
    (3, 'Jack', 23, 'jack@jack.com', 'London'),
    (4, 'John', 25, 'j@j.com', 'Mumbai'),
    (5, 'Adam', 26, 'adam@adam.com', 'Berlin'),
    (6, 'Bob', 21, 'bob@bob.com', 'Oslo'),
    (7, 'Christine', 27, 'c@c.com', 'Zagreb')
GO

-- find values that start with "L"
select *
from tblPerson
where City LIKE 'L%'

-- find values that end with "n"
select *
from tblPerson
where City LIKE '%n'

-- find values that have "a" in the second position
select *
from tblPerson
where City LIKE '_a%'

-- find any values that have "@" in any position
select *
from tblPerson
where Email LIKE '%@%'

select *
from tblPerson
where Email NOT LIKE '%@%'

-- najviše jedan znak prije i poslije
select *
from tblPerson
where Email LIKE '_@_.com'

--svi čija imena počinju nekim od ovih slova
select *
from tblPerson
where [Name] LIKE '[RST]%'

-- find values starting with “a”, “b”, or “c”
select *
from tblPerson
where [Name] LIKE '[a-c]%'

--svi čija imena NE počinju nekim ovih slova
select *
from tblPerson
where [Name] LIKE '[^RST]%'

-- svi čije ime završava s rk ili ck
select *
from tblPerson
where [Name] LIKE '%[rc]k'

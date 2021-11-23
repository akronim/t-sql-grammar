use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- parent table
CREATE TABLE Countries
(
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50),
    CountryCode VARCHAR(3)
)

-- child table
CREATE TABLE States
(
    StateID INT PRIMARY KEY,
    StateName VARCHAR(50),
    StateCode VARCHAR(3),
    CountryID INT
)

ALTER TABLE [dbo].[States]  
ADD CONSTRAINT [FK_States_Countries] 
FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO


INSERT INTO Countries
VALUES
    (1, 'United States', 'USA'),
    (2, 'United Kingdom', 'UK')

INSERT INTO States
VALUES
    (1, 'Texas', 'TX', 1),
    (2, 'Arizona', 'AZ', 1)


SELECT *
from Countries
SELECT *
from States


-- Now I deleted a row in the parent table with CountryID =1 which 
-- also deletes the rows in the child table which has CountryID =1
DELETE from Countries WHERE CountryID = 1
SELECT *
from States


SELECT name, delete_referential_action, delete_referential_action_desc,
    update_referential_action, update_referential_action_desc
FROM sys.foreign_keys
where name ='FK_States_Countries'



-- Example 2
use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


CREATE TABLE _Countries
(
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50),
    CountryCode VARCHAR(3)
)
GO


CREATE TABLE _States
(
    StateID INT PRIMARY KEY,
    StateName VARCHAR(50),
    StateCode VARCHAR(3),
    CountryID INT
)
GO


CREATE TABLE _Cities
(
    CityID INT,
    CityName varchar(50),
    StateID INT
)
GO

INSERT INTO _Countries
VALUES
    (1, 'United States', 'USA'),
    (2, 'United Kingdom', 'UK')

INSERT INTO _States
VALUES
    (1, 'Texas', 'TX', 1),
    (2, 'Arizona', 'AZ', 1)

INSERT INTO _Cities
VALUES(1, 'Texas City', 1),
    (1, 'Phoenix', 2)



-- We will create a foreign key now with cascade as delete rule on _States table 
-- which references to CountryID in parent table _Countries
ALTER TABLE [dbo].[_States]  
ADD CONSTRAINT [FK_States_Countries] 
FOREIGN KEY([CountryID])
REFERENCES [dbo].[_Countries] ([CountryID])
ON DELETE CASCADE
GO

-- Now on the _Cities table, create a foreign key without a DELETE CASCADE rule
ALTER TABLE [dbo].[_Cities]  
ADD CONSTRAINT [FK_Cities_States] 
FOREIGN KEY([StateID])
REFERENCES [dbo].[_States] ([StateID])
-- ON DELETE CASCADE
GO

-- If we try to delete a record with CountryID =1, it will throw an error 
-- as delete on parent table _Countries tries to delete the referencing rows 
-- in the child table _States. But on _Cities table, we have a foreign key constraint 
-- with no action for delete and the referenced value still exists in the table.
DELETE FROM _Countries where CountryID =1

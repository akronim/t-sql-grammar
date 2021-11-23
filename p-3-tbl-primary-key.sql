use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


CREATE TABLE Persons
(
    ID int NOT NULL PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);


-- SQL PRIMARY KEY on ALTER TABLE
CREATE TABLE tblPersons
(
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

ALTER TABLE tblPersons
ADD PRIMARY KEY (ID);


-- To allow naming of a PRIMARY KEY constraint
ALTER TABLE tblPersons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);


-- PRIMARY KEY constraint on multiple columns
CREATE TABLE CUSTOMERS
(
    ID INT NOT NULL,
    NAME VARCHAR (20) NOT NULL,
    AGE INT NOT NULL,
    ADDRESS CHAR (25) ,
    SALARY DECIMAL (18, 2),
    PRIMARY KEY (ID, NAME)
);

-- PRIMARY KEY constraint on multiple columns on ALTER TABLE
CREATE TABLE tblCUSTOMERS
(
    ID INT NOT NULL,
    NAME VARCHAR (20) NOT NULL,
    AGE INT NOT NULL,
    ADDRESS CHAR (25) ,
    SALARY DECIMAL (18, 2)
);

ALTER TABLE tblCUSTOMERS 
   ADD CONSTRAINT PK_CUSTID PRIMARY KEY (ID, NAME);


-- Delete Primary Key
ALTER TABLE tblCUSTOMERS
DROP CONSTRAINT PK_CUSTID;
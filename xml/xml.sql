use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO



CREATE TABLE Car
(
    CarId int identity(1,1) primary key,
    Name varchar(100),
    Make varchar(100),
    Model int ,
    Price int ,
    Type varchar(20)
)

insert into Car
    ( Name, Make, Model , Price, Type)
VALUES
    ('Corrolla', 'Toyota', 2015, 20000, 'Sedan'),
    ('Civic', 'Honda', 2018, 25000, 'Sedan'),
    ('Passo', 'Toyota', 2012, 18000, 'Hatchback'),
    ('Land Cruiser', 'Toyota', 2017, 40000, 'SUV'),
    ('Corrolla', 'Toyota', 2011, 17000, 'Sedan'),
    ('Vitz', 'Toyota', 2014, 15000, 'Hatchback'),
    ('Accord', 'Honda', 2018, 28000, 'Sedan'),
    ('7500', 'BMW', 2015, 50000, 'Sedan'),
    ('Parado', 'Toyota', 2011, 25000, 'SUV'),
    ('C200', 'Mercedez', 2010, 26000, 'Sedan'),
    ('Corrolla', 'Toyota', 2014, 19000, 'Sedan'),
    ('Civic', 'Honda', 2015, 20000, 'Sedan')



SELECT *
FROM Car
-- FOR XML AUTO clause converts each column in the SQL table into an attribute 
-- in the corresponding XML document
-- FOR XML AUTO;
-- FOR XML PATH will create an XML document where each record is an element and each column 
-- is a nested element for a particular record
-- FOR XML PATH
-- change parent element name from 'row' to 'Car'
-- FOR XML PATH ('Car')
-- To add a root element: 
-- FOR XML PATH ('Car'), ROOT('Cars')



-- if you want that CarId should be the attribute of the Car element rather than an element
SELECT CarId as [@CarID],
    Name  AS [CarInfo/Name],
    Make [CarInfo/Make],
    Model [CarInfo/Model],
    Price,
    Type
FROM Car
-- FOR XML PATH ('Car'), ROOT('Cars')

-- if we want Name, Make and Model elements to be nested inside another element CarInfo
SELECT CarId as [@CarID],
    [Name]  AS [CarInfo/Name],
    Make [CarInfo/Make],
    Model [CarInfo/Model],
    Price,
    Type
FROM Car
-- FOR XML PATH ('Car'), ROOT('Cars')


-- if you want to convert the elements Name and Make into an attribute of element CarInfo
SELECT CarId as [@CarID],
    Name  AS [CarInfo/@Name],
    Make [CarInfo/@Make],
    Model [CarInfo/Model],
    Price,
    Type
FROM Car
-- FOR XML PATH ('Car'), ROOT('Cars')




-- Creating SQL table using XML attributes
DECLARE @cars xml

SELECT @cars = C
FROM OPENROWSET (BULK 'F:\Tutorials\SQL\SQL\xml\Cars.xml', SINGLE_BLOB) AS Cars(C)

SELECT @cars

DECLARE @hdoc int

EXEC sp_xml_preparedocument @hdoc OUTPUT, @cars
SELECT *
FROM OPENXML (@hdoc, '/Cars/Car/CarInfo' , 1)
WITH(
    Name VARCHAR(100),
    Make VARCHAR(100)
    )


EXEC sp_xml_removedocument @hdoc


-- Creating a SQL table using XML elements
-- DECLARE @cars xml

-- SELECT @cars = C
-- FROM OPENROWSET (BULK 'F:\Tutorials\SQL\SQL\xml\Cars.xml', SINGLE_BLOB) AS Cars(C)

-- SELECT @cars

-- DECLARE @hdoc int

-- EXEC sp_xml_preparedocument @hdoc OUTPUT, @cars
-- SELECT *
-- FROM OPENXML (@hdoc, '/Cars/Car' , 2)
-- WITH(
--     CarInfo INT,
--     Price INT,
--     Type VARCHAR(100)
--     )


-- EXEC sp_xml_removedocument @hdoc                       
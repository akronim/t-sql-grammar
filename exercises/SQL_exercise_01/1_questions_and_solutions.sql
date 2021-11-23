use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


CREATE TABLE Manufacturer
(
  ManufacturerID INTEGER PRIMARY KEY,
  [Name] NVARCHAR(255) NOT NULL
);

CREATE TABLE Product
(
  ProductID INTEGER PRIMARY KEY,
  Name NVARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  ManufacturerID INTEGER NOT NULL,
  FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
)


INSERT INTO Manufacturer
  (ManufacturerID, [Name])
VALUES
  (1, 'Sony'),
  (2, 'Creative Labs'),
  (3, 'Hewlett-Packard'),
  (4, 'Iomega'),
  (5, 'Fujitsu'),
  (6, 'Winchester');

INSERT INTO Product
  (ProductID, [Name], Price, ManufacturerID)
VALUES(1, 'Hard drive', 240, 5),
  (2, 'Memory', 120, 6),
  (3, 'ZIP drive', 150, 4),
  (4, 'Floppy disk', 5, 6),
  (5, 'Monitor', 240, 1),
  (6, 'DVD drive', 180, 2),
  (7, 'CD drive', 90, 2),
  (8, 'Printer', 270, 3),
  (9, 'Toner cartridge', 66, 3),
  (10, 'DVD burner', 180, 2)


-- 1.4 Select all the Products with a Price between $60 and $120.
select *
from Product
where Price between 60 and 120;

select *
from Product
where Price >= 60 and Price <= 120;

-- 1.5 Select the Name and Price in cents (i.e., the Price must be multiplied by 100).
select Name, CAST(Price * 100 as nvarchar) + ' cents'
from Product;

select Name, concat(Price * 100, ' cents')
from Product;

-- 1.6 Compute the average Price of all the Products.
select avg(Price)
from Product;

select sum(Price) / count(Price)
from Product;

-- 1.7 Compute the average Price of all Products with Manufacturer code equal to 2.
select avg(Price)
from Product
where  ManufacturerID = 2;

-- 1.8 Compute the number of Products with a Price larger than or equal to $180.
select count(*)
from Product
where Price>=180;

-- 1.9 Select the Name and Price of all Products with a Price larger than or equal to $180, 
-- and sort first by Price (in descending order), and then by Name (in ascending order).
select Name, Price
from Product
where Price>=180
order by Price desc, [Name] asc;

-- 1.10 Select all the data from the Product, including all the data for each 
-- Product's Manufacturer.
select p.*, m.*
from Product p
  left join Manufacturer m
  on p.ManufacturerID = m.ManufacturerID;

select p.*, m.*
from Product p, Manufacturer m
where m.ManufacturerID = p.ManufacturerID;

-- 1.11 Select the Product Name, Price and Manufacturer Name of all the Products.
select p.Name, p.Price, m.Name
from Product p
  join Manufacturer m
  on p.ManufacturerID = m.ManufacturerID;

SELECT Product.Name, Price, Manufacturer.Name
FROM Product
  INNER JOIN Manufacturer
  ON Product.ManufacturerID = Manufacturer.ManufacturerID;

-- 1.12 Select the average Price of each Manufacturer's Products, 
-- showing only the Manufacturer's code.
SELECT AVG(Price), ManufacturerID
FROM Product
GROUP BY ManufacturerID;


-- 1.13 Select the average Price of each Manufacturer's Products, 
-- showing the Manufacturer's Name.
select CAST(avg(p.Price) as decimal(18,2)), m.Name
from Product p
  join Manufacturer m
  on p.ManufacturerID = m.ManufacturerID
group by m.Name;


-- 1.14 Select the Names of Manufacturers whose Products have an average Price larger 
-- than or equal to $150.
select avg(p.Price), m.Name
from Manufacturer m
  join Product p
  on m.ManufacturerID = p.ManufacturerID
group by m.Name
having avg(p.Price)>=150;

SELECT AVG(Price), Manufacturer.Name
FROM Product, Manufacturer
WHERE Product.ManufacturerID = Manufacturer.ManufacturerID
GROUP BY Manufacturer.Name
HAVING AVG(Price) >= 150;


-- 1.15 Select the Name and Price of the cheapest Product.
select Name, Price
from Product
where Price = (
select min(Price)
from Product);


SELECT TOP 1
  Name, Price
FROM Product
ORDER BY Price ASC


-- 1.16 Select the Name of each Manufacturer along with the Name and Price of 
-- its most expensive Product.
select
  max_Price_mapping.Name as manu_Name,
  max_Price_mapping.Price,
  Products_with_manu_Name.Name as Product_Name
from
  (SELECT Manufacturer.Name, MAX(Price) as Price
  FROM Product, Manufacturer
  WHERE Product.ManufacturerID = Manufacturer.ManufacturerID
  GROUP BY Manufacturer.Name)
     as max_Price_mapping
  left join
  (select Product.*, Manufacturer.Name as manu_Name
  from Product
    join Manufacturer
    on (Product.ManufacturerID = Manufacturer.ManufacturerID))
      as Products_with_manu_Name
  on
  (
    max_Price_mapping.Name = Products_with_manu_Name.manu_Name
    and
    max_Price_mapping.Price = Products_with_manu_Name.Price
  );






-- 1.19 Apply a 10% discount to all Products.
update Product
set Price=Price*0.9;


-- 1.20 Apply a 10% discount to all Products with a Price larger than or equal to $120.
update Product
set Price = Price * 0.9
where Price >= 120; 


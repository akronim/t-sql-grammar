use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

CREATE TABLE Warehouses
(
  Code INTEGER NOT NULL,
  Location VARCHAR(255) NOT NULL ,
  Capacity INTEGER NOT NULL,
  PRIMARY KEY (Code)
);
CREATE TABLE Boxes
(
  Code CHAR(4) NOT NULL,
  Contents VARCHAR(255) NOT NULL ,
  Value REAL NOT NULL ,
  Warehouse INTEGER NOT NULL,
  PRIMARY KEY (Code),
  FOREIGN KEY (Warehouse) REFERENCES Warehouses(Code)
);

INSERT INTO Warehouses
  (Code,Location,Capacity)
VALUES
  (1, 'Chicago', 3),
  (2, 'Chicago', 4),
  (3, 'New York', 7),
  (4, 'Los Angeles', 2),
  (5, 'San Francisco', 8)

INSERT INTO Boxes
  (Code,Contents,Value,Warehouse)
VALUES('0MN7', 'Rocks', 180, 3),
  ('4H8P', 'Rocks', 250, 1),
  ('4RT3', 'Scissors', 190, 4),
  ('7G3H', 'Rocks', 200, 1),
  ('8JN6', 'Papers', 75, 1),
  ('8Y6U', 'Papers', 50, 3),
  ('9J6F', 'Papers', 175, 2),
  ('LL08', 'Rocks', 140, 4),
  ('P0H6', 'Scissors', 125, 1),
  ('P2T6', 'Scissors', 150, 2),
  ('TU55', 'Papers', 90, 5)


--3.3
-- Select all distinct contents in all the boxes.
select distinct contents
from boxes;

--3.4
-- Select the average value of all the boxes.
select avg(value)
from boxes;

--3.5
-- Select the warehouse code and the average value of the boxes in each warehouse.
select warehouse, avg(value)
from boxes
group by warehouse;

SELECT Warehouse, AVG(Value)
FROM Boxes
GROUP BY Warehouse;

--3.6
-- Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
select warehouse, avg(value)
from boxes
group by warehouse
having avg(value)> 150;


--3.7
-- Select the code of each box, along with the name of the city the box is located in.
select boxes.code, warehouses.location
from boxes join warehouses
  on boxes.Warehouse = Warehouses.Code;

SELECT Boxes.Code, Location
FROM Warehouses
  INNER JOIN Boxes ON Warehouses.Code = Boxes.Warehouse;


--3.8
-- Select the warehouse codes, along with the number of boxes in each warehouse. 
-- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
select Warehouse, count(*)
from boxes
group by warehouse;


--3.9
-- Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
select Code
from warehouses join (select warehouse temp_a, count(*) temp_b
  from boxes
  group by warehouse) temp
  on (warehouses.code = temp.temp_a)
where warehouses.Capacity<temp.temp_b;


SELECT Code
FROM Warehouses
WHERE Capacity <
   (
     SELECT COUNT(*)
FROM Boxes
WHERE Warehouse = Warehouses.Code
   );



--3.10
-- Select the codes of all the boxes located in Chicago.

select Boxes.code
from boxes join Warehouses
  on boxes.warehouse = warehouses.code
where warehouses.location = 'Chicago';

/* Without subqueries */
SELECT Boxes.Code
FROM Warehouses LEFT JOIN Boxes
  ON Warehouses.Code = Boxes.Warehouse
WHERE Location = 'Chicago';

/* With a subquery */
SELECT Code
FROM Boxes
WHERE Warehouse IN
   (
     SELECT Code
FROM Warehouses
WHERE Location = 'Chicago'
   );


--3.11
-- Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses
VALUES
  (6, 'New York', 3);


--3.12
-- Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes
VALUES('H5RT', 'Papers', 200, 2);


--3.13
-- Reduce the value of all boxes by 15%.
update boxes
set value = value * 0.85;


--3.14
-- Remove all boxes with a value lower than $100.
delete from boxes 
where value < 100;

-- 3.15
-- Remove all boxes from saturated warehouses.
delete from boxes
where warehouse in
(
SELECT Code
FROM Warehouses
WHERE Capacity <
   (
     SELECT COUNT(*)
FROM Boxes
WHERE Warehouse = Warehouses.Code
   )
);

-- 3.16
-- Add Index for column "Warehouse" in table "boxes"
-- !!!NOTE!!!: index should NOT be used on small tables in practice
CREATE INDEX INDEX_WAREHOUSE ON Boxes (warehouse);

-- 3.17
-- Print all the existing indexes
-- !!!NOTE!!!: index should NOT be used on small tables in practice

SELECT DB_NAME() AS Database_Name
, sc.name AS Schema_Name
, o.name AS Table_Name
, i.name AS Index_Name
, i.type_desc AS Index_Type
FROM sys.indexes i
  INNER JOIN sys.objects o ON i.object_id = o.object_id
  INNER JOIN sys.schemas sc ON o.schema_id = sc.schema_id
WHERE i.name IS NOT NULL
  AND o.type = 'U'
ORDER BY o.name, i.type

-- 3.18
-- Remove (drop) the index you added just
-- !!!NOTE!!!: index should NOT be used on small tables in practice
DROP INDEX INDEX_WAREHOUSE;

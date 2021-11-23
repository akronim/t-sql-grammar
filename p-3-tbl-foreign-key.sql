use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- Create Foreign key - Using CREATE TABLE statement
CREATE TABLE products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(25)
);

CREATE TABLE inventory
(
    inventory_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT,
    min_level INT,
    max_level INT,
    CONSTRAINT fk_inventory_products
    FOREIGN KEY (product_id)
    REFERENCES products (product_id)
);

-- example 2 -- create a foreign key with more than one field
CREATE TABLE tblProducts
(
    product_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    category VARCHAR(25)
        CONSTRAINT products_pk PRIMARY KEY (product_name, location)
);

CREATE TABLE tblInventory
(
    inventory_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    quantity INT,
    min_level INT,
    max_level INT,
    CONSTRAINT fk_tblInventory_tblProducts
    FOREIGN KEY (product_name, location)
    REFERENCES tblProducts (product_name, location)
);
GO

-- Create a foreign key - Using ALTER TABLE statement
drop table products
drop table inventory

CREATE TABLE products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(25)
);

CREATE TABLE inventory
(
    inventory_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT,
    min_level INT,
    max_level INT
);


ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_products
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);
GO

-- create a foreign key with more than one field - Using ALTER TABLE statement
ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_products
    FOREIGN KEY (product_name, location)
    REFERENCES products (product_name, location);
GO

--To DROP a FOREIGN KEY Constraint
ALTER TABLE inventory
DROP CONSTRAINT fk_inventory_products
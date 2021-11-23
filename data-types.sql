use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

SELECT *
FROM sys.types;

SELECT
    name,
    max_length,
    [precision],
    scale,
    is_user_defined
FROM sys.types
order by name asc;






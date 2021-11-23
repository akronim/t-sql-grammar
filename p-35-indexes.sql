use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;

Create table tblEmployee
(
    ID int primary key,
    [Name] nvarchar(50),
    Gender nvarchar(50),
    Salary int,
    City NVARCHAR(50)
)
Go

Insert into tblEmployee
values
    (1, 'Tom', 'Male', 4000, 'London')
,
    (2, 'Pam', 'Female', 3000, 'New York')
,
    (3, 'John', 'Male', 3500, 'London')
,
    (4, 'Sam', 'Male', 4500, 'London')
,
    (5, 'Todd', 'Male', 2800, 'Sydney')
,
    (6, 'Ben', 'Male', 7000, 'New York')
,
    (7, 'Sara', 'Female', 4800, 'Sydney')
,
    (8, 'Valarie', 'Female', 5500, 'New York')
,
    (9, 'James', 'Male', 6500, 'London')
,
    (10, 'Russell', 'Male', 8800, 'London')
Go


Select *
from tblEmployee
where Salary > 5000 and Salary < 7000

-- Create the Index to help the query
-- We are creating an index on Salary column
-- The index stores salary of each employee, in the ascending order
CREATE Index IX_tblEmployee_Salary 
ON tblEmployee (SALARY ASC)

-- SQL server picks up the row addresses from the index and directly fetch the records 
-- from the table, rather than scanning each row in the table.

-- To view the Indexes
Execute sp_helpindex 'dbo.tblEmployee'

-- This query lists all indexes in the database - I
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

-- This query lists all indexes in the database - II
select i.[name] as index_name,
    substring(column_names, 1, len(column_names)-1) as [columns],
    case when i.[type] = 1 then 'Clustered index'
        when i.[type] = 2 then 'Nonclustered unique index'
        when i.[type] = 3 then 'XML index'
        when i.[type] = 4 then 'Spatial index'
        when i.[type] = 5 then 'Clustered columnstore index'
        when i.[type] = 6 then 'Nonclustered columnstore index'
        when i.[type] = 7 then 'Nonclustered hash index'
        end as index_type,
    case when i.is_unique = 1 then 'Unique'
        else 'Not unique' end as [unique],
    schema_name(t.schema_id) + '.' + t.[name] as table_view,
    case when t.[type] = 'U' then 'Table'
        when t.[type] = 'V' then 'View'
        end as [object_type]
from sys.objects t
    inner join sys.indexes i
    on t.object_id = i.object_id
    cross apply (select col.[name] + ', '
    from sys.index_columns ic
        inner join sys.columns col
        on ic.object_id = col.object_id
            and ic.column_id = col.column_id
    where ic.object_id = t.object_id
        and ic.index_id = i.index_id
    order by key_ordinal
    for xml path ('') ) D (column_names)
where t.is_ms_shipped <> 1
    and index_id > 0
order by i.[name]

-- To delete or drop the index
Drop Index tblEmployee.IX_tblEmployee_Salary
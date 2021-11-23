use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


-- Merge statement introduced in SQL Server 2008 allows us to perform 
-- Inserts, Updates and Deletes in one statement. 

-- With merge statement we require 2 tables
-- 1. Source Table - Contains the changes that needs to be applied to the target table
-- 2. Target Table - Contains the changes that needs to be applied to the target table

-- Merge statement syntax
-- MERGE [TARGET] AS T
-- USING [SOURCE] AS S
--    ON [JOIN_CONDITIONS]
--  WHEN MATCHED THEN 
--       [UPDATE STATEMENT]
--  WHEN NOT MATCHED BY TARGET THEN
--       [INSERT STATEMENT] 
--  WHEN NOT MATCHED BY SOURCE THEN
--       [DELETE STATEMENT]


IF OBJECT_ID('dbo.StudentSource', 'U') IS NOT NULL 
  DROP TABLE dbo.StudentSource;


Create table StudentSource
(
    ID int primary key,
    Name nvarchar(20)
)
GO

Insert into StudentSource
values
    (1, 'Mike'),
    (2, 'Sara')
GO


IF OBJECT_ID('dbo.StudentTarget', 'U') IS NOT NULL 
  DROP TABLE dbo.StudentTarget;

Create table StudentTarget
(
    ID int primary key,
    Name nvarchar(20)
)
GO

Insert into StudentTarget
values
    (1, 'Mike M'),
    (3, 'John')
GO


MERGE StudentTarget AS T
USING StudentSource AS S
ON T.ID = S.ID
-- When matching rows are found, StudentTarget table is UPDATED
WHEN MATCHED THEN
     UPDATE SET T.NAME = S.NAME
-- When the rows are present in Source table but not in Target table,
-- those rows are INSERTED into Target table
WHEN NOT MATCHED BY TARGET THEN
     INSERT (ID, NAME) VALUES(S.ID, S.NAME)
-- When the rows are present in Target table but not in Source table,
-- those rows are DELETED from Target table
WHEN NOT MATCHED BY SOURCE THEN
     DELETE;


-- Example 2
-- only INSERT and UPDATE is performed
Truncate table StudentSource
Truncate table StudentTarget
GO

Insert into StudentSource
values
    (1, 'Mike'),
    (2, 'Sara')
GO

Insert into StudentTarget
values
    (1, 'Mike M'),
    (3, 'John')
GO

MERGE StudentTarget AS T
USING StudentSource AS S
ON T.ID = S.ID
WHEN MATCHED THEN
     UPDATE SET T.NAME = S.NAME
WHEN NOT MATCHED BY TARGET THEN
     INSERT (ID, NAME) VALUES(S.ID, S.NAME);







use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

If not exists (select *
from information_schema.tables
where table_name = 'tblEmployee')
Begin
    Create table tblEmployee
    (
        ID int identity primary key,
        Name nvarchar(100),
        Gender nvarchar(10),
        DateOfBirth DateTime
    )
    Print 'Table tblEmployee successfully created'
End
Else
Begin
    Print 'Table tblEmployee already exists'
End
GO


-- using OBJECT_ID()
IF OBJECT_ID('tblEmployee') IS NULL
Begin
    -- Create Table Script
    Print 'Table tblEmployee created'
End
Else
Begin
    Print 'Table tblEmployee already exists'
End
GO


-- drop (if exists) and re-create it
IF OBJECT_ID('tblEmployee') IS NOT NULL
Begin
    Drop Table tblEmployee
End
Create table tblEmployee
(
    ID int identity primary key,
    Name nvarchar(100),
    Gender nvarchar(10),
    DateOfBirth DateTime
)
GO



-- check for the column existence
if not exists(Select *
from INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME='EmailAddress' and TABLE_NAME = 'tblEmployee' and TABLE_SCHEMA='dbo') 
Begin
    ALTER TABLE tblEmployee
ADD EmailAddress nvarchar(50)
End
Else
BEgin
    Print 'Column EmailAddress already exists'
End
GO


-- Col_length() function can also be used to check for the existence of a column
If col_length('tblEmployee','EmailAddress') is not null
Begin
    Print 'Column already exists'
End
Else
Begin
    Print 'Column does not exist'
End


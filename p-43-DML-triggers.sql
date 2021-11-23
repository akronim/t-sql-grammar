use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- In SQL Server there are 4 types of triggers 
-- 1. DML Triggers - Data Manipulation Language. 
-- 2. DDL Triggers - Data Definition Language
-- 3. CLR triggers - Common Language Runtime
-- 4. Logon triggers

-- DML stands for Data Manipulation Language. 
-- INSERT, UPDATE, and DELETE statements are DML statements. 
-- DML triggers are fired, when ever data is modified using INSERT, UPDATE, and DELETE events.


-- DML triggers can be again classified into 2 types.
-- 1. AFTER triggers (Sometimes called as FOR triggers)
-- 2. INSTEAD OF triggers

-- Triggers make use of 2 special tables, INSERTED and DELETED. 
-- The inserted table contains the updated data and the deleted table contains the old data.

IF OBJECT_ID('dbo.tblEmployee', 'U') IS NOT NULL 
  DROP TABLE dbo.tblEmployee;


CREATE TABLE tblEmployee
(
    Id int Primary Key,
    Name nvarchar(30),
    Salary int,
    Gender nvarchar(10),
    DepartmentId int
)

Insert into tblEmployee
values
    (1, 'John', 5000, 'Male', 3),
    (2, 'Mike', 3400, 'Male', 2),
    (3, 'Pam', 6000, 'Female', 1)
GO


-- SQL Script to create tblEmployeeAudit table:
CREATE TABLE tblEmployeeAudit
(
    Id int identity(1,1) primary key,
    AuditData nvarchar(1000)
)
GO

-- AFTER TRIGGER for INSERT event on tblEmployee table:
-- INSERTED table, is a special table used by DML triggers and only a trigger can access it
CREATE TRIGGER tr_tblEMployee_ForInsert
ON tblEmployee
FOR INSERT
AS
BEGIN
    Declare @Id int
    Select @Id = Id
    from inserted

    insert into tblEmployeeAudit
    values('New employee with Id  = ' + Cast(@Id as nvarchar(5)) + ' is added at ' + cast(Getdate() as nvarchar(20)))
END
GO


Insert into tblEmployee
values
    (7, 'Tan', 2300, 'Female', 3)
GO

SELECT *
FROM tblEmployeeAudit;
GO

-- AFTER TRIGGER for DELETE event on tblEmployee table
-- DELETED table is a special table used by DML triggers
CREATE TRIGGER tr_tblEMployee_ForDelete
ON tblEmployee
FOR DELETE
AS
BEGIN
    Declare @Id int
    Select @Id = Id
    from deleted

    insert into tblEmployeeAudit
    values('An existing employee with Id  = ' + Cast(@Id as nvarchar(5)) + ' is deleted at ' + Cast(Getdate() as nvarchar(20)))
END
GO

DELETE FROM tblEmployee where Id = 7
GO


SELECT *
FROM tblEmployeeAudit;
GO






















use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

IF OBJECT_ID('dbo.tblUser', 'U') IS NOT NULL DROP TABLE dbo.tblUser;
Create table tblUser
(
    ID int primary key,
    [Name] nvarchar(50),
    Email NVARCHAR(50),
    [Password] NVARCHAR(50)
) 
Go

Insert into tblUser
values
    (1, 'Tom', 'tom@tom.com', '1234') ,
    (2, 'Pam', 'pam@pam.com', '2345') ,
    (3, 'John', 'john@john.com', '3456')  
Go

Create TABLE tblItems
(
    Id int,
    Name nvarchar(50)
) 
GO

insert into tblItems
VALUES
    (1, 'ABC'),
    (2, 'BCD') 
GO

select *
from tblUser
where Email = 'tom@tom.com' and [Password] = '1234' 
GO



-- sql injection
select *
from tblUser
where Email = 'xxx@xxx.xxx' OR 1 = 1 and [Password] = '1111' OR 1 = 1
GO

select *
from tblUser
where Email = '   ' OR 1 = 1 OR 1 = '   ' and [Password] = '   ' OR 1 = 1 OR 1='   '
GO

select *
from tblUser
where Email = '   ' OR '1' = '1   ' and [Password] = '   ' OR '1' = '1   '
SELECT *
From tblItems -- 
GO






----PRIMJER ZA PREVENCIJU SQL INJECTION-A
create proc spLogirajSe
    (@Email nvarchar(50))
as
begin
    PRINT(@Email)

    declare @sqlcmd nvarchar(MAX);
    declare @param1 nvarchar(MAX);


    set @sqlcmd = 'select * from tblUser where Email = @Email';
    set @param1 = '@Email nvarchar(50)';

    EXECUTE sp_executesql @sqlcmd, @param1, @Email;
end
GO

exec spLogirajSe @Email = 'tom@tom.com';
GO




alter proc spLogirajSe
    @Email nvarchar(50),
    @Password nvarchar(50)
as
begin
    PRINT(@Email)
    PRINT(@Password)

    declare @sqlcmd nvarchar(MAX);

    set @sqlcmd = 'select * from tblUser where Email = @Email and Password = @Password';

    EXECUTE sp_executesql @sqlcmd, N'@Email nvarchar(50), @Password nvarchar(50)', @Email,  @Password;
end
GO

exec spLogirajSe @Email = 'tom@tom.com', @Password ='1234';
GO


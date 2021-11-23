use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO

-- a deadlock occurs when two or more processes have a resource locked, 
-- and each process requests a lock on the resource that another process has already locked.
-- Neither of the transactions here can move forward, as each one is waiting 
-- for the other to release the lock.



Create table TableA
(
    Id int identity primary key,
    Name nvarchar(50)
)
Go

Insert into TableA
values
    ('Mark')
Go

Create table TableB
(
    Id int identity primary key,
    Name nvarchar(50)
)
Go

Insert into TableB
values
    ('Mary')
Go



-- Open 2 instances of SQL Server Management studio. 
-- From the first window execute Transaction 1 code and from the second window 
-- execute Transaction 2 code.

-- Transaction 1
Begin Tran
Update TableA Set Name = 'Mark Transaction 1' where Id = 1

-- From Transaction 2 window execute the first update statement

Update TableB Set Name = 'Mary Transaction 1' where Id = 1

-- From Transaction 2 window execute the second update statement
Commit Transaction



-- Transaction 2
Begin Tran
Update TableB Set Name = 'Mark Transaction 2' where Id = 1

-- From Transaction 1 window execute the second update statement

Update TableA Set Name = 'Mary Transaction 2' where Id = 1

-- After a few seconds notice that one of the transactions complete 
-- successfully while the other transaction is made the deadlock victim

Commit Transaction
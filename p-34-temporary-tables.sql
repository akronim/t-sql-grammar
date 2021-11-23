use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- Local Temporary tables and Global Temporary tables


-- Local Temporary Table
Create Table #PersonDetails
(
    Id int,
    Name nvarchar(20)
)

-- Insert Data into the temporary table:
Insert into #PersonDetails
Values(1, 'Mike')
Insert into #PersonDetails
Values(2, 'John')
Insert into #PersonDetails
Values(3, 'Todd')

-- Select the data from the temporary table:
Select *
from #PersonDetails

-- Temporary tables are created in the TEMPDB
Select name
from tempdb..sysobjects
where name like '#PersonDetails%'
GO

-- to explicitly drop the temporary table
DROP TABLE #PersonDetails
GO


-- temp table inside a stored procedure
Create Procedure spCreateLocalTempTable
as
Begin
    Create Table #PersonDetails
    (
        Id int,
        Name nvarchar(20)
    )

    Insert into #PersonDetails
    Values(1, 'Mike')
    Insert into #PersonDetails
    Values(2, 'John')
    Insert into #PersonDetails
    Values(3, 'Todd')

    Select *
    from #PersonDetails
End
GO

Exec spCreateLocalTempTable
GO



-- Global Temporary Table
-- visible to all the connections of the sql server, and are only destroyed when 
-- the last connection referencing the table is closed
Create Table ##EmployeeDetails
(
    Id int,
    Name nvarchar(20)
)



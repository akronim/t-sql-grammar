-- To Create the database using a query
create database DatabaseName

-- Rename a Database
Alter database DatabaseName Modify Name = NewDatabaseName ;

-- Rename a Database II
Execute sp_renameDB 'OldDatabaseName','NewDatabaseName'

-- To Delete or Drop a database
Drop Database DatabaseThatYouWantToDrop
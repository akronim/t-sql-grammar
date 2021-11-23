use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO



CREATE TABLE [Group]
(
    GroupID INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(50),
    ParentID INT
)

CREATE TABLE [Content]
(
    ContentID INT PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(50)
)

CREATE TABLE [GroupContent]
(
    GroupContentID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    GroupID INT NOT NULL,
    ContentID INT NOT NULL
)



INSERT INTO [Group]
VALUES
    (1, 'Sve', NULL),
    (2, 'Prvi dan', 1),
    (3, 'Prvi dan prije podne', 2),
    (4, 'Prvi dan poslije podne', 2),
    (5, 'Drugi dan', 1),
    (6, 'Drugi dan prije podne', 5),
    (7, 'Drugi dan poslije podne', 5)

INSERT INTO [Content]
VALUES
    (11, 'Predavanje 1'),
    (12, 'Predavanje 2'),
    (13, 'Predavanje 3'),
    (14, 'Predavanje 4'),
    (15, 'Predavanje 5'),
    (16, 'Predavanje 6'),
    (17, 'Predavanje 7'),
    (18, 'Predavanje 8'),
    (19, 'Pauza 1'),
    (20, 'Pauza 2'),
    (21, 'Pauza 3'),
    (22, 'Pauza 4'),
    (23, 'Ručak 1'),
    (24, 'Ručak 2')

INSERT INTO [GroupContent]
VALUES
    (3, 11),
    (3, 19),
    (3, 12),
    (3, 23),

    (4, 13),
    (4, 20),
    (4, 14),
    (4, 23),


    (6, 15),
    (6, 21),
    (6, 16),
    (6, 24),

    (7, 17),
    (7, 22),
    (7, 18),
    (7, 24)

SELECT G.Name as [Group], C.Name as Content
from [GroupContent] GC
    JOIN [Group] G on G.GroupID = GC.GroupID
    JOIN [Content] C on GC.ContentID = C.ContentID

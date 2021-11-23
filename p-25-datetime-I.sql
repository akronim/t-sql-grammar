use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

CREATE TABLE [tblDateTime]
(
    [c_time] [time](7) NULL,
    [c_date] [date] NULL,
    [c_smalldatetime] [smalldatetime] NULL,
    [c_datetime] [datetime] NULL,
    [c_datetime2] [datetime2](7) NULL,
    [c_datetimeoffset] [datetimeoffset](7) NULL
)

INSERT INTO tblDateTime
VALUES
    (GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE())

SELECT *
FROM tblDateTime

-- Commonly used function
PRINT GETDATE()
-- ANSI SQL equivalent to GETDATE
PRINT CURRENT_TIMESTAMP
-- More fractional seconds precision
PRINT SYSDATETIME()
-- More fractional seconds precision + Time zone offset
PRINT SYSDATETIMEOFFSET()
-- UTC Date and Time
PRINT GETUTCDATE()
-- UTC Date and Time, with More fractional seconds precision
PRINT SYSUTCDATETIME()
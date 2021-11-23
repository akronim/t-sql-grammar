use master
GO

DROP DATABASE IF EXISTS TestDB
GO

create database TestDB
GO

use TestDB
GO


DROP TABLE IF EXISTS t1;
CREATE TABLE t1
(
    id INT IDENTITY(1, 1),
    a INT,
    b INT,
    PRIMARY KEY(id)
);


INSERT INTO
    t1
    (a,b)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2);

-- duplicates:
-- (1,2)
-- (2,1)
-- (1,3)


-- Using GROUP BY
SELECT
    a,
    b,
    COUNT(*) occurrences
FROM t1
GROUP BY
    a, 
    b
HAVING 
    COUNT(*) > 1;


-- Using ROW_NUMBER() function
WITH
    cte
    AS
    (
        SELECT
            a,
            b,
            ROW_NUMBER() OVER (
            PARTITION BY a,b
            ORDER BY a,b) rownum
        FROM
            t1
    )
SELECT
    *
FROM
    cte
WHERE 
    rownum > 1;



-- Delete duplicate rows from a table
WITH
    cte
    AS
    (
        SELECT
            a,
            b,
            ROW_NUMBER() OVER (
            PARTITION BY a,b
            ORDER BY a,b) rownum
        FROM
            t1
    )
DELETE FROM cte
WHERE rownum > 1;

-- provjera:
WITH
    cte
    AS
    (
        SELECT
            a,
            b,
            ROW_NUMBER() OVER (
            PARTITION BY a,b
            ORDER BY a,b) rownum
        FROM
            t1
    )
SELECT
    *
FROM
    cte
WHERE 
    rownum > 1;
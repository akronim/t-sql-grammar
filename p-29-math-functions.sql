use master 
GO

DROP DATABASE IF EXISTS TestDB 
GO

create database TestDB 
GO

use TestDB 
GO

-- ABS ( numeric_expression ) - returns the absolute (positive) number
Select ABS(-101.5)


Select CEILING(15.2)
Select CEILING(-15.2)

Select FLOOR(15.2)
Select FLOOR(-15.2)

-- Power(expression, power) - Returns the power value
-- '2 TO THE POWER OF 3' = 2*2*2 = 8
Select POWER(2,3)

-- RAND([Seed_Value]) - Returns a random float number between 0 and 1
-- Always returns the same value
Select RAND(1)

-- generate a random number between 0 and 100
Select FLOOR(RAND() * 100)

-- The following query prints 10 random numbers between 1 and 100.
Declare @Counter INT
Set @Counter = 1
While(@Counter <= 10)
Begin
    Print FLOOR(RAND() * 100)
    Set @Counter = @Counter + 1
End

-- SQUARE ( Number ) - Returns the square of the given number
Select SQUARE(9)

-- SQRT ( Number ) - SQRT stands for Square Root.
Select SQRT(81)

-- ROUND ( numeric_expression , length [ ,function ] )
-- Round to 2 places after (to the right) the decimal point
Select ROUND(850.556, 2)
-- Truncate anything after 2 places, after (to the right) the decimal point
Select ROUND(850.556, 2, 1)
-- Round to 1 place after (to the right) the decimal point
Select ROUND(850.556, 1)
-- Truncate anything after 1 place, after (to the right) the decimal point
Select ROUND(850.556, 1, 1)
-- Round the last 2 places before (to the left) the decimal point
Select ROUND(850.556, -2)
-- Round the last 1 place before (to the left) the decimal point
Select ROUND(850.556, -1)


-- SIGN - vraća predznak broja (-1, 0 ili 1)
PRINT(SIGN(-3.23))


--ispisuje slučajne brojeve između 1 i 5
declare @LL int
set @LL =1;
declare @UL int
set @UL = 5
declare @Rand int
while (1=1)
	begin
    select @Rand = round( ((@UL-@LL)*RAND()+1),0)
    print @Rand

    if (@Rand <1 or @Rand > =5)
			begin
        Print 'Error - ' + cast(@Rand as nvarchar(4))
        break
    end
end
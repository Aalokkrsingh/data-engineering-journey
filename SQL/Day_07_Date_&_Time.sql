-- DATE & TIME FUNCTION 
-- PART EXTRACTION
SELECT 
	OrderID,
	CreationTime,
	YEAR(CreationTime) AS YEAR,
	MONTH(CreationTime) AS MONTH,
	DAY(CreationTime) AS DAY
FROM Sales.Orders

-- DATEPART() To get more information from the date and time
SELECT 
	OrderID,
	CreationTime,
-- DATENAME() To get the date name value will be in str 
	DATENAME(MONTH, CreationTime) AS MONTH_NM,
	DATENAME(WEEKDAY, CreationTime) AS WEEK_NM,

-- DATEPART EXAMPLES
	DATEPART(YEAR, CreationTime) AS YEAR,
	DATEPART(MONTH, CreationTime) AS MONTH,
	DATEPART(DAY, CreationTime) AS DAY,
	DATEPART(HOUR, CreationTime) AS HOUR_DP,
	DATEPART(QUARTER, CreationTime) AS QUARTER_DP,
	DATEPART(WEEK, CreationTime) AS WEEK_DP
FROM Sales.Orders;

-- DATETRUNC() Used to reset the value 
SELECT 
	OrderID,
	CreationTime,
	DATETRUNC(MINUTE, CreationTime) AS DT_MIN,
	DATETRUNC(HOUR, CreationTime) AS DT_HOUR,
	DATETRUNC(DAY, CreationTime) AS DT_DAY,
	DATETRUNC(MONTH, CreationTime) AS DT_MONTH,
	DATETRUNC(YEAR, CreationTime) AS DT_YEAR
FROM Sales.Orders;

-- EOMONTH() Return the last date of the month 
SELECT 
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) AS End_Of_Month
FROM Sales.Orders

-- Count the total no of order in a year
SELECT 
*
FROM Sales.Orders;


SELECT 
	YEAR(OrderDate),
	COUNT(*) No_of_Orders
FROM Sales.Orders
GROUP BY YEAR(orderDate)

-- Show the order placed in february
SELECT 
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2 
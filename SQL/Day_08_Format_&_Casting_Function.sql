USE salesDB
-- FORMAT() It use to format the style of our date and time 
SELECT 
	OrderID,
	FORMAT(CreationTime, 'dd') dd,
	FORMAT(CreationTime, 'ddd') ddd,
	FORMAT(CreationTime, 'dddd') dddd
FROM Sales.Orders


SELECT 
	OrderID,
	CreationTime,
FORMAT(CreationTime,'dd') Day,
FORMAT(CreationTime,'ddd') DayName,
FORMAT(CreationTime,'MMM') MonthName,
FORMAT(CreationTime,'') Quarter,
FORMAT(CreationTime,'yyyy') Year,
FORMAT(CreationTime,'HH:mm:ss PM') TimeStamp
FROM Sales.Orders

-- CONVERT 
SELECT 
CONVERT(INT, '123') [String to INT],
CreationTime,
CONVERT(DATE, CreationTime) AS [DATETIME TO DATE],
CONVERT(VARCHAR, OrderID) AS [ID TO VARCHAR]
FROM Sales.Orders

-- CAST Change the datatype 
SELECT 
CAST('123' AS INT) AS [STRING TO INT],
CAST('2025-02-28' AS DATE) AS [STRING TO DATE],
CAST('2025-02-28' AS DATETIME2) AS [STRING TO DATETIME],
CAST(CreationTime AS DATE) AS [CreationTime to Date]
FROM Sales.Orders

-- DATEADD() Increase the date value 
SELECT 
	OrderID,
	OrderDate,
	DATEADD(YEAR, 2, OrderDate) New_Date_Year,
	DATEADD(MONTH, -2, OrderDate) New_Date_Month,
	DATEADD(DAY, 5, OrderDate) New_Date_Day
FROM Sales.Orders

-- DATEDIFF() Use to find the difference between two dates
SELECT 
	OrderID,
	OrderDate,
	ShipDate,
	DATEDIFF(Day, OrderDate, ShipDate) Time_Duration
FROM Sales.orders

SELECT 
	CONCAT(FirstName,' ', LastName) AS Employee_Name, 
	BirthDate,
	DATEDIFF(YEAR, BirthDate, GETDATE())AS Age
FROM Sales.Employees

SELECT 
	MONTH(OrderDate)
	ShipDate,
	AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AS Avg_Duration
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

-- Time Gap Analysis 
SELECT
	OrderID,
	OrderDate Current_Order_Date,
	LAG(OrderDate) OVER (Order BY OrderDate) AS Previous_Order_Date,
	DATEDIFF(DAY, LAG(OrderDate) OVER (Order BY OrderDate), OrderDate) AS Days_Difference
FROM Sales.Orders

-- ISDATE() Check the value is date or not 
SELECT
	ISDATE('2025-12-20'),
	ISDATE(12)

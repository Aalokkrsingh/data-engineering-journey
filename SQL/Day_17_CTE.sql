-- CTE (Common Table Expression) :- Temporary, named set (Virtual Table) that can be use multiple times within your query to simplify and organize the complex query.
-- CTE Types - None-Recursive CTE (Its only executed once without any repetion) :- (Standalone) and (Nested CTE)
-- Standalone CTE :- Defined and Used Independently. Runs Independently as it's self-contained and doesn't rely on other CTE's
-- ORDER BY Clause can't be used inside CTE 
-- Standalone Multiple CTE

 
-- Step:1 Find the total sales per customer  (Standalone CTE)
WITH CTE_TotalSales AS -- Virtual query only exist in our query 
(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders 
GROUP BY CustomerID
)
-- Step: 2 Find the last order date of each customer (Standalone CTE)
, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) AS LastOrder
FROM Sales.Orders
GROUP BY CustomerID
)
-- Step:3 Rank the customer based on their total sales (Nested CTE: CTE inside CTE, can't be run independently)
,CTE_Rank_Customer AS
(
SELECT	
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_TotalSales
)
-- Step:4 Sengment the customer on the behalf of their total sales 
, CTE_CustomerSegment AS
(
SELECT 
	CustomerID,
	TotalSales,
CASE WHEN TotalSales > 100 THEN 'High'
	 WHEN TotalSales > 80 THEN 'Medium'
	 ELSE 'Low'
END AS CustomerSegment
FROM CTE_TotalSales
)
-- Main Query 
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	cts.TotalSales,
	clo.LastOrder,
	crc.CustomerRank,
	ccs.CustomerSegment
FROM Sales.Customers AS C 
LEFT JOIN CTE_TotalSales AS cts
ON cts.CustomerID = C.CustomerID 
LEFT JOIN CTE_Last_Order AS clo
ON clo.CustomerID = C.CustomerID
LEFT JOIN CTE_Rank_Customer AS crc
ON crc.CustomerID = C.CustomerID
LEFT JOIN CTE_CustomerSegment AS ccs
ON ccs.CustomerID = C.CustomerID;

-- Recursive CTE 
-- Generate a sequence of number of 1 to 20 
WITH CTE_Mynumber AS
	-- Anchor Query
	(
	SELECT 
	1 AS Mynumber
	UNION ALL
	-- Recursive Query 
	SELECT 
	Mynumber + 1 
	FROM CTE_Mynumber
	WHERE Mynumber < 20
)
SELECT * FROM CTE_Mynumber
 
 
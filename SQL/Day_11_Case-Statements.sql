USE SalesDB
-- CASE STATEMENTS - Use for categorization of Data means grouping the data into different categories or groups based on certain conditions. (Data Transformation)
-- RULE - The output data type should be same for ex- 'High', 'Medium', 'Low'
-- Use in for mapping the value for ex - M to Male
SELECT
Category,
SUM(Sales) AS TotalSales
FROM(
SELECT
	OrderID,
	Sales,
CASE 
	WHEN Sales > 50 THEN 'High'
	WHEN Sales > 20 AND Sales < 50 THEN 'Medium'
	ELSE 'Low'
END Category
FROM Sales.Orders
)t
GROUP BY Category 
ORDER BY TotalSales DESC;

-- Making the coutry name abbreviation
SELECT DISTINCT Country 
FROM Sales.Customers;

SELECT 
	CustomerID,
	Country,
	CASE 
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA' THEN 'US'
		ELSE 'Unknown'
	END CountryAbrr,

	CASE Country
		WHEN 'Germany' THEN 'DE'
		WHEN  'USA' THEN 'US'
		ELSE 'Unknown'
	END CountryAbrr2
FROM Sales.Customers

SELECT 
	CustomerID,
	CONCAT(FirstName,' ', LastName) FullName,
	AVG(Score) OVER()CAvgScore,
	CASE
		WHEN Score IS NULL THEN 0

	END 
FROM Sales.Customers


-- Count each customer how many times they order and sales greater than 30
SELECT 
	CustomerID,
	SUM(CASE
		WHEN Sales > 30 THEN 1
	ELSE 0
	END) TotalOrdersHighSales,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

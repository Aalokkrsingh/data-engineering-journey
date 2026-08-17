USE SalesDB
-- Find total no of sales acorss all orders
SELECT
	SUM(Sales) Total_Sale
FROM Sales.Orders


-- Find the total sale for each product Resut Granuality is depend upon the no of dimension (productID)
SELECT
	ProductID,
	SUM(Sales) Total_Sale
FROM Sales.Orders
GROUP BY ProductID 

-- Find the total sale for each product Additionally provide detail such OrderID, OrderDate.
-- GROUP BY: can't do aggregation and provide the details at the same time. 
-- Window Function - 1. Not compress the rows it provide all the values for each no rows as result.
-- 2. First define the function like agregation function, rank or Value function 
-- OVER clause it tells the sql that this is a window function and it can be used to define window or subset of data.
-- PARTITION BY is used to divide the result set into partitions (window)

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(),
	SUM(Sales) OVER(PARTITION BY ProductID) AS SalesByProductID,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS SalesByProductIDStatus
FROM Sales.Orders

SELECT 
	ProductID,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales 
FROM Sales.Orders

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate)
	FROM Sales.Orders

	SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
	FROM Sales.Orders

-- WINDOW FUNCTION RULES: 
-- 1. Window function can be used with only SELECT AND ORDER BY Clause.
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus)
	FROM Sales.Orders
	ORDER BY SUM(Sales) OVER(PARTITION BY OrderStatus) DESC

-- Nesting is not allowed in window function cannot use window function inside window function.
-- SQL executes window function after the where clause 
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	ProductID,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate) TotalSales
	FROM Sales.Orders
	WHERE ProductID IN (101, 102)

-- Window function can be used inside the same query with GROUP BY only if the same columns are used 
-- Rank customers based on the total sales 
SELECT 
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomer
FROM Sales.Orders
GROUP BY CustomerID

-- SQL AGGREGATE WINDOW FUNCTION: It generates a single value by summarizing the data 
-- COUNT(*)/COUNT(1) - It will count all the rows inside our data and also incldes the NULL values.
-- COUNT(Sales): It is more specific and it ignores the NULLs
-- It allow any Datatype 

-- Find the total no of orders 
-- With additional info like order id and order date
-- For each customer 
USE SalesDB
SELECT 
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(OrderID) OVER() TotalOrders,
	COUNT(OrderID) OVER(PARTITION BY CustomerID) OrdersByCustomer
FROM Sales.Orders

-- Find the total no of customers 
-- Additional provide all the cusotmer's details 
-- Find the total no of Scores customers 

SELECT 
	*,
	COUNT(*) OVER() TotalCustomers,
	COUNT(Score) OVER() TotalScore
FROM Sales.Customers

-- Check wether the table order contain dulicate rows or not 
-- First you have to check theh primary key inside the table 
SELECT
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM Sales.Orders

SELECT
*
FROM (
	SELECT 
		OrderID,
		COUNT(*) OVER(PARTITION BY OrderID) CheckPK
	FROM Sales.OrdersArchive 
)t WHERE CheckPk > 1 

-- Find the total sales accros all Orders and the total sales for each product 
SELECT
	OrderID,
	OrderDate,
	SUM(Sales) OVER()TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) ProductSales
FROM Sales.Orders

-- Find the percentage contribution of each product's sales to the total sales 
-- PART TO WHOLE ANALYSIS where we show the contribution of each data point to overall dataset  
SELECT 
	OrderID,
	OrderDate,
	Sales,
	SUM(Sales) OVER() TotalSales,
	ROUND(CAST(Sales AS FLOAT)/ SUM(Sales) OVER() * 100, 2) PercentageOfTotal
FROM Sales.Orders

-- Find avg sales across all orders
-- Find the avg sales for each product 
-- Additionaly details like orderid and order date
SELECT
	OrderID,
	OrderDate,
	Sales,
	AVG(SALES) OVER() AvgSales,
	ProductID,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgProduct
FROM Sales.Orders

-- Find the avg score of customer 
-- Additionaly details like customer id and Lastname
SELECT 
	CustomerID,
	LastName,
	Score,
	COALESCE(Score, 0) CustomerScore,
	AVG(Score) OVER() AvgScore,
	AVG(COALESCE(Score, 0)) OVER() CleanAvgScore
FROM Sales.Customers

-- Find all orders where sales are higher than the average sales across all orders 
-- (You can't use WHERE Clause directly in window function instead using subquery)
SELECT
*
FROM(
SELECT 
	OrderID,
	OrderDate,
	Sales,
	AVG(Sales) OVER() AvgSales
FROM Sales.Orders
)t WHERE Sales > AvgSales

/* Find the highest and lowest sales across all orders 
and the highest and lowest sales for each product 
also provide details such as orderID, and order date.
*/

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	MAX(Sales) OVER() HighestSales,
	MIN(Sales) OVER() LowestSales,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSalesByProduct,
	MIN(Sales) OVER(PARTITION  BY ProductID) HighestSalesByProduct
FROM Sales.Orders

-- Show the employees who has the highest salaries
SELECT 
*
FROM (
	SELECT 
	*,
	MAX(Salary) OVER() HighestSalary
	FROM Sales.Employees
)t WHERE Salary = HighestSalary

-- Find the deviation of each sales from the min and max sales amount 
SELECT 
	MAX(Sales) OVER() HighestSales,
	MIN(Sales) OVER() LowestSales,
	MAX(Sales) OVER() - Sales DeviationFromMax,
	Sales - MIN(Sales) OVER() DeviationFromMin
FROM Sales.Orders

-- Running function And Rolling Function 

-- Calculate the moving average of sales for each product over time 
-- Calculate the moving average of sales for each product over time, including only the next order 
SELECT 
	OrderDate,
	OrderID, 
	Sales,
	ProductID, 
	AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderID) AvgOverTime,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderID ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders


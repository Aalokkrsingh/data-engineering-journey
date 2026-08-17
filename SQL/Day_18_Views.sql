-- VIEWS - It is a virtual table based on result of query without storing data
-- It is used to avoid redundancy means agaian and again using CTE.
-- It is used to hide the complexity of a query. 
-- It is use for Security - If you don't want to share sensitive data. 
-- It provides more flexibility and Dynamic (if you are changing the name in main table so it will cause problem for the other user so you provide them a view)
-- You can present your table in multiple languages by using view.
-- Imp usecase - Making DataMart 
-- 
-- Find the runnning total of sales for each month 
WITH CTE_Total_Sales AS
(
SELECT 
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(month, OrderDate) AS MonthName,
	SUM(Sales) AS TotalSales,
	COUNT(OrderID) AS TotalOrders,
	SUM(Quantity) AS TotalQuantities
FROM Sales.Orders
GROUP BY 
	MONTH(OrderDate),
	DATENAME(month, OrderDate)
)

SELECT 
	OrderMonth,
	TotalSales,
	SUM(TotalSales) OVER(ORDER BY OrderMonth) TotalRunningSales
FROM CTE_Total_Sales

/* Create Views
CREATE VIEW Sales.VIEW_TOTAL_SALES_SUMMARY AS 
(
SELECT 
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(month, OrderDate) AS MonthName,
	SUM(Sales) AS TotalSales,
	COUNT(OrderID) AS TotalOrders,
	SUM(Quantity) AS TotalQuantities
FROM Sales.Orders
GROUP BY 
	MONTH(OrderDate),
	DATENAME(month, OrderDate)
)
*/

-- TASK: Provide view that combines details from Orders, Customers, Products, and Employees
/*
CREATE VIEW Sales.V_Order_Details AS
(
	SELECT
	O.OrderID,
	O.OrderDate,
	P.Product,
	P.Category, 
	P.Price,
	O.Sales,
	O.Quantity,
	COALESCE(C.FirstName, '')+ ' ' + COALESCE(C.LastName, '') AS CustomersName,
	C.Country CustomerCountry,
	COALESCE(E.FirstName, '')  + ' ' + COALESCE(E.LastName, '') EmployeeName,
	E.Department,
	E.Salary
	FROM Sales.Orders AS O
	LEFT JOIN Sales.Products AS P
	ON O.ProductID = P.ProductID
	LEFT JOIN Sales.Customers AS C
	ON O.CustomerID = C.CustomerID
	LEFT JOIN Sales.Employees AS E
	ON O.SalesPersonID = E.EmployeeID
)
*/

/*
-- Provide a view for EU Sales Team 
-- That combines details from all tables 
-- And exclude data related to the USA 

CREATE VIEW Sales.V_Order_Details_EU AS
(
	SELECT
	O.OrderID,
	O.OrderDate,
	P.Product,
	P.Category, 
	P.Price,
	O.Sales,
	O.Quantity,
	COALESCE(C.FirstName, '')+ ' ' + COALESCE(C.LastName, '') AS CustomersName,
	C.Country CustomerCountry,
	COALESCE(E.FirstName, '')  + ' ' + COALESCE(E.LastName, '') EmployeeName,
	E.Department,
	E.Salary
	FROM Sales.Orders AS O
	LEFT JOIN Sales.Products AS P
	ON O.ProductID = P.ProductID
	LEFT JOIN Sales.Customers AS C
	ON O.CustomerID = C.CustomerID
	LEFT JOIN Sales.Employees AS E
	ON O.SalesPersonID = E.EmployeeID
	WHERE C.Country != 'USA'
)
*/



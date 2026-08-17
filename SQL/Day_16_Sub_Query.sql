-- SQL SUB-QUERIES 
-- RESULT TYPES 
-- 1. SCALAR SUBQUERY (Returns only single value, Only one row and one column)
SELECT 
	MAX(Sales) Highest_Sales
FROM Sales.Orders

-- 2. ROW-QUERY (Returns Multiple rows and Single Column)
SELECT 
	Sales
FROM Sales.Orders

-- 3. TABLE SUB-QUERY (Returns Multiple rows as well as Multiple columns)
SELECT 
	OrderID,
	OrderDate,
	Sales
FROM Sales.Orders

-- SUBQUERY IN LOCATION CLAUSES 
-- FROM CLAUSE (Outer Query is main query and inside it the sub-query)

--Find the products that have a price higher than the average price of all products 

SELECT 
	*
FROM(
	SELECT 
		ProductID,
		Category,
		Price,
		AVG(Price) OVER() AvgPrice
	FROM Sales.Products)t
WHERE price > AVGPrice

-- Rank the customers based on their total amount of sales 
SELECT
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) Rank
FROM(
SELECT
	CustomerID,
	SUM(Sales) TotalSales 
FROM Sales.Orders
GROUP BY CustomerID
)t

-- SELECT CLAUSE SUBQUERY (It works only if you have scaler value)
-- Show the productID, product names, prices and the total no of orders

-- Main Query
SELECT 
	ProductID,
	Product,
	Price,
	-- Sub Query
	(SELECT COUNT(*) FROM Sales.Orders) TotalOrders
FROM Sales.Products

-- JOIN CLAUSE SUBQUERY 
-- Show all customer details and find the total orders of each customer 
SELECT 
	c.*,
	o.TotalOrders
FROM Sales.Customers c

LEFT JOIN (
SELECT 
	CustomerID,
	COUNT(*) TotalOrders
FROM Sales.orders 
GROUP BY CustomerID) o
ON c.customerID = o.CustomerID;

-- WHERE SUBQUERY - Used of complex filtering logic and makes query more flexible and dynamic 
-- Two types # Subquery with comparison operators (Rule only scaler subqueries are allowed to be used)
--			 ## Subquery with logical operators

-- Find the products that have a price higher than the average price of all products 
SELECT
	ProductID,
	Price
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

-- Find the Orders that has been purchased by the people from germany 

SELECT 
	*
FROM Sales.Orders
WHERE CustomerID IN  
				(SELECT 
				CustomerID 
				FROM Sales.Customers 
				WHERE Country = 'Germany');



-- ANY OPERATOR IN WHERE CLAUSE - They are used to check atleast one value should be matched within the list

-- Find the female employees whose salaries is greater than any male employee

SELECT 
	EmployeeID,
	Salary,
	(CONCAT(FirstName,' ', LastName)) AS Name
	FROM Sales.Employees 
	WHERE Gender  = 'F' AND Salary > ANY
					(SELECT  
						Salary
						FROM Sales.Employees 
						WHERE Gender  = 'M');

-- ALL OPERATOR IN WHERE CLAUSE - They are used to check that all values are matching or not 
SELECT 
	EmployeeID,
	Salary,
	(CONCAT(FirstName,' ', LastName)) AS Name
	FROM Sales.Employees 
	WHERE Gender  = 'F' AND Salary > ALL
					(SELECT  
						Salary
						FROM Sales.Employees 
						WHERE Gender  = 'M');

-- Corelated Query and Non-Corelated 

-- Show all customer details and their total orders



SELECT 
	*,
	(SELECT COUNT(*) Total_Orders FROM Sales.Orders AS o WHERE c.CustomerID = o.CustomerID) TotalOrders
FROM Sales.Customers AS c 


-- Select all the orders made by customer from germany (corealated sub query)
SELECT 
*
FROM Sales.Orders o
WHERE EXISTS	 (
					SELECT
					CustomerID
					FROM Sales.Customers c
					WHERE Country = 'Germany'
					AND o.CustomerID = c.CustomerID)
					

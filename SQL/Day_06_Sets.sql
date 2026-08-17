-- SETS
-- #1 You can't use ORDERBY in each query it can be used only in last of the final query 
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION 

SELECT	
	FirstName,
	LastName
FROM Sales.Employees

-- #2 Same number of columns
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION 

SELECT	
	FirstName,
	LastName
FROM Sales.Employees

-- #3 Same Data Type
SELECT 
	FirstName,
	CustomerID
FROM Sales.Customers

UNION 

SELECT	
	FirstName,
	EmployeeID
FROM Sales.Employees

--#4 Order of columns should be same 
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION 

SELECT	
	FirstName,
	LastName
FROM Sales.Employees

--#5 First query controls the naming of second column
SELECT 
	CustomerID,
	LastName
FROM Sales.Customers

UNION 

SELECT	
	EmployeeID,
	LastName
FROM Sales.Employees

-- #6 Correct mapping 

-- UNION - Combine all the data but without duplicates 
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION 

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- UNION ALL - It shows all the data without removing the duplicates
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION ALL

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- EXCEPT (minus)- Returns the Unique rows in the first table which is not present in the second table it will only show the output from the first table means order of query important
SELECT 
	FirstName,
	LastName
FROM Sales.Employees

EXCEPT

SELECT 
	FirstName,
	LastName
FROM Sales.Customers

-- INTERSECT - Return duplicates 
/*SELECT 
	FirstName,
	LastName
FROM Sales.Customers

INTERSECT*/

SELECT 
	FirstName,
	LastName
FROM Sales.Customers

INTERSECT

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

SELECT 
'Orders' AS SourceTable
	,[OrderID]
	,[ProductID]
	,[CustomerID]
	,[SalesPersonID]
	,[OrderDate]
	,[ShipDate]
	,[OrderStatus]
	,[ShipAddress]
	,[BillAddress]
	,[Quantity]
	,[Sales]
	,[CreationTime]
FROM Sales.Orders

UNION 

SELECT
'OrdersArchive' AS SourceTable
	,[OrderID]
	,[ProductID]
	,[CustomerID]
	,[SalesPersonID]
	,[OrderDate]
	,[ShipDate]
	,[OrderStatus]
	,[ShipAddress]
	,[BillAddress]
	,[Quantity]
	,[Sales]
    ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID;



SELECT 
	e.FirstName,
	e.LastName
FROM Sales.Employees AS e

INTERSECT

SELECT 
	c.FirstName,
	c.LastName
FROM Sales.Customers AS c



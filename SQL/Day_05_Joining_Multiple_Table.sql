USE SalesDB
-- JOINING MULTIPLE TABLES 
SELECT 
	o.OrderID,
	o.Sales,
	c.FirstName AS CustomersFirstName,
	c.LastName AS CustomersLastName,
	p.Product AS ProductName,
	p.Price,
	e.FirstName AS EmployeeFirstName,
	e.LastName AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p 
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID	
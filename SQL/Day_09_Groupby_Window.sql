-- GROUP BY - Rule: same column should be in both SELECT and GROUP BY we can't put multiple columns
SELECT 
	ProductID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID

-- WINDOW FUNCTION - For Advance Analytics
SELECT 
	OrderID,
	OrderDate,
	ProductID,mm
	SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct
FROM Sales.Orders

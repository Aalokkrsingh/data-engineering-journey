-- NULLS means nothing 
-- ISNULL/COALESCE - They are used to fill the null value means to replace NULL with any value 
-- NULLIF - It is used to replace a value with NULL 
--IS NULL - To check whether value is NULL or not (TRUE)
--IS NO NULL - FALSE

-- ISNULL - It is limited to only two values
SELECT 
	OrderID,
	ShipAddress,
	ISNULL(ShipAddress, 'Unknown') Replace_With_Static_Value,
	ISNULL(ShipAddress, BillAddress) Replace_Null
FROM Sales.Orders

-- COALESCE - It is a list of multiple values 
SELECT 
	OrderID,
	ShipAddress,
	BillAddress,
	COALESCE(ShipAddress, BillAddress, 'N/A')
FROM Sales.Orders



SELECT 
	CustomerID,
	FirstName,
	LastName,
	Score,
	FirstName + ' '+ COALESCE(LastName, ' ') AS Name,
	CONCAT(FirstName,' ', LastName) AS FullName,
	COALESCE(Score, 0) + 10 ScoreWithBonus
FROM Sales.Customers

-- Sort the customer on lowest to highest score with NULLS Should be at low level
SELECT 
	CustomerID,
	FirstName,
	LastName,
	CONCAT(FirstName,' ', LastName) AS Name,
	CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag,
	Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score

-- NULLIF - Only contains two values

SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales / NULLIF(Quantity, 0) AS Price
FROM Sales.Orders

-- IS NULL, IS NOT NULL 
SELECT 
	CustomerID,
	Score 
FROM Sales.Customers
WHERE Score IS NOT NULL

-- Show the customers who have nt ordered 
SELECT 
c.*,
o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

-- Permanent Tables - CREATE/SELECT or CTAS 
-- Temporary Table - These tables are store temporarly in our DB till session gets over 

-- CREATE
CREATE TABLE MMA_Fighters(
NAME VARCHAR(50),
WEIGHT INT,
AGE INT);
-- INSERT VALUES
INSERT INTO MMA_Fighters(NAME, WEIGHT, AGE)
VALUES ('Khabib Nurmagomedov',70,30);
-- DROP 
DROP TABLE MMA_Fighters

-- CTAS (Create Table As Select)
IF OBJECT_ID('Sales.MonthlySales','U') IS NOT NULL 
DROP TABLE Sales.MonthlySales;
GO
SELECT 
	DATENAME(month, OrderDate) AS Month,
	SUM(Sales) AS TotalSales
	INTO Sales.MonthlySales
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate);

-- Temporary table
SELECT 
* 
INTO #Temp_Orders
FROM Sales.Orders

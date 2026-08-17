-- SQL WINDOW RANKING FUNCTIONS - is used to assign a number based on their order means ranking the value.
-- ALL Rank function except NTILE(n) it carries a value inside it.
-- PARTITION BY is not compulsory but ORDER BY is Required.

-- INTEGER BASED RANKING FUNCTIONS 
-- ROW_NUMBER() - Assign a unique number to each row and it doesn't handle the ties, No gaps.
-- Rank the sales based on their order from highest to lowest 
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) Sales_Row_Rank
FROM Sales.Orders

-- RANK() It handels the ties but skip the value
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) Sales_Row_Rank,
	RANK() OVER(ORDER BY Sales DESC) Sales_Rank
FROM Sales.Orders

-- DENSE_RANK() - It will handle the ties without skiping any value
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) Sales_Row_Rank,
	RANK()		 OVER(ORDER BY Sales DESC) Sales_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) Dense_Rank
FROM Sales.Orders

-- ROW_NUMBER() Usecases: 
-- Find the top highest sales for each product also known as (TOP-N Analysis)
SELECT *
FROM (
SELECT
	OrderID,
	ProductID,	
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) Product_Rank
FROM Sales.Orders
)t WHERE Product_Rank = 1

-- Find the total 2 customers based on their total sales (BOTTOM-N Analysis)
-- It is used to get to know the least performers
SELECT *
FROM (
SELECT
	CustomerID,
	SUM(Sales) Total_Sales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) Rank
FROM Sales.Orders
GROUP BY CustomerID
)t WHERE Rank <= 2

-- Assign unique ID for all the rows (Helps to identify the rows to perform various task like joins, paginating- Divide the large data into small manageable chunks)		
SELECT 
	ROW_NUMBER() OVER(ORDER BY OrderID) Unique_ID,
	*
FROM Sales.OrdersArchive

-- Identify and remove the duplicates from the data to improve the quality 
SELECT * 
FROM(
SELECT 
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime) rn,
	* 
FROM Sales.OrdersArchive 
)t WHERE rn = 1

-- NTILE() It is used to divide the rows into buckets Formula - (Total no of rows / Total no of buckets)
-- If the number is odd than first priority will be the top rows
SELECT 
	OrderID,
	OrderDate,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) ThreeBuckets,
	NTILE(2) OVER(ORDER BY Sales DESC) TwoBuckets,
	NTILE(1) OVER(ORDER BY Sales DESC) OneBucket
FROM Sales.Orders

-- Use Case: Data Segmentation for (Data Analyst) and Equalizing Load Processing for ETL (Data Engineers)

-- DATA SEGMENTATION:- Segment all orders into three categories high, medium and low sales.
SELECT
	*,
	CASE WHEN Buckets = 1 THEN 'High'
		 WHEN Buckets = 2 THEN 'Medium'
		 WHEN Buckets = 3 THEN 'Low'
	END SalesSegmentations
FROM (
SELECT 
	OrderID,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) Buckets
FROM Sales.Orders
)t

-- Processing the table from one DB to another:- In order to export the data divide the order into two groups 
SELECT 
	NTILE(2) OVER(ORDER BY OrderID) Buckets,
	* 
FROM Sales.Orders

-- PERCENTAGE BASED RANKING:- CUME_DIST() Include the current row and PERCENT_RANK() Exclude the current row 

-- Calculate the products that fall within the highest 40% of the prices 
-- CUME_DIST()
SELECT 
*,
CONCAT(DistRank * 100 , '%') DistRankPer
FROM (
	SELECT 
		ProductID,
		Price,
		CUME_DIST() OVER(ORDER BY Price DESC) DistRank
FROM Sales.Products
)t WHERE DistRank <= 0.4

-- PERCENT_RANK()
SELECT 
*,
CONCAT(DistRank * 100 , '%') DistRankPer
FROM (
	SELECT 
		ProductID,
		Price,
		PERCENT_RANK() OVER(ORDER BY Price DESC) DistRank
FROM Sales.Products
)t WHERE DistRank <= 0.4
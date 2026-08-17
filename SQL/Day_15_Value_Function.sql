-- VALUE FUNCTIONS 
-- LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()

-- TIME SERIES ANALYSIS (MOM or YOY) It is used to know the pattern of changes in data over the period of time 
-- Year Over Year is used to get the over all comparison of the business and Month Over Month is used to know the short term trend.

--TASK
-- Analyze the month-over-month performance by finding the percentage change 
-- in sales current and previous months
SELECT 
	*,
	CurrentMonthSales -  PreviousMonthSales  AS MOM_Change,
	ROUND((CAST(CurrentMonthSales -  PreviousMonthSales AS FLOAT)) /  PreviousMonthSales * 100 , 1) AS MOM_Change	 
	FROM (
SELECT 
	MONTH(OrderDate) OrderMonth,
	SUM(Sales) CurrentMonthSales,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY 
	MONTH(OrderDate)
)t

-- CUSTOMER RETENTION ANALYSIS OR TIME GAP ANALYSIS: It is used to measure the customer behaviour to help business decision makers.
-- In order to analyze the customer loyalty,
-- rank customer based on the average days between their orders 
SELECT 
	CustomerID,
	AVG(DaysDifference) AvgDays,
	RANK() OVER(ORDER BY COALESCE(AVG(DaysDifference), 999999)) Rankavg
FROM(
SELECT 
	OrderID,
	CustomerID,
	OrderDate,
	LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
	DATEDIFF(day, Orderdate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysDifference
FROM Sales.Orders
)t
GROUP BY 
CustomerID

-- COMPARISON ANALYSIS Highest Sales vs Lowest sales or current sales 
-- Find the lowest and highest sales for each product 
-- Find the difference between current sales and lowest sales 
SELECT 
	ProductID,
	MAX(Sales) HighestSales,
	MIN(Sales) LowestSales
FROM Sales.Orders
GROUP BY ProductID

SELECT 
	ProductID,
	First_Value(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
	First_Value(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSales,
	Last_Value(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales2,
	Sales,
	Sales - First_Value(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) SalesDifference
FROM Sales.Orders

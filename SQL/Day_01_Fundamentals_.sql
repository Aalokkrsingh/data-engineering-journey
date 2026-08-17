-- Practicing SELECT 

-- Selecting the database
USE MyDatabase

-- Retrieving  all Data from the table 
Select *
From customers

-- Retrieve all data from order table
SELECT *
FROM orders 

-- Retrieve specific column from the table name, country and score 

SELECT *
FROM customers

SELECT 
	first_name, 
	country,
	score
FROM customers

-- Retrieve customers score is not equal to zero 

SELECT *
FROM customers

SELECT *
FROM customers
WHERE score != 0

-- Retrieve customers only from germany 
SELECT * 
FROM customers 
WHERE country = 'Germany'

--Retrieve customers only from germany with name and country 
SELECT 
first_name,
country
FROM customers
WHERE country = 'Germany'

-- Retrieve all the columns from the table and sort the results by highest score first

SELECT *
FROM customers

SELECT *
FROM customers
ORDER BY score DESC

SELECT *
FROM customers
ORDER BY score ASC

-- Retrieve all columns and sort the value by the countries and then by the highest score 

SELECT *
FROM customers
ORDER BY country ASC, score DESC -- Refining the sorting 

-- Calculate the total score for each country 

SELECT 
	country,
	SUM(score) AS Total_score
FROM customers
GROUP BY country 

-- Having clause used to filter aggregated data 

SELECT 
	country,
	AVG(score)
FROM customers
WHERE score != 0 
GROUP BY country

SELECT 
	country,
	score
FROM customers
WHERE score != 0 

SELECT 
	country,
	AVG(score) AS Avg_score
FROM customers 
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

-- Distinct is used to remove duplicates
SELECT DISTINCT
	country 
FROM customers

-- Using TOP 
SELECT TOP 3 
	first_name
FROM customers

SELECT TOP 3 
	first_name,
	score 
FROM customers 
ORDER BY score DESC
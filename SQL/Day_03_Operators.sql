-- OPERATORS (COMPARISON, LOGICAL, RANGE, MEMBERSHIP and  SEARCH)
-- COMPARISON OPERATOR 
-- Retrieve all customer from germany 

INSERT INTO customers 
VALUES 
	(1, 'Maria', 'Germany', 350),
	(2, 'John', 'USA', 900),
	(3, 'Georg', 'UK', 750),
	(4, 'Martin', 'Germany', 550),
	(5, 'peter', 'USA', 0)

SELECT * 
FROM customers
WHERE country = 'Germany'

-- Retrieve all customers who are not from germany 

SELECT * 
FROM customers
WHERE country != 'Germany'

--Retrieve all customer whole score greater than or equal to 500
SELECT * 
FROM customers 
WHERE score >= 500

--Retrieve all customer whole score lesser than or equal to 500
SELECT *
FROM customers 
WHERE score <= 500

-- LOGICAL OPERATOR 
-- AND - Both condition should be TURE 
-- OR - Atleast one condition should be TRUE 
-- NOT - Reverse operator True to False and False to True 
SELECT *
FROM customers 
WHERE country = 'USA' AND score > 500

SELECT *
FROM customers 
WHERE country = 'USA' OR score > 500

SELECT * 
FROM customers
WHERE NOT score < 500

--RANGE OPERATOR 
SELECT * 
FROM customers
WHERE score BETWEEN 100 AND 500

--MEMBERSHIP OPERATOR - Determine a List and check it is present in or not
-- IN 
-- NOT IN 

SELECT *
FROM customers
WHERE country IN ('Germany','USA')

SELECT *
FROM customers
WHERE country NOT IN ('GERMANY', 'USA')

-- SERACH (LIKE) OPERATOR 
-- Find all customers whose starting character must be M and last anything 
SELECT *
FROM customers
WHERE first_name LIKE 'M%'

-- Find all customers whose starting character anything but last character should be n
SELECT *
FROM customers 
WHERE first_name LIKE '%n'

-- Find all customers who contains r in their name 
SELECT *
FROM customers 
WHERE first_name LIKE '%r%'

-- Find all customers where 3rd position contains r
SELECT *
FROM customers
WHERE first_name LIKE '__r%'
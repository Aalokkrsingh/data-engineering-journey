-- ADVANCE JOINS 
-- LEFT ANTI JOIN - Which is not present on the another table 
SELECT *
FROM customers

SELECT * 
FROM orders

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON id = o.customer_id
WHERE o.customer_id is NULL

-- RIGHT ANTI JOIN - Only show the row which is unmatched in the left table
SELECT *
FROM orders
LEFT JOIN customers
ON id = customer_id
WHERE id IS NULL

-- FULL ANTI JOIN - To check the unmatched data from both the tables 
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON o.customer_id = c.id
WHERE c.id IS NULL 
OR o.customer_id IS NULL

SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL
AND c.id IS NOT NULL


-- CROSS JOIN - Make all possible combination of rows by multiplying rows into columns 
SELECT *
FROM customers 
CROSS JOIN orders


SELECT *
FROM customers
LEFT JOIN orders
ON id =	 customer_id
WHERE customer_id is NULL

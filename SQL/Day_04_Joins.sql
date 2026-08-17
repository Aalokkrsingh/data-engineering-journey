-- JOINS 
-- Why we use joins 
-- 1. Recombine the data to see the big picture 
-- 2. Data Enrichment to get more data for extra information from the different table known as Refrence table 
-- 3. Check existence that the particullar thing is present in the other table or not also know as lookup

-- NO JOIN query two table without combining them
SELECT * 
FROM customers;

SELECT *	
FROM orders;

-- INNER JOIN Returns only the matching data from the both table
SELECT 
	c.id,
	c.first_name, 
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON id = customer_id


SELECT 
	c.id,
	c.first_name,
	c.country,
	o.order_id,
	o.order_date,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON id = customer_id

-- LEFT JOIN get all the data from the left table and matching from the right 
SELECT 
	c.id,
	c.first_name,
	c.country,
	o.order_id,
	o.order_date,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON id = customer_id

-- RIGHT JOIN get all the from right table and matching data from the left 
SELECT 
	c.id,
	c.first_name,
	c.country,
	o.order_id,
	o.order_date,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON id = customer_id



SELECT 
	id,
	first_name,
	country,
	customer_id,
	order_id
FROM orders
LEFT JOIN customers
ON id = customer_id

-- FULL JOIN Returns all the rows from both tables
SELECT 
	id,
	first_name,
	country,
	customer_id,
	order_id
FROM orders
FULL JOIN customers
ON id = customer_id
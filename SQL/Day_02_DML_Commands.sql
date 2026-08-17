-- DML COMMANDS (INSERT, UPDATE, DELETE)
-- (Manual Inserting data)
SELECT * FROM customers
INSERT INTO customers 
VALUES
	(6, 'MAX','USA',NULL),
	(7, 'Mini','India',100)


INSERT INTO customers (id, first_name)
VALUES 
	(10, 'Henry')


-- Inserting 'customer table' into 'person' table 
INSERT INTO persons (id, person_name, birth_date, phone_no)
SELECT
id, 
first_name, 
NULL,
'UNKNOWN'
FROM customers

SELECT * FROM persons 
SELECT * FROM customers 

-- Update the value 

UPDATE customers
SET score = 0 
WHERE id = 6

SELECT id FROM customers 
WHERE id = 6

UPDATE customers
SET score = 0,
	country = 'UK' 
WHERE id = 10 

SELECT * FROM customers



UPDATE customers 
SET score = 0 
WHERE score = NULL


INSERT INTO customers
VALUES
	(11, 'Jimmy', 'USA',NULL)

SELECT * FROM customers

UPDATE customers 
SET score = 0 
WHERE score IS NULL


SELECT * FROM customers
WHERE score = 0 


UPDATE customers 
SET score = NULL 
WHERE score = 0


-- DELETE 
DELETE FROM customers 
WHERE id > 5 

SELECT * FROM customers 
WHERE id > 5 

DELETE FROM customers -- DELETE command is good when table is small 
TRUNCATE TABLE customers -- TRUNCATE is fast and good for large table 






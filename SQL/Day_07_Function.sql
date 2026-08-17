-- FUNCTIONS 
-- #1 Single line 
-- #2 Multiline 

-- STRING FUNCTIONS 
-- CONCAT() Combines multiple strings into single string 
SELECT 
	first_name,
	Country,
	CONCAT (first_name,' ', Country) AS name_country
FROM Customers

-- LOWER() & UPPER() Converts the strings into upper and lower case 
SELECT 
	first_name,
	Country,
	CONCAT (first_name,' ', Country) AS name_country,
	LOWER (first_name) AS low,
	UPPER (first_name) AS upp
FROM Customers

-- TRIM() Removes leading and trailing spaces		
SELECT 
	first_name,
	LEN (first_name) AS lenght ,-- Check the length and see if there any spaces or not 
	LEN(TRIM(first_name)) AS newN,
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM Customers

-- REPLACE() Replaces specific character with a new one 
SELECT 
'123-456-7890' AS Phone, -- Static value 
REPLACE('123-456-7890','-','') AS Clean_Phone

SELECT
'reports.txt',
REPLACE('reports.txt', 'txt','csv')

-- LEN() Counts the characters 
SELECT
	first_name,
	LEN(first_name) AS len_name
FROM Customers

-- LEFT & RIGHT() Extract the left or right character 
SELECT 
'Maria' original,
LEFT('Maria',2) extracted

SELECT 
'Maria' original,
RIGHT('Maria',2) extracted

-- SUBSTRING() Extract the specified part of the string 
SELECT
	first_name orginal,
SUBSTRING(first_name, 2,LEN(first_name)) extracted,
LEN(SUBSTRING(first_name, 2,LEN(first_name))) 
FROM Customers

-- NUMERICAL FUNCTION 
-- ROUND() Roundup the value 
SELECT
3.156,
ROUND(3.156, 2) AS round_2,
ROUND(3.156, 1) AS round_1,
ROUND(3.156, 0) AS round_0

-- ABS() Converting negative to possitive 
SELECT 
-10,
ABS(-10)

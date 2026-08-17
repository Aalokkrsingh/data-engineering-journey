-- DDL COMMANDS (CREATE, ALTER, DROP)
-- Create a table 

CREATE TABLE persons (
	id INT NOT NULL, 
	person_name VARCHAR(50) NOT NULL,
	birth_date INT,
	phone_no VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
	)

-- Adding a new column 
ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL 

SELECT * FROM persons

-- Removing the column 
ALTER TABLE persons
DROP COLUMN phone_no

-- Delete the table 
DROP TABLE persons





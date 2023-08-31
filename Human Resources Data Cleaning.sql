/*

Human Resources Data Cleaning 

*/

USE project;

SELECT * FROM human_resources;
DESCRIBE human_resources;

-- Changing the ID column to Employee
ALTER TABLE human_resources
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- Update the 'birthdate' column 
UPDATE human_resources
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Update 'birthdate' column to standardized date format
ALTER TABLE human_resources
MODIFY COLUMN birthdate DATE;

-- Update the 'hire_date' column
UPDATE human_resources
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Update 'hire_date' column to standardized date format
ALTER TABLE human_resources
MODIFY COLUMN hire_date DATE;

SELECT birthdate, hire_date FROM human_resources;

-- Updates the 'termdate' column and fill the missing values with 0001-01-01
UPDATE human_resources
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from human_resources;

-- Update 'termdate' column to standardized date format
SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE human_resources
MODIFY COLUMN termdate DATE;

ALTER TABLE human_resources
DROP COLUMN age;

-- Adding new column 'age'
ALTER TABLE human_resources ADD COLUMN age INT;

-- Filling the colum 'age' with appropriate data 
UPDATE human_resources
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT age FROM human_resources;
-----------------------------------------------------------------------------
SELECT 
min(age) AS youngest,
max(age) AS oldest
FROM human_resources;


SELECT count(*) FROM human_resources WHERE age < 18;
SELECT COUNT(*) FROM human_resources WHERE termdate > CURDATE();
SELECT COUNT(*) FROM human_resources WHERE termdate = '0000-00-00';




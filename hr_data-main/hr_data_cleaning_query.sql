use hr_db;

select * from hr_table;
select birthdate from hr_table;

### change birthdate column into one format

-- SELECT CONVERT(VARCHAR, CONVERT(DATE, birthdate, 1), 23) AS birthdate
-- FROM hr_table;
## rename column name 

ALTER TABLE hr_table
CHANGE COLUMN `ï»¿id` id INT; -- Replace INT with the appropriate data type if it's not an integer

SHOW COLUMNS FROM hr_table;


ALTER TABLE hr_table MODIFY COLUMN `ï»¿id` VARCHAR(100); -- Change the length as needed

ALTER TABLE hr_table CHANGE COLUMN `ï»¿id` id VARCHAR(100); -- Change the length as needed
SHOW COLUMNS FROM hr_table;

select birthdate from hr_table;
SET SQL_SAFE_UPDATES = 0;

UPDATE hr_table
SET termdate = CASE
    WHEN termdate REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' THEN DATE_FORMAT(STR_TO_DATE(termdate, '%m-%d-%y'), '%Y-%m-%d')
    WHEN termdate REGEXP '^[0-9]/[0-9]{2}/[0-9]{4}$' THEN DATE_FORMAT(STR_TO_DATE(termdate, '%c/%e/%Y'), '%Y-%m-%d')
    ELSE termdate
END;

UPDATE hr_table
SET termdate = DATE_FORMAT(STR_TO_DATE(termdate, '%m/%d/%Y'), '%Y-%m-%d');

UPDATE hr_table
SET termdate = 
    CASE
        WHEN hire_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN
            CASE
                WHEN STR_TO_DATE(termdate, '%m/%d/%Y') IS NOT NULL THEN DATE_FORMAT(STR_TO_DATE(termdate, '%m/%d/%Y'), '%Y-%m-%d')
                ELSE DATE_FORMAT(STR_TO_DATE(termdate, '%m-%d-%y'), '%Y-%m-%d')
            END
        ELSE termdate
    END;


SHOW COLUMNS FROM hr_table;
select birthdate from hr_table;

## changing default column data type

ALTER TABLE hr_table -- Replace INT with your desired data type
MODIFY first_name VARCHAR(255), -- Replace VARCHAR(255) with an appropriate length
MODIFY last_name VARCHAR(255),
MODIFY birthdate DATE,
MODIFY race VARCHAR(50),
MODIFY department VARCHAR(255),
MODIFY jobtitle VARCHAR(255),
MODIFY location VARCHAR(255),
MODIFY hire_date DATE,
MODIFY termdate DATE,
MODIFY location_city VARCHAR(255),
MODIFY location_state VARCHAR(255);

select termdate from hr_table;
UPDATE hr_table
SET termdate = DATE_FORMAT(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'), '%Y-%m-%d');

###
UPDATE hr_table
SET termdate = CASE 
                    WHEN termdate <> '' 
                    THEN DATE_FORMAT(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'), '%Y-%m-%d')
                    ELSE NULL -- or specify the desired default value
              END;

select termdate from hr_table;

## gender 
select gender from hr_table;

select gender, count(gender)
from hr_table
group by gender;

ALTER TABLE hr_table MODIFY COLUMN gender VARCHAR(50); -- Modify the size according to your needs

ALTER TABLE hr_table MODIFY COLUMN gender VARCHAR(50);

SHOW COLUMNS FROM hr_table;

########### now we have done some cleaning interms of column name changing and its data type ###


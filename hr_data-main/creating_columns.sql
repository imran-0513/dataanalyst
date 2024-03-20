### creating new column based on existing column

### age column
alter table hr_table
add age nvarchar(50);

select * from hr_table;

SET SQL_SAFE_UPDATES = 0;

## populate new column with age
update hr_table
set age = TIMESTAMPDIFF(year, birthdate, CURDATE());

select * from hr_table;

alter table hr_table
add new_termdate DATE;

### copy converted time values from termdate to new_termdate

## SSMS
-- update hr_table
-- set new_termdate = case
-- when termdate is not null and ISDATE(termdate) = 1 then cast
-- (termdate as DATETIME) ELSE NULL END;

UPDATE hr_table
SET new_termdate = CASE 
    WHEN termdate IS NOT NULL AND STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s') IS NOT NULL
    THEN STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s')
    ELSE NULL
END;

select * from hr_table;

#### drop new_termdate colum

ALTER TABLE hr_table
DROP COLUMN new_termdate;

### we are having negative values in age group will convert those into positive

select age from hr_table;

## will find all negative values present in age column
SELECT age,COUNT(age) AS negative_count
FROM hr_table
WHERE age < 0
group by age;

UPDATE hr_table
SET age = ABS(age);


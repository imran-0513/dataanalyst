## questions to answer from the data
-- 1.whats the age distribution in company 
select min(age),
max(age)
from hr_table;

-- age group count
select gender, count(age) total_count
from hr_table
group by gender;

### will create age group based on range

select age_group, count(*) as count
from
(select 
case
when age <=21 and age<=30 then "21 to 30"
when age <=31 and age <=40 then "31 to 40"
when age <=41 and age <=50 then "41 to 50"
else "50+"
end as age_group
from hr_table
where termdate is null
) as subquery
group by age_group
order by age_group;


### age group by gender
select age_group, gender,count(*) as count
from
(select 
case
when age <=21 and age<=30 then "21 to 30"
when age <=31 and age <=40 then "31 to 40"
when age <=41 and age <=50 then "41 to 50"
else "50+"
end as age_group,gender
from hr_table
where termdate is null
) as subquery
group by age_group, gender
order by age_group, gender;
###


-- 2. whats the gender break down in the company
select gender, count(gender) count
from hr_table
where termdate is null
group by gender
order by gender ;


-- 3. how does gender vary across departments and job titles  
##department
select department,gender,count(gender) total_count
from hr_table
where termdate is null
group by department,gender
order by department, gender ;

## jobtitle
select department,jobtitle,gender,count(gender) total_count
from hr_table
where termdate is null
group by department,jobtitle,gender
order by department,jobtitle,gender ;


-- 4. whats the race distribution in the company
select * from hr_table;

select race, count(race) race_count
from hr_table
where termdate is null
group by race
order by race_count desc;

-- 5. whats the average length of employement in the company
SELECT round(AVG(TIMESTAMPDIFF(YEAR, hire_date, termdate))) AS tenure
FROM hr_table
WHERE termdate IS NOT NULL AND termdate <= CURDATE();

################ will update tenure column as well 
ALTER TABLE hr_table
ADD tenure INT;

UPDATE hr_table
SET tenure = TIMESTAMPDIFF(YEAR, hire_date, termdate);
select * from hr_table;
###############################

-- 6. which department has the highest turnover rate
-- get total count
-- get terminated count
-- terminated count / total count
select department, total_count, terminated_count,
round(((terminated_count/total_count)*100),2) as "turover_rate%"
from
(SELECT department,
COUNT(*) AS total_count,
SUM(CASE
	WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1
	ELSE 0
	END) AS terminated_count
FROM hr_table
GROUP BY department
) as sub_query
order by terminated_count;

-- 7. what is the tenure distribution for each department

select department,count(tenure) total_tenure
from hr_table
where termdate is not null and termdate <= curdate()
group by department
order by total_tenure desc;
#########
SELECT
department,
round(AVG(TIMESTAMPDIFF(YEAR, hire_date, termdate))) AS total_tenure
FROM hr_table
WHERE
    termdate IS NOT NULL AND termdate <= CURDATE()
GROUP BY department
ORDER BY total_tenure DESC;

-- 8. how many employees work remotely for each department
## remvote vs headquarter
select location, count(*) count
from hr_table
where termdate is null
group by location
order by count desc;

## remote each department
select department,location, count(location) total_count
from hr_table
where location = "Remote"
group by department
order by total_count desc;

-- 9. whats the distribution of employees across different states
select * from hr_table;

select location_state, count(*) count
from hr_table
where termdate is null
group by location_state
order by count desc;

-- 10. how are job titles distributed in the company
select * from hr_table;

select jobtitle, count(jobtitle) count
from hr_table
where termdate is null
group by jobtitle
order by count desc;

## keeping employee id with only last 5 digit
-- UPDATE hr_table
-- SET id = RIGHT(id, 5);


select * from hr_table;
-- 11. how have employee hire counts varied over time?
## steps
-- calculate hires
-- calculate terminations
-- (hire-terminations)/hire percent hire change

### how many candidates hired in each year
select 
year(hire_date) as hire_year,
count(*) as hires
from hr_table
group by hire_year
order by hires desc;

###### how many Male and Female hired in each year

select 
year(hire_date) as hire_year,gender,
count(*) as hires
from hr_table
where termdate is null
group by hire_year,gender
order by hire_year;

### will solve the 11th problem
select hire_year, hires, terminations,
hires-terminations as net_change,
round((cast(hires-terminations as float)/hires*100),2) as percent_hire_change
from 
(SELECT 
YEAR(hire_date) AS hire_year,
COUNT(*) AS hires,
SUM(CASE
	WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0
END) AS terminations
FROM hr_table
GROUP BY YEAR(hire_date)
) as sub_query
order by percent_hire_change desc;

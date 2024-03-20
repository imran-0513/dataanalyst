SELECT * FROM test_db.emp;

use test_db;
select * from emp;
select emp_designation,count(*) total from emp
group by emp_designation;

select * from(select emp_name, emp_designation,emp_salary,
dense_rank() over (partition by emp_designation order by emp_salary desc) as rnk
from emp) sub
where rnk<=2;

select * from(select emp_name, emp_designation,emp_salary,
rank() over (partition by emp_designation order by emp_salary desc) as rnk
from emp) sub
where rnk<=2;

select * from dept;
select * from emp;

select * from emp
where emp_name not like '[^a-p]%';

select * from emp
where emp_name like '%a';
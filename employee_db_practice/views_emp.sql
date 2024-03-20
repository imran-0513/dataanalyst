
select * from emp;

select * from dept;

############# creating view ###########

create view employee_detail
as
(select e.emp_id, e.emp_name, e.emp_salary, e.emp_dept_id, e.emp_designation, d.dept_name from emp e
join dept d on 
d.dept_id = e.emp_dept_id);

select * from employee_detail
where emp_designation = "analyst";


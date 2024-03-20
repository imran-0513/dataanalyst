use walmart;

select * from sales;
select payment, count(*) total
from sales
group by payment
order by total desc;

show columns from sales;
-- alter table sales
-- CHANGE column `Customer type` customer_type VARCHAR(50);

select customer_type, count(*) total from sales
order by total desc;

select * from sales;

select `product line`, count(*) total from sales
group by `product line`
order by total desc;

select * from sales;

select branch, city, customer_type, `unit price`, gender, `product line`, quantity,
dense_rank() over( partition by `product line` order by `unit price` desc) as "rank"
from sales;


select branch, city, customer_type, `product line`,`unit price`, quantity, rnk from
(select branch, city, customer_type, `unit price`, gender, `product line`, quantity,
dense_rank() over( partition by customer_type order by quantity desc) as rnk
from sales) sub
where rnk <=2;

select * from sales;
create view samplesales as
(select branch,city,customer_type,'product line', payment,total,rating
from sales);

select 'invoice id' from sales;
show columns from sales;

select * from samplesales;

##### grouping
select *,
case
when rating < 5 then "not good"
when rating >=5 and rating <= 7 then "average"
	else "good"
end as "rating_group"
from samplesales;
	
#######################################################

select rating_group, count(*) total_count from
(select *,
case
when rating < 5 then "not good"
when rating >=5 and rating <= 7 then "average"
	else "good"
end as "rating_group"
from samplesales) as sub
group by rating_group
order by total_count desc;
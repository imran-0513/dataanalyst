SELECT * FROM imran_db.orders;

select c.firstname,c.customerid,o.lineitemtotal
from customers c
join orders o on c.customerid=o.CustomerID;

select c.firstname,c.customerid,round(sum(o.lineitemtotal),2) as total_marks
from customers c
join orders o on c.customerid=o.CustomerID
group by c.firstname,c.customerid
order by total_marks desc;
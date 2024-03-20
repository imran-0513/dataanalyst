--1 who is the senior most employee based on job title?
select * from employee
order by levels desc
limit 1;

--2 which countries have the most invoices?
select billing_country, count(*) as total_invoice
from invoice
group by billing_country
order by total_invoice desc;

--3 what are top 3 values of invoice
select * from invoice
order by total desc
limit 3;

--4 Which city has the best customers? We would like to throw a promotional 
--Music Festival in the city we made the most money. Write a query that returns one city 
--that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.


use moviesdb;
select * from movies;

####
create view moviesclass 
as (select * from movies
where industry="bollywood");

select * from moviesclass;


##### case #######

create view movierating as(
select movie_id, title, industry, release_year, imdb_rating,
case
	when imdb_rating <= 4 then "flop"
    when imdb_rating > 4  and imdb_rating <=6.8 then "average"
    when imdb_rating > 6 and imdb_rating <=8.5 then "hit"
    else "super hit"
end as "rating_class"
from movies);

#### analysis on created view
select * from movierating;
select rating_class, count(*) total_count from movierating
group by rating_class
order by total_count desc;

#####
select * from movierating;
#### how many hit movies in 2022
select release_year, count(rating_class) countclass
from movierating
where rating_class="hit" 
group by release_year
order by countclass desc;

select * from movierating
where release_year=2015 and rating_class="hit";


################################### having where #############################

select * from movies;
select studio, count(title) total
from movies
group by studio
having total<5;


############################views with multiple table ##################
select * from movies;
select * from actors;
select * from movie_actor;
select * from languages;

create view movie_actors as
(
select m.movie_id,m.title,m.industry,m.release_year,group_concat(a.name) actor
from movies m
join movie_actor mv on m.movie_id=mv.movie_id
join actors a on mv.actor_id=a.actor_id
group by m.movie_id, m.title, m.industry, m.release_year);


################# count no of actors in each movie
select * from movie_actors;

SELECT title,industry,release_year, actor, REGEXP_COUNT(actor, ',') + 1 AS actor_count
FROM movie_actors;
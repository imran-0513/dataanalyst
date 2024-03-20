select * from movierating;
use moviesdb;

select m.movie_id,m.title,group_concat(" ",a.name) actor,m.industry,m.rating_class
from movierating m
join movie_actor ma on m.movie_id=ma.movie_id
join actors a on a.actor_id=ma.actor_id
group by m.movie_id,m.title,m.industry,m.rating_class;


###################### create stored procedure and concat actors name based on film ###############

select m.movie_id,m.title,group_concat(" ",a.name) actor,m.industry,m.rating_class
from movierating m
join movie_actor ma on m.movie_id=ma.movie_id
join actors a on a.actor_id=ma.actor_id
group by m.movie_id,m.title,m.industry,m.rating_class;




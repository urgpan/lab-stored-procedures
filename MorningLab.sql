use sakila;

-- 1 and 2
drop procedure if exists FIRST_QUESTION; 
delimiter //
create procedure FIRST_QUESTION (IN GENRE varchar(20))
begin
	select first_name, last_name, email
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name COLLATE utf8mb4_general_ci = GENRE
	group by first_name, last_name, email;
end;
//
delimiter ;

call FIRST_QUESTION("Action");
-- select round(@x) as TOTAL_LOSS_DISTRICT;

-- 3 
drop procedure if exists THIRD_QUESTION; 
delimiter //
create procedure THIRD_QUESTION (IN filmNum int)
begin
	select category.name, count(name)
	from film
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	group by category.name
    having 	count(name) > filmNum;
end;
//
delimiter ;

call THIRD_QUESTION(60);

-- select @d as TOTAL_FILMS_CATEGORY;
--  asdasdasd

drop procedure if exists category_customer_param;

delimiter //
create procedure category_customer_param(in param1 int)
begin

select name, count(name) as n_movies
from film f 
join film_category fc using(film_id)
join category using(category_id)
group by name
having n_movies > param1;

end;
//
delimiter ;

call category_customer_param(60);



SELECT
	actor.first_name, actor.last_name, film.title
FROM
	actor
		INNER JOIN
	film_actor ON actor_id = film_actor.actor_id
		INNER JOIN
	film ON film_actor.film_id = film.film_id;
    
    
select * from rental;
select * from customer;
select * from inventory;
select * from film;

SELECT 
    customer.first_name AS fname, customer.last_name AS lname
FROM
    rental AS r
        INNER JOIN
    customer ON customer.customer_id = r.customer_id; 

SELECT film_id as film_inventory 
 







 
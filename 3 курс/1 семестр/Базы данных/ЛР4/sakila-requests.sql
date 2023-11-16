-- Вывести всех покупателей из указанного списка стран: отобразить имя, фамилию, страну
select customer.first_name as "Имя", customer.last_name as "Фамилия", country.country as "Страна"
from customer 
	join address on customer.address_id = address.address_id
	join city on address.city_id = city.city_id
    join country on city.country_id = country.country_id
where country.country in ("Russian Federation");

-- Вывести все фильмы, в которых снимался указанный актер: отобразить название фильма, жанр
select film.title as "Название фильма", category.name as "Жанр"
from film
	join film_category on film.film_id = film_category.film_id
    join category on film_category.category_id = category.category_id
    join film_actor on film.film_id = film_actor.film_id
    join actor on film_actor.actor_id = actor.actor_id
where actor.first_name = "PENELOPE" and actor.last_name = "GUINESS";
    
-- Вывести топ 10 жанров фильмов по величине дохода в указанном месяце: отобразить жанр, доход
select category.name as "Жанр", sum(payment.amount) as "Доход"
from film
	join film_category on film.film_id = film_category.film_id
    join category on film_category.category_id = category.category_id
    join inventory on film.film_id = inventory.film_id
    join rental on inventory.inventory_id = rental.inventory_id
    join payment on rental.rental_id = payment.rental_id
where monthname(payment.payment_date) = "June"
group by category.name
order by sum(payment.amount) desc
limit 10;

-- Вывести список из 5 клиентов, упорядоченный по количеству купленных фильмов с указанным актером, начиная с 10-й позиции:
-- отобразить имя, фамилию, количество купленных фильмов
select customer.first_name as "Имя", customer.last_name as "Фамилия", count(film.title)
from customer
	join rental on customer.customer_id = rental.customer_id
    join inventory on inventory.inventory_id = rental.inventory_id
    join film on film.film_id = inventory.film_id
    join film_actor on film.film_id = film_actor.film_id
    join actor on film_actor.actor_id = actor.actor_id
where actor.first_name = "PENELOPE" and actor.last_name = "GUINESS"
group by actor.first_name, actor.last_name
order by count(film.title)
limit 5 offset 10;

-- Вывести для каждого магазина его город, страну расположения и суммарный доход за первую неделю продаж
select store.store_id as "Номер магазина", city.city as "Город", country.country as "Страна", sum(payment.amount) as "Суммарный доход"
from store
	join address on store.address_id = address.address_id
    join city on address.city_id = city.city_id
    join country on city.country_id = country.country_id
	join inventory on store.store_id = inventory.store_id
    join rental on inventory.inventory_id = rental.inventory_id
    join payment on rental.rental_id = payment.rental_id
where date(payment.payment_date) <= date_add(date('2005-05-24'), interval 1 week)
group by store.store_id;

-- select payment.payment_date from payment 
-- order by payment.payment_date;


-- Вывести всех актеров для фильма, принесшего наибольший доход: отобразить фильм, имя актера, фамилия актера
select distinct film.title as "Фильм", actor.first_name as "Имя", actor.last_name as "Фамилия"
from film
	join film_actor on film.film_id = film_actor.film_id
    join actor on film_actor.actor_id = actor.actor_id
    join inventory on film.film_id = inventory.film_id
    join rental on inventory.inventory_id = rental.inventory_id
    join payment on rental.rental_id = payment.rental_id
where film.title = 
(select films_payment.film_title
from 
(select film.title as film_title, sum(payment.amount) as sum_paymment_amount
from film
	join inventory on film.film_id = inventory.film_id
    join rental on inventory.inventory_id = rental.inventory_id
    join payment on rental.rental_id = payment.rental_id
group by film.title) as films_payment
where films_payment.sum_paymment_amount = (select max(films_payment.sum_paymment_amount) from
(select film.title as film_title, sum(payment.amount) as sum_paymment_amount
from film
	join inventory on film.film_id = inventory.film_id
    join rental on inventory.inventory_id = rental.inventory_id
    join payment on rental.rental_id = payment.rental_id
group by film.title) as films_payment));

-- Для всех покупателей вывести информацию о покупателях и актерах-однофамильцах
select customer.first_name as "Имя покупателя", customer.last_name as "Фамилия покупателя", actor.first_name as "Имя актера", actor.last_name as "Фамилия актера"
from customer left join actor on customer.last_name = actor.last_name;
    
-- Для всех актеров вывести информацию о покупателях и актерах-однофамильцах 
select actor.first_name as "Имя актера", actor.last_name as "Фамилия актера", customer.first_name as "Имя покупателя", customer.last_name as "Фамилия покупателя"
from customer right join actor on customer.last_name = actor.last_name;

-- В одном запросе вывести статистические данные о фильмах:
select table_3.film_length AS "Продолжительность фильма", table_3.count_films AS "Количество фильмов", table_3.count_actors  AS "Количество актеров" from
(
-- 1. Длина самого продолжительного фильма – отобразить значение длины;
-- количество фильмов, имеющих такую продолжительность.
	select film.length as film_length, count(*) as count_films, null as count_actors
	from film 
	where film.length = 
		(select max(film.length) 
			from film)
	group by film.length
-- 2. Длина самого короткого фильма – отобразить значение длины; количество
-- фильмов, имеющих такую продолжительность.
	union select film.length as film_length, count(*) as count_films, null as count_actors
	from film 
	where film.length = 
		(select min(film.length) 
			from film)
	group by film.length
-- 3. Максимальное количество задействованных актеров в фильме – отобразить
-- максимальное количество актеров; количество фильмов, имеющих такое число
-- актеров.
	union select null as film_length, table_2.count_actors as count_actors, count( table_2.film_id) as count_films from
		(select count(actor.actor_id) as count_actors, film.film_id as film_id
		from film 
			join film_actor on film.film_id = film_actor.film_id
			join actor on film_actor.actor_id = actor.actor_id
		group by film.film_id
		having count(actor.actor_id) = 
			(select max(table_1.count_actors)
			from (
			select count(actor.actor_id) as count_actors
			from film 
				join film_actor on film.film_id = film_actor.film_id
				join actor on film_actor.actor_id = actor.actor_id
			group by film.film_id) as table_1)) as table_2
	group by table_2.count_actors
-- 4. Минимальное количество задействованных актеров в фильме - отобразить
-- минимальное количество актеров; количество фильмов, имеющих такое число
-- актеров
	union select null as film_length, table_2.count_actors as count_actors, count( table_2.film_id) as count_films from
		(select count(actor.actor_id) as count_actors, film.film_id as film_id
		from film 
			join film_actor on film.film_id = film_actor.film_id
			join actor on film_actor.actor_id = actor.actor_id
		group by film.film_id
		having count(actor.actor_id) = 
			(select min(table_1.count_actors)
			from (
			select count(actor.actor_id) as count_actors
			from film 
				join film_actor on film.film_id = film_actor.film_id
				join actor on film_actor.actor_id = actor.actor_id
			group by film.film_id) as table_1)) as table_2
	group by table_2.count_actors
) as table_3;


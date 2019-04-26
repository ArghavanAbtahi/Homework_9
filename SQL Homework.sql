-- Arghavan Abtahi
-- SQL Homework

USE sakila;

-- 1a.
SELECT first_name, last_name
FROM actor;

-- 1b.
SELECT concat(first_name, " ", last_name) AS "Actor Name"
FROM actor;

-- 2a.
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = "JOE";

-- 2b.
SELECT first_name, last_name
FROM actor
WHERE last_name like "%GEN%";

-- 2c.
SELECT first_name, last_name
FROM actor
WHERE last_name like "%LI%"
ORDER BY last_name, first_name ASC;

-- 2d.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a.
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_update;

-- 3b.
ALTER TABLE actor
DROP description;

-- 4a.
SELECT last_name, COUNT(last_name) AS "Count"
FROM actor
GROUP BY last_name;

-- 4b. 
SELECT last_name, COUNT(last_name) AS "Count"
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

-- 4c.
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

-- 4d.
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- 5a.
SHOW CREATE TABLE address;

-- 6a.
SELECT s.first_name, s.last_name, a.address_id, a.address
FROM address AS a
JOIN staff AS s ON a.address_id = s.address_id;

-- 6b.
SELECT s.first_name, s.last_name, p.staff_id, SUM(amount) AS "Total"
FROM payment AS p 
JOIN staff AS s ON p.staff_id = s.staff_id
WHERE payment_date >= "2005-08-01 00:00:00"
GROUP BY p.staff_id;

-- 6c.
SELECT f.film_id, f. title, COUNT(actor_id) AS "Number of Actors"
FROM film AS f
INNER JOIN film_actor AS i ON f.film_id = i.film_id
GROUP BY f.film_id;

-- 6d.
SELECT COUNT(inventory_id) AS "Hunchback Impossible"
FROM inventory
WHERE film_id IN

 (SELECT film_id 
 FROM film
 WHERE title = "Hunchback Impossible"
);

-- 6e.
SELECT c.first_name, c.last_name, p.customer_id, SUM(amount) AS "Total"
FROM payment AS p 
JOIN customer AS c ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY last_name ASC;

-- 7a. 
SELECT title
FROM film
WHERE language_id IN
	(SELECT language_id
     FROM language 
     WHERE name = "English"
	)
HAVING title LIKE "K%" OR title LIKE "Q%";

-- 7b.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(SELECT actor_id 
	FROM film_actor
	WHERE film_id IN
		(SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
	)
);

-- 7c.
SELECT c.first_name, c.last_name, c.email
From customer AS c
JOIN address as a ON c.address_id = a.address_id
JOIN city as ci ON a.city_id = ci.city_id 
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country = "Canada";

-- 7d.
SELECT f.title
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = "Family";

-- 7e.
SELECT f.title, COUNT(r.inventory_id) AS "Total Rented"
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r on i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY COUNT(r.inventory_id) DESC;

-- 7f.
SELECT s.store_id, SUM(p.amount) AS "Total Sales"
FROM store AS s JOIN customer AS c ON (s.store_id = c.store_id)
JOIN payment AS p ON (c.customer_id = p.customer_id)
GROUP BY s.store_id;

-- 7g.
SELECT s.store_id, c.city, co.country
FROM store AS s JOIN address AS a ON (s.address_id = a.address_id)
JOIN city AS c ON (c.city_id = a.city_id)
JOIN country AS co ON (co.country_id = c.country_id);

-- 7h.
SELECT c.name, sum(p.amount) AS "Gross Revenue"
FROM category c JOIN film_category fc ON(c.category_id = fc.category_id)
JOIN inventory i ON (fc.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name
ORDER BY sum(p.amount) DESC
LIMIT 5;


-- 8a.
CREATE VIEW top_five_genres AS
SELECT c.name, sum(p.amount) AS "Gross Revenue"
FROM category c JOIN film_category fc ON(c.category_id = fc.category_id)
JOIN inventory i ON (fc.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name
ORDER BY sum(p.amount) DESC
LIMIT 5;

-- 8b.
SELECT * FROM top_five_genres;

-- 8c.
DROP VIEW top_five_genres;
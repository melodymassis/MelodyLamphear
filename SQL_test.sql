-- 1a. Display the first and last names of all actors from the table actor.

USE sakila;

SELECT
a.first_name,
a.last_name

FROM
actor AS a;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

USE sakila;
SELECT
CONCAT(a.first_name, a.last_name) AS ACTOR_NAME

FROM
actor AS a;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
USE sakila;
SELECT
a.first_name,
a.last_name

FROM
actor AS a

WHERE
a.first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters GEN:

USE sakila;
SELECT
a.first_name,
a.last_name

FROM
actor AS a

WHERE
a.last_name like '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:

USE sakila;
SELECT
a.first_name,
a.last_name

FROM
actor AS a

WHERE
a.last_name like '%LI%'
Order by a.last_name, a.first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:

USE sakila;

SELECT
c.country_id,
c.country

FROM
country as c

WHERE
c.country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.

USE sakila;

ALTER TABLE actor
ADD middle_name varchar(30) AFTER first_name;

-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.

ALTER TABLE actor
MODIFY COLUMN middle_name varchar(60);

-- 3c. Now delete the middle_name column.

ALTER TABLE actor
DROP COLUMN middle_name;

-- 4a. List the last names of actors, as well as how many actors have that last name.

SELECT
a.last_name,
COUNT(a.last_name)

FROM
actor as a

GROUP BY
last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
 
SELECT
 c.Last_Name_CNT,
 c.last_name
 
 FROM
 
	(SELECT
	a.last_name,
	COUNT(a.last_name) as Last_Name_CNT

	FROM
	actor as a

	GROUP BY
	last_name) as c

WHERE
c.Last_Name_CNT >=2;
 
 
-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.

-- Find

SELECT
a.first_name,
a.last_name

FROM
actor as a

WHERE
a.first_name in ('GROUCHO')
AND a.last_name in ('WILLIAMS');

-- Change

UPDATE 
actor

SET 
first_name = 'HARPO'

WHERE
first_name in ('GROUCHO')
AND last_name in ('WILLIAMS')
;

-- Validate

SELECT
a.first_name,
a.last_name

FROM
actor as a

WHERE
a.first_name in ('HARPO')
AND a.last_name in ('WILLIAMS');

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, 
-- if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is 
-- exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, 
-- HOWEVER! (Hint: update the record using a unique identifier.)

-- --DUPLICATE TABLE JUST IN CASE
DROP TABLE IF EXISTS actor_dup;
CREATE TABLE actor_dup
SELECT 
actor_id,
first_name,
last_name,
last_update

FROM
actor;


-- Change
-- 
UPDATE 
actor_dup

SET 
first_name = 
(CASE
			WHEN first_name in ('HARPO') AND last_name in ('WILLIAMS')
			THEN 'GROUCHO'
            WHEN first_name in ('GROUCHO') AND last_name in ('WILLIAMS')
			THEN 'MUCHO GROUCHO'
END)
 
 WHERE 
	first_name in ('HARPO') AND Last_name in ('WILLIAMS')
 OR
	first_name in ('GROUCHO') AND last_name in ('WILLIAMS')
;
-- 
-- VALIDATE

SELECT
a.first_name,
COUNT(a.first_name)

FROM
actor_dup as a

GROUP BY
first_name;

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?

-- Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html

SHOW create table address;
SHOW schemas;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

-- Understanding data structure:

SELECT *
FROM
address;

SELECT *
FROM
staff;

-- Query:
SELECT
ad.address_id,
s.first_name,
s.last_name,
ad.address

FROM
address as ad

JOIN staff as s  
ON ad.address_id = s.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
-- Understanding data structure:

SELECT *
FROM
payment;

SELECT *
FROM
staff;

-- Query:
SELECT
s.staff_id,
s.first_name,
s.last_name,
SUM(p.amount)

FROM
payment as p

JOIN staff as s
ON s.staff_id = p.staff_id

GROUP BY p.staff_id, s.first_name, s.last_name;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

SELECT
f.film_id,
f.title,
COUNT(fa.actor_id)

FROM
film as f

JOIN film_actor as fa
ON f.film_id = fa.film_id

GROUP BY f.film_id,
f.title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT
f.film_id,
f.title,
COUNT(i.inventory_id)

FROM
film as f

JOIN inventory as i
ON f.film_id = i.film_id

WHERE
f.title = 'Hunchback Impossible'

GROUP BY f.film_id,
f.title;


-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
--     ![Total amount paid](Images/total_payment.png)

SELECT
c.last_name,
c.first_name,
SUM(p.amount)

FROM
customer as c

JOIN payment as p
ON c.customer_id = p.customer_id
GROUP BY c.last_name, c.first_name
ORDER BY c.last_name
;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have 
-- also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

-- Find english:
SELECT
l.language_id,
l.name

FROM
language as l
;


SELECT
x.title

FROM (
SELECT 
f.title

FROM
film as f

WHERE
language_id = 1) as x

WHERE
x.title like 'K%' 
OR x.title like 'Q%'

;

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT 
y.actor_id

FROM (

SELECT
f.title,
fa.actor_id

FROM
film as f

JOIN film_actor as fa
ON f.film_id = fa.film_id
) AS y

WHERE
y.title = 'Alone Trip'
;

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.

-- 7e. Display the most frequently rented movies in descending order.

-- 7f. Write a query to display how much business, in dollars, each store brought in.

-- 7g. Write a query to display for each store its store ID, city, and country.

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a 
-- view. If you haven't solved 7h, you can substitute another query to create a view.

-- 8b. How would you display the view that you created in 8a?
 
-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
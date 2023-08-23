-- The following are some queries for the explaination purpose. The sakila schema has been used to implement these commands.
-- Feel free to uncomment and run the queries. 


-- Use of select, from, where, ORDER BY and LIMIT.........................................................................................
 
-- SELECT first_name, last_name
-- FROM customer
-- WHERE active = 1
-- ORDER BY last_name ASC
-- LIMIT 10;


-- Inserting record to customer table...................................................................................................

-- INSERT INTO customers (first_name, last_name, email)
-- VALUES ('John', 'Doe', 'john@example.com');


-- Updating the info.....................................................................................................................

-- UPDATE film
-- SET rental_duration = rental_duration - 1
-- WHERE film_id = 123;


-- deleted a record.......................................................................................................................

-- DELETE FROM payment
-- WHERE payment_date < '2005-05-28';


-- left join performed aling with some conditions.............................................................................................

-- SELECT customer.address_id, COUNT(address.phone) AS order_count
-- FROM customer
-- LEFT JOIN address ON customer.address_id = address.address_id
-- WHERE customer.store_id = 1
-- GROUP BY customer.customer_id;


-- Using UNION and GROUP BY..................................................................................................................

-- SELECT first_name FROM customer
-- WHERE active = 1
-- UNION
-- SELECT phone FROM address
-- WHERE address_id < 100
-- GROUP BY phone;


-- usage of where exist.......................................................................................................................

-- SELECT c.name AS category
-- FROM category c
-- JOIN film_category fc ON c.category_id = fc.category_id
-- JOIN film f ON fc.film_id = f.film_id
-- WHERE EXISTS (
--     SELECT 1 FROM film_actor fa
--     JOIN actor a ON fa.actor_id = a.actor_id
--     WHERE fa.film_id = f.film_id
--     AND a.first_name = 'Quentin' AND a.last_name = 'Tarantino'
-- )
-- GROUP BY c.name;


-- Insert data into the high_sales table......................................................................................................

-- CREATE TABLE high_repCost (
--     film_id INT,
--     release_year INT
-- );
-- INSERT INTO high_repCost
-- SELECT p.film_id, p.release_year
-- FROM film p
-- WHERE p.replacement_cost > ALL (
--     SELECT AVG(s.replacement_cost) FROM film s
-- );


-- Q:You want to analyze the top 10 customers who have rented the most films,
--  including their total rental count and the average rental duration.....................................................................

-- SELECT
--     c.customer_id,
--     CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
--     COUNT(r.rental_id) AS total_rentals,
--     AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration
-- FROM customer c
-- JOIN rental r ON c.customer_id = r.customer_id
-- GROUP BY c.customer_id
-- ORDER BY total_rentals DESC
-- LIMIT 10;


-- Q: You want to recommend films to customers based on their rental history
-- and the most popular films in their favorite category..........................................................................................

-- SELECT
--     c.customer_id,
--     CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
--     (
--         SELECT f2.title
--         FROM inventory i2
--         JOIN film f2 ON i2.film_id = f2.film_id
--         WHERE i2.inventory_id = (
--             SELECT r2.inventory_id
--             FROM rental r2
--             WHERE r2.customer_id = c.customer_id
--             ORDER BY r2.rental_date DESC
--             LIMIT 1
--         )
--     ) AS recommended_film
-- FROM customer c;


-- Q: You want to analyze the inventory of films, including the number of available copies, rented copies, and total revenue for each film..................

-- SELECT
--     f.film_id,
--     f.title,
--     COUNT(i.inventory_id) AS total_copies,
--     COUNT(CASE WHEN r.return_date IS NULL THEN 1 END) AS rented_copies,
--     SUM(CASE WHEN r.return_date IS NOT NULL THEN p.amount END) AS total_revenue
-- FROM film f
-- JOIN inventory i ON f.film_id = i.film_id
-- LEFT JOIN rental r ON i.inventory_id = r.inventory_id
-- LEFT JOIN payment p ON r.rental_id = p.rental_id
-- GROUP BY f.film_id, f.title
-- ORDER BY total_revenue DESC;

-- You want to compare the monthly revenue from rentals and sales over a certain period

-- SELECT
--     MONTH(payment_date) AS month,
--     SUM(CASE WHEN rental_id IS NOT NULL THEN amount END) AS rental_revenue,
--     SUM(CASE WHEN rental_id IS NULL THEN amount END) AS sales_revenue
-- FROM payment
-- GROUP BY month
-- ORDER BY month;



-- Some advance funtions..............................................................................................................................

-- SELECT BIN(12); -- Returns '1100'

-- SELECT BINARY 'Hello'; -- Returns 'Hello'

-- SELECT CAST('42' AS int); Converts '42' to the integer 42

-- SELECT COALESCE(NULL, 'Value', 42); -- Returns 'Value'

-- SELECT CONNECTION_ID(); -- Returns the unique connection ID

-- SELECT CONV('1A', 16, 10); -- Converts hexadecimal '1A' to decimal 26

-- SELECT CONVERT('42', SIGNED); -- Converts '42' to the signed integer 42

-- SELECT CURRENT_USER(); -- Returns 'user_name'@'host_name'

-- SELECT DATABASE(); -- Returns the current database name

-- SELECT IF(salary > 50000, 'High', 'Low') AS salary_status FROM employees;

-- SELECT IFNULL(salary, 0) AS salary FROM employees;

-- SELECT ISNULL(salary) AS is_salary_null FROM employees;

-- INSERT INTO orders (customer_id, total_amount) VALUES (123, 150);
-- SELECT LAST_INSERT_ID(); -- Returns the auto-generated ID for the order

-- SELECT NULLIF(10, 10); -- Returns NULL since the two values are equal

-- SELECT SESSION_USER(); -- Returns 'user_name'@'host_name'

-- SELECT SYSTEM_USER(); -- Returns 'user_name'@'host_name'

-- SELECT USER(); -- Returns 'user_name'@'host_name'

-- SELECT VERSION(); -- Returns the current MySQL version



/* d1. */
SELECT c.value_in_debt FROM clients c WHERE c.first_name = 'Sara' AND c.last_name='Lopes';
-- or
SELECT c.value_in_debt FROM clients AS c WHERE c.first_name = 'Sara' AND c.last_name='Lopes';

/* d2. */
SELECT name FROM movies
WHERE genre = 'Action' AND rating > 8.5;

/* d3. */
SELECT street, city, zip_code
FROM clients
WHERE first_name = 'Joao' AND last_name = 'Townsend';

/* d4. */
UPDATE clients
SET phone = '999867874'
WHERE first_name = 'Sara' AND last_name = 'Lopes';

/* d5. */
SELECT COUNT(*) total_loaned_movies FROM copies_on_loan;
-- or
SELECT COUNT(*) AS total_loaned_movies FROM copies_on_loan;

/* d6. */
SELECT name, rating FROM movies
ORDER BY rating DESC
LIMIT 3;

/* d7. */
SELECT movie_tier, SUM(rating) total_rating
FROM movies
GROUP BY movie_tier;

/* d8. */
SELECT price FROM movies m
JOIN prices p ON m.movie_tier = p.movie_tier
WHERE m.name = 'Ready Player One';

/* d9. */
SELECT m.name FROM movies m
JOIN actors_per_movie apm ON m.id = apm.movies_id
JOIN actors as act ON apm.actors_id = act.id
WHERE act.first_name = 'Scarlett' AND act.last_name = 'Johansson';

/* d10. */
SELECT a.name attendant_name FROM loans l
JOIN clients c ON l.client_id = c.id
JOIN attendant a ON l.attendant_id = a.id
WHERE c.value_in_debt > 6;

/* d11. */
SELECT CAST(AVG(c.age) AS INTEGER) average_age FROM clients c
JOIN movies_per_client mpc ON c.id = mpc.client_id
JOIN movies m ON mpc.movie_id = m.id
WHERE m.name = 'Ghost in the Shell';

/* d12. */
SELECT COUNT(*) count_of_copies_not_on_loan
FROM copies c
LEFT JOIN copies_on_loan col ON c.id = col.copies_id
JOIN movies m ON c.movies_id = m.id
WHERE m.name = 'I, Robot'
AND col.loans_id IS NULL;

/* d13. */
SELECT c.first_name, c.last_name
FROM clients c
JOIN movies_per_client mpc ON c.id = mpc.client_id
JOIN movies m ON mpc.movie_id = m.id
WHERE m.movie_tier = 'Super'
UNION
SELECT first_name, last_name
FROM clients
WHERE value_in_debt > 5.00;

/* d14. */
DELETE FROM copies
WHERE id IN (
    SELECT c.id
    FROM copies c
    JOIN movies m ON c.movies_id = m.id
    WHERE m.name = 'I, Robot'
    LIMIT 1
);

/* d15. */
SELECT m.name
FROM movies m
JOIN actors_per_movie apm ON m.id = apm.movies_id
JOIN actors a ON apm.actors_id = a.id
WHERE a.first_name = 'Scarlett' AND a.last_name = 'Johansson'
AND m.id NOT IN (
    SELECT movie_id
    FROM movies_per_client mpc
    JOIN clients c ON mpc.client_id = c.id
    WHERE c.first_name = 'Joao' AND c.last_name = 'Townsend'
);

/* d16.*/
SELECT m.name AS movie_name, l.due_date
FROM movies m
JOIN copies c ON m.id = c.movies_id
JOIN copies_on_loan col ON c.id = col.copies_id
JOIN loans l ON col.loans_id = l.id
JOIN clients cl ON l.client_id = cl.id
WHERE cl.first_name = 'Joao' AND cl.last_name = 'Oliveira';

/* d17. */
SELECT SUM(l.value) total_revenue
FROM movies m
JOIN copies c ON m.id = c.movies_id
JOIN copies_on_loan col ON c.id = col.copies_id
JOIN loans l ON col.loans_id = l.id
WHERE m.name = 'Ghost in the Shell'
AND l.start_date >= CURRENT_DATE - INTERVAL '2 weeks';


SELECT * FROM payment LIMIT 5; # rental_id
SELECT * FROM rental LIMIT 5; # rental_id, inventory_id
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id
SELECT * FROM film_category LIMIT 5; # film_id, category_id
SELECT * FROM category LIMIT 5; # category_id

WITH genre_revenue AS (
	SELECT
		C.name genre,
		SUM(amount) revenue
    FROM payment P
    JOIN rental R ON R.rental_id = P.rental_id
    JOIN inventory I ON I.inventory_id = R.inventory_id
    JOIN film_category FC ON FC.film_id = I.film_id
    JOIN category C ON C.category_id = FC.category_id
    GROUP BY genre
)
SELECT
	genre,
    revenue,
    SUM(revenue) OVER (ORDER BY revenue DESC
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_revenue,
	revenue / SUM(revenue) OVER () revenue_ratio
FROM genre_revenue
ORDER BY revenue DESC;
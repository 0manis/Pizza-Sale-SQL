-- Qn4 Identify the most common pizza size ordered.

SELECT 
    pizzas.size, COUNT(pizzas.size) AS number_of_pizzas
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY number_of_pizzas DESC
LIMIT 1;
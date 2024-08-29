-- Qn10 Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name , sum(order_details.quantity*pizzas.price) as revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    join order_details on order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.name
ORDER by revenue DESC
LIMIT 3;
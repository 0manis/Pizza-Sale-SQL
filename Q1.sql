-- Qn1 Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_number_of_orders
FROM
    orders;


-- Qn2 Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;


 -- Qn 3 Identify the highest-priced pizza.
 SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


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


-- Qn5 List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;
 
 

                                 -- Intermediate 
-- Qn1 Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;



-- Qn2 Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(time);





-- Qn4  Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza_perday
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS order_quantity;





-- Qn5 Determine the top 3 most ordered pizza types based on revenue.
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




                             Advanced:
-- Qn1 Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category,
 round(sum(order_details.quantity*pizzas.price)/( SELECT 
       round(sum(order_details.quantity*pizzas.price),2) as total_sales
FROM
order_details
   
        JOIN
    pizzas ON pizzas.pizza_id =order_details.pizza_id) *100,2) as revenue
from pizza_types
join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by revenue desc ;




-- Qn2 Analyze the cumulative revenue generated over time.
select date,
sum(revenue) over(order by date) as cum_revenue
from 
 (select orders.date, sum(order_details.quantity*pizzas.price) as revenue
from order_details 
join pizzas on order_details.pizza_id=pizzas.pizza_id
join orders on orders.order_id=order_details.order_id
group by orders.date) as sales;
    

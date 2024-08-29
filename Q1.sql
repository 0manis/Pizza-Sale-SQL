-- Qn1 Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_number_of_orders
FROM
    orders;
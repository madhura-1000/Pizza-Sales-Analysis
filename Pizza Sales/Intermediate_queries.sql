-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT SUM(quantity),category
FROM order_details JOIN pizzas
	On order_details.pizza_id=pizzas.pizza_id
    JOIN pizza_types 
		ON pizzas.pizza_type_id=pizza_types.pizza_type_id
GROUP BY category;


-- Determine the distribution of orders by hour of the day.
SELECT hour(order_time) as hour , count(order_id) as order_count FROM orders
GROUP BY hour;


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT count(name),category FROM pizza_types
GROUP BY category; 


-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT round(AVG(total_orders),0) FROM
(SELECT order_date,sum(quantity) AS total_orders
FROM orders JOIN order_details
	ON orders.order_id=order_details.order_id
GROUP BY order_date) AS day_orders;


-- Determine the top 3 most ordered pizza types based on revenue.
SELECT name, SUM(quantity*price) as revenue
FROM pizza_types JOIN pizzas
	ON pizza_types.pizza_type_id=pizzas.pizza_type_id
    JOIN order_details
		ON pizzas.pizza_id=order_details.pizza_id
GROUP BY name ORDER BY revenue DESC limit 3;
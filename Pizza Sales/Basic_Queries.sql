CREATE DATABASE pizza;
USE pizza;

-- Basic:
-- Retrieve the total number of orders placed.
SELECT count(order_id) as total_orders FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT round(sum(order_details.quantity*pizzas.price),2) as revenue
FROM order_details JOIN pizzas
on order_details.pizza_id=pizzas.pizza_id ;


-- Identify the highest-priced pizza.
SELECT name,price 
FROM pizza_types JOIN pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by price desc LIMIT 1;


-- Identify the most common pizza size ordered.
SELECT count(order_details.order_id) as common_size,pizzas.size 
FROM order_details JOIN pizzas 
on order_details.pizza_id=pizzas.pizza_id 
group by pizzas.size order by common_size desc;


-- List the top 5 most ordered pizza types along with their quantities.
SELECT sum(order_details.quantity) as most_ord,pizza_types.name
FROM order_details JOIN pizzas 
on order_details.pizza_id=pizzas.pizza_id
JOIN pizza_types 
on pizzas.pizza_type_id=pizza_types.pizza_type_id 
GROUP BY pizza_types.name ORDER BY most_ord desc limit 5;



-- Hard:
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    category,
    CONCAT(ROUND((SUM(quantity * price) / (SELECT 
                            SUM(price * quantity)
                        FROM
                            pizza_types
                                JOIN
                            pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
                                JOIN
                            order_details ON pizzas.pizza_id = order_details.pizza_id) * 100),
                    2),
            '%') AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category;


-- Analyze the cumulative revenue generated over time.
SELECT order_date,SUM(revenue) OVER(order by order_date) as cum_revenue FROM ( 
SELECT order_date,SUM(quantity*price) as revenue
FROM pizzas JOIN order_details
ON pizzas.pizza_id=order_details.pizza_id
JOIN orders ON order_details.order_id=orders.order_id
GROUP BY order_date) as sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT category, name, revenue, rn
FROM (
    SELECT pt.category,
           pt.name,
           SUM(od.quantity * p.price) AS revenue,
           RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rn
    FROM pizza_types pt
    JOIN pizzas p
        ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od
        ON p.pizza_id = od.pizza_id
    GROUP BY pt.category, pt.name
) ranked_data
WHERE rn <= 3
ORDER BY category, rn;
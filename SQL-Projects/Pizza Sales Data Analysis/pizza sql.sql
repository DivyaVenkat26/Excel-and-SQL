Create database pizza_sales;
use pizza_sales;
-- 1.Retrieve the total number of orders placed.
SELECT 
    COUNT( distinct order_id) as total_orders
FROM
    order_details;
-- 2.Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(p.price * o.quantity), 2) AS total_revenue
FROM
    pizzas AS p
        JOIN
    order_details AS o ON p.pizza_id = o.pizza_id;
-- 3.Identify the highest-priced pizza
SELECT 
    pt.name as Highest_Priced_Pizza, pz.price AS Price
FROM
    pizzas AS pz
        JOIN
    pizza_types AS pt ON pz.pizza_type_id = pt.pizza_type_id
ORDER BY Price DESC
LIMIT 1;
-- 4.Identify the most common pizza size ordered.
SELECT 
    pz.size, COUNT(o.order_id) AS Total_orders
FROM
    pizzas AS pz
        JOIN
    order_details AS o ON pz.pizza_id = o.pizza_id
GROUP BY pz.size
ORDER BY Total_orders DESC;
-- 5.List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name AS Most_Ordered_Pizza_Types, SUM(o.quantity) AS quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS pz ON pt.pizza_type_id = pz.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = pz.pizza_id
GROUP BY name
ORDER BY quantity DESC
LIMIT 5;
-- 6.Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(o.quantity) AS quantity
FROM
    order_details AS o
        JOIN
    pizzas AS pz ON pz.pizza_id = o.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = pz.pizza_type_id
GROUP BY category
ORDER BY quantity DESC;
-- 7.Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(time) AS hour, COUNT(order_id) AS num_of_orders
FROM
    orders
GROUP BY hour
ORDER BY num_of_orders DESC;
-- 8.Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS distibution_of_pizzas
FROM
    pizza_types
GROUP BY category;
-- 9.Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 2) AS Average_Pizza_Ordered_Per_Day
FROM
    (SELECT 
        o.date, SUM(od.quantity) AS quantity
    FROM
        orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY date) AS order_quantity;
-- 10.Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pt.name AS Most_Ordered_Pizza,
    SUM(o.quantity * pz.price) AS revenue
FROM
    pizza_types AS pt
        JOIN
    pizzas AS pz ON pt.pizza_type_id = pz.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = pz.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;
-- 11. Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.category AS Category,
  round(  (SUM(o.quantity * pz.price)*100)/(SELECT 
    (SUM(pz.price * o.quantity)) AS total_revenue
FROM
    pizzas AS pz
        JOIN
    order_details AS o ON pz.pizza_id = o.pizza_id),2)as revenue_percentage
FROM
    pizza_types AS pt
        JOIN
    pizzas AS pz ON pt.pizza_type_id = pz.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = pz.pizza_id
GROUP BY category
ORDER BY revenue_percentage DESC;
-- 12.Analyze the cumulative revenue generated over time.
select date,round(sum(revenue) over(order by date),2) as cumulative_revenue from(
SELECT 
  ord.date as date,
    round(SUM(o.quantity * pz.price),2) AS revenue
FROM
    orders as ord
        JOIN
    order_details AS o ON ord.order_id = o.order_id
    join
    pizzas as pz on pz.pizza_id=o.pizza_id
GROUP BY date) as sales;
-- 13.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with ranked_pizzas as (SELECT 
    pt.name AS Name,pt.category as Category,
    Round(SUM(o.quantity * pz.price),2) AS revenue,
    row_number() over (partition by pt.category order by Round(SUM(o.quantity * pz.price),2) desc) as ranked_category
FROM
    pizza_types AS pt
        JOIN
    pizzas AS pz ON pt.pizza_type_id = pz.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = pz.pizza_id
GROUP BY pt.category,pt.name
ORDER BY revenue DESC)
select Name,Category,revenue from ranked_pizzas where ranked_category<=3 order by category,revenue desc;
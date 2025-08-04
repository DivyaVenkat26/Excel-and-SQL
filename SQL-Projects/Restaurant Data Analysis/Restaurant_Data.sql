use restaurant;
-- View the items on menu 
SELECT 
    *
FROM
    menu_items;
-- 1.Find the number of items on the menu
SELECT 
    COUNT(item_name) AS no_of_items
FROM
    menu_items;
-- 2.What are the least and most expensive items on the menu?
-- Most Expensive Item on the menu
SELECT 
    *
FROM
    menu_items
ORDER BY price DESC
LIMIT 1;
-- Least Expensive Item on the menu
SELECT 
    *
FROM
    menu_items
ORDER BY price ASC
LIMIT 1;
-- 3.How many Italian dishes are on the menu? 
SELECT 
    COUNT(*) AS num_of_italain_dishes
FROM
    menu_items
WHERE
    category = 'Italian';
-- 5.How many dishes are on each category? 
SELECT 
    category, COUNT(*) AS number_of_items
FROM
    menu_items
GROUP BY category;
  --  4.What are the least and most Italian dishes on the menu?
   --  Least Expensive Italian Dish 
SELECT 
    *
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY price ASC
LIMIT 2;
-- Most Expensive Italian Dish 
SELECT 
    *
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY price Desc
LIMIT 1;

-- 6.What is the average dish price within each category?
    SELECT 
    category, ROUND(AVG(price), 2) AS avg_price_category_wise
FROM
    menu_items
GROUP BY category;
select * from order_details;
-- 7.What is the date range of the table?
SELECT 
    MIN(order_date) AS first_date, MAX(order_date) AS last_date
FROM
    order_details;
-- 8. How many orders were made within this date range?
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM
    order_details; 
-- 9.How many items were ordered within this date range?
SELECT 
    COUNT(item_id) AS number_of_items
FROM
    order_details;
-- 10. Which orders had the most numbers of items?
SELECT 
    order_id, COUNT(item_id) AS count_of_items_ordered
FROM
    order_details
GROUP BY order_id
ORDER BY COUNT(item_id) DESC;


-- 11.How many orders had more than 12 items?
SELECT 
  order_id,
  COUNT(item_id) AS items_per_order
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12;
select * from order_details;
select * from menu_items;
select * from order_details as o left join menu_items as m on o.item_id = m.ï»¿menu_item_id;
-- 12. What were the least and most ordered items? What category were they in?
-- Least Ordered Item 
SELECT 
    m.item_name, m.category, COUNT(item_id) AS Total_orders
FROM
    order_details AS o
        JOIN
    menu_items AS m ON o.item_id = m.ï»¿menu_item_id
GROUP BY item_id , item_name , category
ORDER BY Total_orders ASC
LIMIT 1
 --  13. What were the top 5 orders that spent the most money ?
SELECT 
    o.order_id, ROUND(SUM(m.price), 2) AS Total_Spend
FROM
    order_details AS o
        JOIN
    menu_items AS m ON o.item_id = m.ï»¿menu_item_id
GROUP BY o.order_id
ORDER BY Total_Spend DESC
LIMIT 5
-- 14.View the details of the highest spend order.What insights can you gather? 
SELECT 
    m.category, COUNT(o.item_id) AS num_of_items
FROM
    order_details AS o
        JOIN
    menu_items AS m ON o.item_id = m.ï»¿menu_item_id
WHERE
    order_id = 440
GROUP BY category;
-- 15.View the details of the top 5 highest spend orders. What insights can you gather?
SELECT 
    m.category, COUNT(o.item_id) AS num_of_items
FROM
    order_details AS o
        JOIN
    menu_items AS m ON o.item_id = m.ï»¿menu_item_id
WHERE
    order_id IN (440 , 2075, 1957, 330, 2675)
GROUP BY category
ORDER BY num_of_items DESC








    

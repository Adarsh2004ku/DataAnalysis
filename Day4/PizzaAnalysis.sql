SELECT * FROM PIZZAHUT.pizzas;
show tables;

select * from order_details;
#Basic:
#1 Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

#2 Calculate the total revenue generated from pizza sales.

select 
round(sum(order_details.quantity * pizzas.price),2)
from order_details join pizzas 
on pizzas.pizza_id = order_details.pizza_id;

#3 Identify the highest-priced pizza.
select pizzas_types.name , pizzas.price
from pizzas_types join pizzas
on pizzas_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

#4 Identify the most common pizza size ordered.
select pizzas.size,count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size order by order_count desc;

#5 List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizzas_types.name,
    SUM(order_details.quantity) AS total_quantity_ordered
FROM
    pizzas_types
        JOIN
    pizzas ON pizzas_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas_types.name
ORDER BY total_quantity_ordered DESC
LIMIT 5;



# 6 Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizzas_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizzas_types
        JOIN
    pizzas ON pizzas_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas_types.name
ORDER BY quantity DESC limit 5;


# 7 Determine the distribution of orders by hour of the day.
select hour(order_time) as hour,count(order_id) from orders
group by hour(order_time);


# 8 Join relevant tables to find the category-wise distribution of pizzas.
select category , count(name) from pizzas_types
group by category ;


# 9 Group the orders by date and calculate the average number 
-- of pizzas ordered per day.

select date(order_date) as date,count(order_id)  as sale_per_day from orders
group by date(order_date);

SELECT round(AVG(daily_quantity),2) AS average_daily_order_quantity
FROM (
    SELECT orders.order_date, SUM(order_details.quantity) AS daily_quantity
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS daily_orders;


# 10 Determine the top 3 most ordered pizza types based on revenue.

select pizzas_types.name,
sum(order_details.quantity * pizzas.price )as revenue
from pizzas_types join pizzas on pizzas.pizza_type_id = pizzas_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizzas_types.name 
order by revenue desc limit 3;

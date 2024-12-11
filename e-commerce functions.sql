-- 1. Calculate Average Order Value
SELECT 
    o.order_id, 
    AVG(od.quantity * od.price_per_product) AS average_order_value
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

-- 2. Count Orders by Status
SELECT 
    o.order_status, 
    COUNT(o.order_id) AS order_count
FROM orders o
GROUP BY o.order_status;

-- 3. Find Highest and Lowest Priced Products
-- Highest Priced Product
SELECT 
    p.product_id, 
    p.name, 
    p.price
FROM products p
WHERE p.price = (SELECT MAX(price) FROM products);

-- Lowest Priced Product
SELECT 
    p.product_id, 
    p.name, 
    p.price
FROM products p
WHERE p.price = (SELECT MIN(price) FROM products);

-- 4. Calculate Total Quantity Sold per Product
SELECT 
    p.product_id, 
    p.name, 
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id;

-- 5. Calculate Total Sales Revenue per Day
SELECT 
    DATE(o.order_date) AS order_date, 
    SUM(od.quantity * od.price_per_product) AS total_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY DATE(o.order_date);

-- 6. List Customers with Total Amount Spent
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(od.quantity * od.price_per_product) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id;

-- 7. Calculate Average Order Quantity per Product
SELECT 
    p.product_id, 
    p.name, 
    AVG(od.quantity) AS avg_quantity
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id;

-- 8. Bonus: Find Top 5 Customers by Total Spending
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(od.quantity * od.price_per_product) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Simplified Reflection:
-- Aggregate functions like `SUM()` and `AVG()` provide key insights such as total revenue, average order values, and customer spending patterns.
-- Combining functions like `SUM()` with `DATE()` allows for temporal analyses, such as daily sales trends.
-- Limiting results, such as identifying the top 5 customers, is essential for focusing on high-value entities, aiding targeted marketing and resource allocation.

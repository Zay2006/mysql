-- 1. Retrieve Customer Order Details
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    o.order_id, 
    o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered';

-- 2. Get Detailed Order Items for a Specific Order
SELECT 
    od.order_id, 
    od.product_id, 
    p.name, 
    od.quantity, 
    od.price_per_product
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE od.order_id = 1
ORDER BY od.product_id ASC;

-- 3. List Orders with Customer Information
SELECT 
    o.order_id, 
    o.order_date, 
    o.order_status, 
    c.first_name, 
    c.last_name, 
    c.email
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Pending';

-- 4. Calculate Total Sales per Customer
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(od.quantity * od.price_per_product) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id;

-- 5. Find Products Ordered by Multiple Customers
SELECT 
    p.product_id, 
    p.name, 
    COUNT(DISTINCT o.customer_id) AS customer_count
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
GROUP BY p.product_id
HAVING customer_count > 1;

-- 6. Display All Product Sales with Quantities and Customers
SELECT 
    p.product_id, 
    p.name, 
    od.quantity, 
    c.customer_id, 
    c.first_name
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY p.product_id, c.customer_id;

-- 7. Bonus: Complex Join with Aggregation
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(o.order_id) AS total_orders, 
    SUM(od.quantity * od.price_per_product) AS total_amount_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id
ORDER BY total_amount_spent DESC;

-- Simplified Reflection:
-- Joining tables enables a comprehensive view of customer orders, product details, and sales data, facilitating deeper insights.
-- The most challenging joins involve multiple tables with aggregation, as they require careful consideration of grouping and relationships.
-- These techniques are crucial for reporting, such as tracking sales trends, identifying high-value customers, and optimizing inventory.

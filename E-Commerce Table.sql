-- Create and use a new database
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- Create the Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create the Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create the Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create the Order Details table
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_product DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into Customers table
INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, zip_code)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'New York', 'NY', '10001'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Elm St', 'Los Angeles', 'CA', '90001');

-- Insert sample data into Products table
INSERT INTO products (name, description, price, stock_quantity)
VALUES
('Laptop', 'A high-performance laptop', 999.99, 10),
('Smartphone', 'A smartphone with excellent camera', 699.99, 20),
('Headphones', 'Noise-cancelling over-ear headphones', 199.99, 50);

-- Insert a sample order into Orders table
INSERT INTO orders (customer_id, total_amount)
VALUES
(1, 1899.97);

-- Insert sample data into Order Details table
INSERT INTO order_details (order_id, product_id, quantity, price_per_product)
VALUES
(1, 1, 1, 999.99),
(1, 2, 1, 699.99),
(1, 3, 1, 199.99);

-- Query to retrieve all orders for a specific customer
SELECT order_id, order_date
FROM orders
WHERE customer_id = 1;

-- Query to retrieve details for a specific order
SELECT p.name, od.quantity, od.price_per_product
FROM order_details od
JOIN products p ON od.product_id = p.product_id
WHERE od.order_id = 1;

-- Update stock quantity after an order
UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;

-- Optional Enhancements
-- Add a category column to Products table
ALTER TABLE products
ADD category VARCHAR(50);

-- Create a Customer Addresses table for multiple addresses
CREATE TABLE customer_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Add a shipment_date column to Orders table
ALTER TABLE orders
ADD shipment_date DATETIME;

-- Simplified Reflection:
-- This schema links customers, products, and orders effectively through foreign keys, ensuring data consistency. 
-- Challenges included designing relationships and managing cascading updates or deletions.
 
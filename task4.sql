-- ==================================================
-- TASK 4: SQL for Data Analysis (MySQL)
-- Final Script (No FK errors, No Ambiguous Columns)
-- ==================================================

-- 1. Create Fresh Database
DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- 2. Create Tables (Correct Order)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3. Disable Foreign Key Checks for Data Insert
SET FOREIGN_KEY_CHECKS = 0;

-- Insert Customers
INSERT INTO customers (customer_name, country) VALUES
('Alice Johnson', 'USA'),
('Bob Smith', 'UK'),
('Charlie Davis', 'USA'),
('Diana Prince', 'Canada'),
('Ethan Hunt', 'Australia');

-- Insert Products
INSERT INTO products (product_name, category, price) VALUES ('Laptop', 'Electronics', 1200.00);
INSERT INTO products (product_name, category, price) VALUES ('Smartphone', 'Electronics', 800.00);
INSERT INTO products (product_name, category, price) VALUES ('Desk Chair', 'Furniture', 150.00);
INSERT INTO products (product_name, category, price) VALUES ('Headphones', 'Electronics', 200.00);
INSERT INTO products (product_name, category, price) VALUES ('Coffee Table', 'Furniture', 300.00);

-- Insert Orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-15', 2000.00),
(2, '2024-02-10', 800.00),
(3, '2024-03-05', 350.00),
(4, '2024-04-20', 1200.00),
(1, '2024-05-25', 1500.00);

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 800.00),
(2, 2, 1, 800.00),
(3, 3, 1, 150.00),
(3, 5, 1, 200.00),
(4, 4, 2, 400.00),
(4, 1, 1, 800.00),
(5, 1, 1, 1200.00),
(5, 4, 1, 300.00);

-- Re-enable Foreign Key Checks
SET FOREIGN_KEY_CHECKS = 1;

-- 4. Basic SELECT, WHERE, ORDER BY
SELECT * FROM customers 
WHERE country = 'USA' 
ORDER BY customer_name ASC;

-- 5. Aggregations & GROUP BY (Fixed to avoid ambiguous 'price')
SELECT p.category, SUM(oi.price * oi.quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 6. INNER JOIN
SELECT o.order_id, c.customer_name, o.order_date, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 7. LEFT JOIN
SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 8. Subquery: Customers above avg total order value
SELECT customer_id, customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING AVG(total_amount) > (
        SELECT AVG(total_amount) FROM orders
    )
);

-- 9. Create a View
CREATE OR REPLACE VIEW monthly_sales AS
SELECT MONTH(order_date) AS month, SUM(total_amount) AS total_sales
FROM orders
GROUP BY MONTH(order_date);

-- 10. Optimize: Add Indexes
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_order_date ON orders(order_date);

-- 11. View Output
SELECT * FROM monthly_sales;

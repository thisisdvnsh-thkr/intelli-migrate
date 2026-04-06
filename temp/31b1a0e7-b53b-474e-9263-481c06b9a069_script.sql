-- ============================================
-- Intelli-Migrate Generated SQL Script
-- ============================================
-- Generated: 2026-04-05T10:45:41.469247
-- Dialect: POSTGRESQL
-- Tables: 4
-- Records: 8
-- ============================================


-- DDL: Table Definitions
DROP TABLE IF EXISTS customer_orders CASCADE;

DROP TABLE IF EXISTS customer_orders_order CASCADE;

DROP TABLE IF EXISTS customer_orders_customer CASCADE;

DROP TABLE IF EXISTS customer_orders_product CASCADE;



CREATE TABLE customer_orders_product (
    product_id SERIAL PRIMARY KEY,
    customer_orders_id INTEGER NOT NULL,
    product_name VARCHAR(50),
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

CREATE TABLE customer_orders_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_orders_id INTEGER NOT NULL,
    customer_name VARCHAR(50),
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

CREATE TABLE customer_orders_order (
    order_id SERIAL PRIMARY KEY,
    customer_orders_id INTEGER NOT NULL,
    order_date TIMESTAMP,
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

CREATE TABLE customer_orders (
    id SERIAL PRIMARY KEY,
    email VARCHAR(50),
    total_amount DECIMAL(10,2)
);

-- DML: Data Insertion
INSERT INTO customer_orders_product (product_id, product_name)
VALUES
    (1, 'Laptop'),
    (2, 'Phone');
INSERT INTO customer_orders_customer (customer_id, customer_name)
VALUES
    (1, 'John Doe'),
    (2, 'Jane Smith');
INSERT INTO customer_orders_order (order_id, order_date)
VALUES
    (1, '2024-01-15'),
    (2, '2024-01-16');
INSERT INTO customer_orders (id, email, total_amount)
VALUES
    (1, 'john@test.com', 150.0),
    (2, 'jane@test.com', 250.5);
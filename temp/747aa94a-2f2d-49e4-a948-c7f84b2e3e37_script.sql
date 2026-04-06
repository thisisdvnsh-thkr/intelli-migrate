-- ============================================
-- Intelli-Migrate Generated SQL Script
-- ============================================
-- Generated: 2026-04-05T10:09:27.991835
-- Dialect: POSTGRESQL
-- Tables: 2
-- Records: 2
-- ============================================


-- DDL: Table Definitions
DROP TABLE IF EXISTS orders CASCADE;

DROP TABLE IF EXISTS orders_order CASCADE;



CREATE TABLE orders_order (
    order_id SERIAL PRIMARY KEY,
    orders_id INTEGER NOT NULL,
    order_date TIMESTAMP,
    FOREIGN KEY (orders_id) REFERENCES orders(id) ON DELETE CASCADE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(50),
    unit_price DECIMAL(10,2),
    email VARCHAR(50)
);

-- DML: Data Insertion
INSERT INTO orders_order (order_id, order_date)
VALUES
    (1, '2024-01-15');
INSERT INTO orders (id, full_name, unit_price, email)
VALUES
    (1, 'John', 99.5, 'john@test.com');
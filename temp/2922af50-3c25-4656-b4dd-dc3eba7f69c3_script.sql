-- ============================================
-- Intelli-Migrate Generated SQL Script
-- ============================================
-- Generated: 2026-04-05T12:39:11.912503
-- Dialect: POSTGRESQL
-- Tables: 1
-- Records: 1
-- ============================================


-- DDL: Table Definitions
DROP TABLE IF EXISTS ecommerce_data CASCADE;



CREATE TABLE ecommerce_data (
    id SERIAL PRIMARY KEY,
    email VARCHAR(50),
    total_amount DECIMAL(10,2),
    full_name VARCHAR(50)
);

-- DML: Data Insertion
INSERT INTO ecommerce_data (id, email, total_amount, full_name)
VALUES
    (1, 'john@test.com', 150.0, 'John Doe');
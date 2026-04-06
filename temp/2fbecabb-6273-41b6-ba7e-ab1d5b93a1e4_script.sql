-- ============================================
-- Intelli-Migrate Generated SQL Script
-- ============================================
-- Generated: 2026-04-05T12:13:03.708538
-- Dialect: POSTGRESQL
-- Tables: 1
-- Records: 1
-- ============================================


-- DDL: Table Definitions
DROP TABLE IF EXISTS ecommerce_data CASCADE;



CREATE TABLE ecommerce_data (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10,2),
    full_name VARCHAR(50),
    email VARCHAR(50)
);

-- DML: Data Insertion
INSERT INTO ecommerce_data (id, total_amount, full_name, email)
VALUES
    (1, 150.0, 'John Doe', 'john@test.com');
-- ============================================
-- Intelli-Migrate Generated SQL Script
-- ============================================
-- Generated: 2026-04-05T11:54:38.554427
-- Dialect: POSTGRESQL
-- Tables: 1
-- Records: 1
-- ============================================


-- DDL: Table Definitions
DROP TABLE IF EXISTS ecommerce_data CASCADE;



CREATE TABLE ecommerce_data (
    id SERIAL PRIMARY KEY,
    total_amount INTEGER,
    full_name VARCHAR(50),
    email VARCHAR(50)
);

-- DML: Data Insertion
INSERT INTO ecommerce_data (id, total_amount, full_name, email)
VALUES
    (1, 100, 'Test', 'test@test.com');
-- ============================================
-- Intelli-Migrate Generated SQL Script
-- ============================================
-- Generated: 2026-04-03T21:04:22.611863
-- Dialect: POSTGRESQL
-- Tables: 5
-- Records: 183
-- ============================================


-- DDL: Table Definitions
DROP TABLE IF EXISTS customer_orders CASCADE;

DROP TABLE IF EXISTS customer_orders_order CASCADE;

DROP TABLE IF EXISTS customer_orders_customer CASCADE;

DROP TABLE IF EXISTS customer_orders_product CASCADE;

DROP TABLE IF EXISTS customer_orders_address CASCADE;



CREATE TABLE customer_orders_address (
    address_id SERIAL PRIMARY KEY,
    customer_orders_id INTEGER NOT NULL,
    address VARCHAR(50),
    city VARCHAR(50),
    zip_code INTEGER,
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

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
    st VARCHAR(50),
    quantity VARCHAR(50),
    email VARCHAR(50),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    phone VARCHAR(50)
);

-- DML: Data Insertion
INSERT INTO customer_orders_address (address_id, address, city, zip_code)
VALUES
    (1, '6051 Main St', 'San Diego', '77609'),
    (2, '2478 Park St', 'San Antonio', '52059'),
    (3, '1725 Elm St', 'Los Angeles', '80630'),
    (4, '1103 Oak St', 'San Diego', '86245'),
    (5, '6948 Oak St', 'New York', '32832'),
    (6, '8307 Main St', 'New York', '46208'),
    (7, '7856 Oak St', 'San Diego', '10683'),
    (8, '327 Park St', 'San Antonio', '64655'),
    (9, '5968 Oak St', 'Chicago', '62820'),
    (10, '1019 Oak St', 'Chicago', '32213'),
    (11, '5634 Main St', 'Phoenix', '93669'),
    (12, '965 Elm St', 'San Diego', '67383'),
    (13, '1172 Elm St', 'San Diego', '95290'),
    (14, '7371 Elm St', 'San Antonio', '64171'),
    (15, '645 Main St', 'Phoenix', '46013'),
    (16, '9890 Oak St', 'San Antonio', '60348'),
    (17, '5395 Oak St', 'New York', '67284'),
    (18, '8408 Park St', 'Houston', '18145'),
    (19, '6553 Oak St', 'Chicago', '19530'),
    (20, '3348 Elm St', 'Houston', '64337'),
    (21, '3104 Park St', 'Los Angeles', '89003'),
    (22, '3354 Elm St', 'San Diego', '61790'),
    (23, '7487 Park St', 'Los Angeles', '22881'),
    (24, '4515 Elm St', 'Los Angeles', '65921'),
    (25, '4811 Park St', 'Chicago', '37782'),
    (26, '4318 Elm St', 'Houston', '12497'),
    (27, '2182 Oak St', 'New York', '14107'),
    (28, '8928 Park St', 'San Diego', '24480'),
    (29, '3963 Oak St', 'Chicago', '53220'),
    (30, '732 Main St', 'San Antonio', '68022'),
    (31, '8456 Elm St', 'New York', '18839'),
    (32, '2318 Oak St', 'San Diego', '20440'),
    (33, '519 Park St', 'New York', '99413'),
    (34, '1204 Main St', 'New York', '88380'),
    (35, '2194 Oak St', 'Houston', '32059'),
    (36, '9433 Park St', 'Houston', '73444'),
    (37, '7215 Main St', 'New York', '10853'),
    (38, '3753 Elm St', 'Philadelphia', '17929'),
    (39, '6778 Park St', 'Philadelphia', '85581'),
    (40, '4809 Elm St', 'San Diego', '45830'),
    (41, '9640 Park St', 'Los Angeles', '83094'),
    (42, '8119 Oak St', 'San Diego', '48904'),
    (43, '1540 Main St', 'Phoenix', '50945'),
    (44, '7214 Main St', 'Philadelphia', '38322'),
    (45, '306 Oak St', 'Philadelphia', '73208'),
    (46, '9835 Elm St', 'San Diego', '81544'),
    (47, '6779 Main St', 'New York', '22723');
INSERT INTO customer_orders_product (product_id, product_name)
VALUES
    (1, 'Yoga Mat'),
    (2, 'Blender'),
    (4, 'Headphones'),
    (5, 'Smartphone'),
    (6, 'Running Shoes'),
    (7, 'Laptop'),
    (8, 'Coffee Maker'),
    (12, 'Desk Chair'),
    (14, 'Keyboard'),
    (19, 'Monitor');
INSERT INTO customer_orders_customer (customer_id, customer_name)
VALUES
    (1, 'Michael Smith'),
    (2, 'Jane Miller'),
    (3, 'William Garcia'),
    (4, 'Emily Jones'),
    (5, 'David Jones'),
    (6, 'John Garcia'),
    (7, 'Lisa Williams'),
    (8, 'Michael Brown'),
    (12, 'David Garcia'),
    (14, 'David Smith'),
    (16, 'Robert Davis'),
    (17, 'Emily Garcia'),
    (18, 'Emily Miller'),
    (19, 'Michael Garcia'),
    (20, 'William Johnson'),
    (21, 'Sarah Miller'),
    (22, 'John Johnson'),
    (23, 'Jane Jones'),
    (24, 'Emily Rodriguez'),
    (26, 'John Miller'),
    (27, 'John Brown'),
    (28, 'Jennifer Smith'),
    (29, 'Lisa Davis'),
    (30, 'Robert Brown'),
    (31, 'Emily Brown'),
    (35, 'David Rodriguez'),
    (37, 'Jennifer Rodriguez'),
    (38, 'Lisa Smith'),
    (40, 'Sarah Smith'),
    (41, 'David Martinez'),
    (45, 'Sarah Martinez'),
    (51, 'Jane Garcia'),
    (53, 'Sarah Garcia');
INSERT INTO customer_orders_order (order_id, order_date)
VALUES
    (1, '08-01-2026'),
    (2, '2025-10-20'),
    (3, '2025-04-09'),
    (4, 'TBD'),
    (5, '2026-03-01T20:11:58'),
    (6, '2024-13-45'),
    (7, '07/17/2025'),
    (8, '2026-03-16T20:11:58'),
    (9, '12/12/2025'),
    (10, '2025-05-21T20:11:58'),
    (11, '2025-07-25'),
    (12, '02/18/2026'),
    (13, '2026-03-28'),
    (14, '2025-05-12T20:11:58'),
    (15, '2025-08-06'),
    (16, '2025-06-01'),
    (17, '02/02/2026'),
    (18, '11/30/2025'),
    (19, ''),
    (20, '11/21/2025'),
    (21, '2025-07-13'),
    (22, '2026-02-22T20:11:58'),
    (23, '09/15/2025'),
    (24, '2025-09-10'),
    (25, '2026-01-19T20:11:58'),
    (26, '09/14/2025'),
    (27, '29-08-2025'),
    (28, '02/08/2026'),
    (29, '2025-05-28'),
    (30, '03/06/2026'),
    (31, '03/23/2026'),
    (32, '24-01-2026'),
    (33, '27-06-2025'),
    (34, 'not-a-date'),
    (35, '01/21/2026'),
    (36, '10/10/2025'),
    (37, '2025-10-26'),
    (38, '2025-05-14'),
    (40, '2025-05-05'),
    (41, '2025-08-27'),
    (42, '2026-04-01T20:11:58'),
    (43, '09-12-2025'),
    (44, '12/03/2025'),
    (45, '09/23/2025'),
    (46, '2026-02-12T20:11:58'),
    (47, '2025-05-03T20:11:58');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone)
VALUES
    (1, 'CA', 3, 'michaelsmith181@yahoo.com', 'Sports', 29.99, 89.97, '+13112156938'),
    (2, 'TX', 3, 'janemiller920@yahoo.com', 'Kitchen', 49.99, 149.97, ''),
    (3, 'CA', 4, 'williamgarcia559@outlook.com', 'Sports', 29.99, 119.96, '554-917-1253'),
    (4, 'CA', 1, 'emilyjones424@yahoo.com', 'Electronics', 149.99, 149.99, '9092084821'),
    (5, 'NY', 5, 'davidjones697@yahoo.com', 'Electronics', 699.99, 3499.95, '(413) 583-2544'),
    (6, 'NY', 3, 'johngarcia537@yahoo.com', 'Sports', 129.99, 389.97, '+12563187214'),
    (7, 'CA', 5, 'lisawilliams70@gmail.com', 'Electronics', 999.99, 4999.95, '351-728-3527'),
    (8, 'TX', 3, 'michaelbrown184@outlook.com', 'Kitchen', 79.99, 239.97, '5914221370'),
    (9, 'IL', 1, 'davidjones408@outlook.com', 'Electronics', 149.99, 149.99, '+15491073621'),
    (10, 'IL', 5, 'emilyjones371@outlook.com', 'Sports', -100, 149.95, '+19019048159'),
    (11, 'AZ', 3, 'davidgarcia681@gmail.com', 'Electronics', 699.99, 2099.97, '566-311-2045'),
    (12, 'CA', 'many', 'davidsmith309@gmail.com', 'Furniture', 249.99, 249.99, '+19172274832'),
    (13, 'CA', 5, 'robertdavis883@gmail.com', 'Electronics', 149.99, 749.95, '+14538841077'),
    (14, 'TX', 2, 'emilygarcia828@yahoo.com', 'Electronics', 89.99, 179.98, '251-222-5215'),
    (15, 'AZ', 1, 'emilymiller562@gmail.com', 'Furniture', 249.99, 249.99, '+17799585692'),
    (16, 'TX', 1, 'michaelgarcia177@yahoo.com', 'Sports', 129.99, 129.99, '+18135638556'),
    (17, 'NY', 2, 'williamjohnson126@yahoo.com', 'Electronics', 89.99, 179.98, '3778915273'),
    (18, 'TX', 4, 'sarahmiller42@email.com', 'Electronics', 149.99, 599.96, 'call-me'),
    (19, 'IL', 3, 'johnjohnson513@email.com', 'Electronics', 399.99, 1199.97, '(881) 605-4464'),
    (20, 'TX', 2, 'janejones636@email.com', 'Kitchen', 49.99, 99.98, '430-511-4508'),
    (21, 'CA', 1, 'emilyrodriguez88@outlook.com', 'Electronics', 149.99, 149.99, '853-412-7333'),
    (22, 'CA', 4, 'williamgarcia404@email.com', 'Electronics', 699.99, 2799.96, '+18794644378'),
    (23, 'CA', 1, 'johnmiller694@gmail.com', 'Electronics', 89.99, 89.99, '8414541295'),
    (24, 'CA', 2, 'johnbrown329@outlook.com', 'Furniture', 249.99, 499.98, '(824) 426-3897'),
    (25, 'IL', 2, 'jennifersmith271@gmail.com', 'Electronics', 399.99, 799.98, '7211310768'),
    (26, 'TX', -4, 'lisadavis32@gmail.com', 'Kitchen', 49.99, 199.96, '+15904492649'),
    (27, 'NY', 'many', 'robertbrown50@outlook.com', 'Furniture', 249.99, 499.98, '123'),
    (28, 'CA', 4, 'emilybrown323@gmail.com', 'Kitchen', 49.99, 199.96, '247-757-6316'),
    (29, 'IL', 1, 'emilyrodriguez885@email.com', 'Furniture', 249.99, 249.99, '898-620-3569'),
    (30, 'TX', 1, 'emilymiller8@email.com', 'Sports', 29.99, 29.99, '919-755-5730'),
    (31, 'NY', 1, 'davidrodriguez732@email.com', 'Kitchen', 49.99, 49.99, ''),
    (32, 'CA', 2, 'jenniferrodriguez462@email.com', 'Electronics', 999.99, 1999.98, '222-120-8856'),
    (33, 'NY', 1, 'lisasmith597@yahoo.com', 'Electronics', 149.99, 149.99, '5710604729'),
    (34, 'NY', 5, 'emilyrodriguez145@email.com', 'Electronics', 999.99, 4999.95, '+14438380328'),
    (35, 'TX', 3, 'sarahsmith807@email.com', 'Kitchen', 49.99, 149.97, '(272) 209-4428'),
    (36, 'TX', 5, 'davidmartinez945@gmail.com', 'Electronics', 399.99, 1999.95, '+12293917358'),
    (37, 'NY', 5, 'davidmartinez994@outlook.com', 'Electronics', 999.99, 4999.95, '+19826508642'),
    (38, 'PA', 1, 'emilybrown980@outlook.com', 'Sports', 29.99, 29.99, '9615682096'),
    (39, 'PA', 1, 'sarahsmith362@gmail.com', 'Sports', 0, 29.99, '+13353197962'),
    (40, 'CA', 1, 'sarahmartinez954@outlook.com', 'Kitchen', 49.99, 49.99, '325-747-4448'),
    (41, 'CA', 5, 'williamgarcia194@yahoo.com', 'Sports', 29.99, 149.95, '(842) 618-2409'),
    (42, 'CA', 3, 'sarahsmith521@gmail.com', 'Electronics', 149.99, 449.97, '7276300026'),
    (43, 'AZ', 5, 'jennifersmith814@yahoo.com', 'Electronics', 89.99, 449.95, '+13447114957'),
    (44, 'PA', 5, 'johngarcia563@outlook.com', 'Electronics', 89.99, 449.95, '(559) 459-3839'),
    (45, 'PA', 2, 'janegarcia731@yahoo.com', 'Kitchen', 79.99, 159.98, '8557452012'),
    (46, 'CA', 3, 'sarahsmith544@email.com', 'Sports', 129.99, 389.97, '(516) 310-6528'),
    (47, 'NY', 3, 'sarahgarcia331@email.com', 'Electronics', 699.99, 2099.97, '205-482-1299');
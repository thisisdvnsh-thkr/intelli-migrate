-- ============================================
-- Intelli-Migrate Generated SQL Script
-- ============================================
-- Generated: 2026-04-03T21:04:28.630256
-- Dialect: SQLITE
-- Tables: 5
-- Records: 183
-- ============================================


-- DDL: Table Definitions
DROP TABLE IF EXISTS customer_orders;

DROP TABLE IF EXISTS customer_orders_order;

DROP TABLE IF EXISTS customer_orders_customer;

DROP TABLE IF EXISTS customer_orders_product;

DROP TABLE IF EXISTS customer_orders_address;



CREATE TABLE customer_orders_address (
    address_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_orders_id INTEGER NOT NULL,
    address TEXT,
    city TEXT,
    zip_code INTEGER,
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

CREATE TABLE customer_orders_product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_orders_id INTEGER NOT NULL,
    product_name TEXT,
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

CREATE TABLE customer_orders_customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_orders_id INTEGER NOT NULL,
    customer_name TEXT,
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

CREATE TABLE customer_orders_order (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_orders_id INTEGER NOT NULL,
    order_date TEXT,
    FOREIGN KEY (customer_orders_id) REFERENCES customer_orders(id) ON DELETE CASCADE
);

CREATE TABLE customer_orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    st TEXT,
    quantity TEXT,
    email TEXT,
    category TEXT,
    unit_price REAL,
    total_amount REAL,
    phone TEXT
);

-- DML: Data Insertion
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (1, '6051 Main St', 'San Diego', '77609');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (2, '2478 Park St', 'San Antonio', '52059');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (3, '1725 Elm St', 'Los Angeles', '80630');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (4, '1103 Oak St', 'San Diego', '86245');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (5, '6948 Oak St', 'New York', '32832');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (6, '8307 Main St', 'New York', '46208');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (7, '7856 Oak St', 'San Diego', '10683');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (8, '327 Park St', 'San Antonio', '64655');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (9, '5968 Oak St', 'Chicago', '62820');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (10, '1019 Oak St', 'Chicago', '32213');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (11, '5634 Main St', 'Phoenix', '93669');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (12, '965 Elm St', 'San Diego', '67383');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (13, '1172 Elm St', 'San Diego', '95290');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (14, '7371 Elm St', 'San Antonio', '64171');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (15, '645 Main St', 'Phoenix', '46013');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (16, '9890 Oak St', 'San Antonio', '60348');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (17, '5395 Oak St', 'New York', '67284');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (18, '8408 Park St', 'Houston', '18145');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (19, '6553 Oak St', 'Chicago', '19530');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (20, '3348 Elm St', 'Houston', '64337');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (21, '3104 Park St', 'Los Angeles', '89003');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (22, '3354 Elm St', 'San Diego', '61790');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (23, '7487 Park St', 'Los Angeles', '22881');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (24, '4515 Elm St', 'Los Angeles', '65921');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (25, '4811 Park St', 'Chicago', '37782');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (26, '4318 Elm St', 'Houston', '12497');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (27, '2182 Oak St', 'New York', '14107');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (28, '8928 Park St', 'San Diego', '24480');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (29, '3963 Oak St', 'Chicago', '53220');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (30, '732 Main St', 'San Antonio', '68022');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (31, '8456 Elm St', 'New York', '18839');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (32, '2318 Oak St', 'San Diego', '20440');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (33, '519 Park St', 'New York', '99413');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (34, '1204 Main St', 'New York', '88380');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (35, '2194 Oak St', 'Houston', '32059');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (36, '9433 Park St', 'Houston', '73444');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (37, '7215 Main St', 'New York', '10853');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (38, '3753 Elm St', 'Philadelphia', '17929');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (39, '6778 Park St', 'Philadelphia', '85581');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (40, '4809 Elm St', 'San Diego', '45830');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (41, '9640 Park St', 'Los Angeles', '83094');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (42, '8119 Oak St', 'San Diego', '48904');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (43, '1540 Main St', 'Phoenix', '50945');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (44, '7214 Main St', 'Philadelphia', '38322');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (45, '306 Oak St', 'Philadelphia', '73208');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (46, '9835 Elm St', 'San Diego', '81544');
INSERT INTO customer_orders_address (address_id, address, city, zip_code) VALUES (47, '6779 Main St', 'New York', '22723');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (1, 'Yoga Mat');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (2, 'Blender');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (4, 'Headphones');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (5, 'Smartphone');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (6, 'Running Shoes');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (7, 'Laptop');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (8, 'Coffee Maker');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (12, 'Desk Chair');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (14, 'Keyboard');
INSERT INTO customer_orders_product (product_id, product_name) VALUES (19, 'Monitor');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (1, 'Michael Smith');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (2, 'Jane Miller');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (3, 'William Garcia');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (4, 'Emily Jones');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (5, 'David Jones');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (6, 'John Garcia');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (7, 'Lisa Williams');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (8, 'Michael Brown');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (12, 'David Garcia');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (14, 'David Smith');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (16, 'Robert Davis');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (17, 'Emily Garcia');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (18, 'Emily Miller');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (19, 'Michael Garcia');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (20, 'William Johnson');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (21, 'Sarah Miller');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (22, 'John Johnson');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (23, 'Jane Jones');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (24, 'Emily Rodriguez');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (26, 'John Miller');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (27, 'John Brown');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (28, 'Jennifer Smith');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (29, 'Lisa Davis');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (30, 'Robert Brown');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (31, 'Emily Brown');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (35, 'David Rodriguez');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (37, 'Jennifer Rodriguez');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (38, 'Lisa Smith');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (40, 'Sarah Smith');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (41, 'David Martinez');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (45, 'Sarah Martinez');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (51, 'Jane Garcia');
INSERT INTO customer_orders_customer (customer_id, customer_name) VALUES (53, 'Sarah Garcia');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (1, '08-01-2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (2, '2025-10-20');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (3, '2025-04-09');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (4, 'TBD');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (5, '2026-03-01T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (6, '2024-13-45');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (7, '07/17/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (8, '2026-03-16T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (9, '12/12/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (10, '2025-05-21T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (11, '2025-07-25');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (12, '02/18/2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (13, '2026-03-28');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (14, '2025-05-12T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (15, '2025-08-06');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (16, '2025-06-01');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (17, '02/02/2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (18, '11/30/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (19, '');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (20, '11/21/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (21, '2025-07-13');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (22, '2026-02-22T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (23, '09/15/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (24, '2025-09-10');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (25, '2026-01-19T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (26, '09/14/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (27, '29-08-2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (28, '02/08/2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (29, '2025-05-28');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (30, '03/06/2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (31, '03/23/2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (32, '24-01-2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (33, '27-06-2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (34, 'not-a-date');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (35, '01/21/2026');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (36, '10/10/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (37, '2025-10-26');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (38, '2025-05-14');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (40, '2025-05-05');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (41, '2025-08-27');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (42, '2026-04-01T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (43, '09-12-2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (44, '12/03/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (45, '09/23/2025');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (46, '2026-02-12T20:11:58');
INSERT INTO customer_orders_order (order_id, order_date) VALUES (47, '2025-05-03T20:11:58');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (1, 'CA', 3, 'michaelsmith181@yahoo.com', 'Sports', 29.99, 89.97, '+13112156938');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (2, 'TX', 3, 'janemiller920@yahoo.com', 'Kitchen', 49.99, 149.97, '');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (3, 'CA', 4, 'williamgarcia559@outlook.com', 'Sports', 29.99, 119.96, '554-917-1253');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (4, 'CA', 1, 'emilyjones424@yahoo.com', 'Electronics', 149.99, 149.99, '9092084821');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (5, 'NY', 5, 'davidjones697@yahoo.com', 'Electronics', 699.99, 3499.95, '(413) 583-2544');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (6, 'NY', 3, 'johngarcia537@yahoo.com', 'Sports', 129.99, 389.97, '+12563187214');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (7, 'CA', 5, 'lisawilliams70@gmail.com', 'Electronics', 999.99, 4999.95, '351-728-3527');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (8, 'TX', 3, 'michaelbrown184@outlook.com', 'Kitchen', 79.99, 239.97, '5914221370');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (9, 'IL', 1, 'davidjones408@outlook.com', 'Electronics', 149.99, 149.99, '+15491073621');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (10, 'IL', 5, 'emilyjones371@outlook.com', 'Sports', -100, 149.95, '+19019048159');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (11, 'AZ', 3, 'davidgarcia681@gmail.com', 'Electronics', 699.99, 2099.97, '566-311-2045');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (12, 'CA', 'many', 'davidsmith309@gmail.com', 'Furniture', 249.99, 249.99, '+19172274832');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (13, 'CA', 5, 'robertdavis883@gmail.com', 'Electronics', 149.99, 749.95, '+14538841077');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (14, 'TX', 2, 'emilygarcia828@yahoo.com', 'Electronics', 89.99, 179.98, '251-222-5215');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (15, 'AZ', 1, 'emilymiller562@gmail.com', 'Furniture', 249.99, 249.99, '+17799585692');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (16, 'TX', 1, 'michaelgarcia177@yahoo.com', 'Sports', 129.99, 129.99, '+18135638556');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (17, 'NY', 2, 'williamjohnson126@yahoo.com', 'Electronics', 89.99, 179.98, '3778915273');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (18, 'TX', 4, 'sarahmiller42@email.com', 'Electronics', 149.99, 599.96, 'call-me');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (19, 'IL', 3, 'johnjohnson513@email.com', 'Electronics', 399.99, 1199.97, '(881) 605-4464');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (20, 'TX', 2, 'janejones636@email.com', 'Kitchen', 49.99, 99.98, '430-511-4508');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (21, 'CA', 1, 'emilyrodriguez88@outlook.com', 'Electronics', 149.99, 149.99, '853-412-7333');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (22, 'CA', 4, 'williamgarcia404@email.com', 'Electronics', 699.99, 2799.96, '+18794644378');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (23, 'CA', 1, 'johnmiller694@gmail.com', 'Electronics', 89.99, 89.99, '8414541295');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (24, 'CA', 2, 'johnbrown329@outlook.com', 'Furniture', 249.99, 499.98, '(824) 426-3897');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (25, 'IL', 2, 'jennifersmith271@gmail.com', 'Electronics', 399.99, 799.98, '7211310768');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (26, 'TX', -4, 'lisadavis32@gmail.com', 'Kitchen', 49.99, 199.96, '+15904492649');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (27, 'NY', 'many', 'robertbrown50@outlook.com', 'Furniture', 249.99, 499.98, '123');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (28, 'CA', 4, 'emilybrown323@gmail.com', 'Kitchen', 49.99, 199.96, '247-757-6316');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (29, 'IL', 1, 'emilyrodriguez885@email.com', 'Furniture', 249.99, 249.99, '898-620-3569');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (30, 'TX', 1, 'emilymiller8@email.com', 'Sports', 29.99, 29.99, '919-755-5730');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (31, 'NY', 1, 'davidrodriguez732@email.com', 'Kitchen', 49.99, 49.99, '');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (32, 'CA', 2, 'jenniferrodriguez462@email.com', 'Electronics', 999.99, 1999.98, '222-120-8856');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (33, 'NY', 1, 'lisasmith597@yahoo.com', 'Electronics', 149.99, 149.99, '5710604729');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (34, 'NY', 5, 'emilyrodriguez145@email.com', 'Electronics', 999.99, 4999.95, '+14438380328');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (35, 'TX', 3, 'sarahsmith807@email.com', 'Kitchen', 49.99, 149.97, '(272) 209-4428');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (36, 'TX', 5, 'davidmartinez945@gmail.com', 'Electronics', 399.99, 1999.95, '+12293917358');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (37, 'NY', 5, 'davidmartinez994@outlook.com', 'Electronics', 999.99, 4999.95, '+19826508642');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (38, 'PA', 1, 'emilybrown980@outlook.com', 'Sports', 29.99, 29.99, '9615682096');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (39, 'PA', 1, 'sarahsmith362@gmail.com', 'Sports', 0, 29.99, '+13353197962');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (40, 'CA', 1, 'sarahmartinez954@outlook.com', 'Kitchen', 49.99, 49.99, '325-747-4448');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (41, 'CA', 5, 'williamgarcia194@yahoo.com', 'Sports', 29.99, 149.95, '(842) 618-2409');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (42, 'CA', 3, 'sarahsmith521@gmail.com', 'Electronics', 149.99, 449.97, '7276300026');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (43, 'AZ', 5, 'jennifersmith814@yahoo.com', 'Electronics', 89.99, 449.95, '+13447114957');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (44, 'PA', 5, 'johngarcia563@outlook.com', 'Electronics', 89.99, 449.95, '(559) 459-3839');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (45, 'PA', 2, 'janegarcia731@yahoo.com', 'Kitchen', 79.99, 159.98, '8557452012');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (46, 'CA', 3, 'sarahsmith544@email.com', 'Sports', 129.99, 389.97, '(516) 310-6528');
INSERT INTO customer_orders (id, st, quantity, email, category, unit_price, total_amount, phone) VALUES (47, 'NY', 3, 'sarahgarcia331@email.com', 'Electronics', 699.99, 2099.97, '205-482-1299');
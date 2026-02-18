-- Deleting the database
DROP DATABASE IF EXISTS SQL_LEARNING;

-- Create a database for learning
CREATE DATABASE IF NOT EXISTS SQL_LEARNING;
USE DATABASE SQL_LEARNING;

--Creating schemas for the db
CREATE SCHEMA IF NOT EXISTS sales;
CREATE SCHEMA IF NOT EXISTS hr;
CREATE SCHEMA IF NOT EXISTS products;

-- Using sales schema
USE SCHEMA sales;
========================================
-- 1. CUSTOMERS TABLE
========================================
CREATE OR REPLACE TABLE customers (
    customer_id INT AUTOINCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2),
    registration_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    credit_limit DECIMAL(10,2)
);

-- Insert customers data
INSERT INTO customers (first_name, last_name, email, city, state, registration_date, is_active, credit_limit) VALUES
    ('John', 'Smith', 'john.smith@email.com', 'New York', 'NY', '2023-01-15', TRUE, 5000.00),
    ('Emma', 'Johnson', 'emma.j@email.com', 'Los Angeles', 'CA', '2023-02-20', TRUE, 7500.00),
    ('Michael', 'Brown', 'michael.b@email.com', 'Chicago', 'IL', '2023-01-10', TRUE, 3000.00),
    ('Sarah', 'Davis', 'sarah.d@email.com', 'Houston', 'TX', '2023-03-05', FALSE, 2000.00),
    ('Robert', 'Wilson', 'robert.w@email.com', 'Phoenix', 'AZ', '2023-02-28', TRUE, 6000.00),
    ('Lisa', 'Martinez', 'lisa.m@email.com', 'New York', 'NY', '2023-04-12', TRUE, 4500.00),
    ('David', 'Anderson', 'david.a@email.com', 'Los Angeles', 'CA', '2023-01-25', FALSE, 3500.00),
    ('Jennifer', 'Taylor', 'jennifer.t@email.com', 'Chicago', 'IL', '2023-03-18', TRUE, 8000.00),
    ('William', 'Thomas', 'william.t@email.com', 'Houston', 'TX', '2023-02-05', TRUE, 5500.00),
    ('Maria', 'Garcia', 'maria.g@email.com', 'Phoenix', 'AZ', '2023-04-01', TRUE, 4000.00),
    ('James', 'Rodriguez', 'james.r@email.com', 'Miami', 'FL', '2023-05-20', TRUE, 9000.00),
    ('Patricia', 'Lee', 'patricia.l@email.com', 'Seattle', 'WA', '2023-06-15', TRUE, 6500.00),
    ('Richard', 'White', 'richard.w@email.com', 'Boston', 'MA', '2023-07-01', FALSE, 2800.00),
    ('Susan', 'Harris', 'susan.h@email.com', 'Denver', 'CO', '2023-08-10', TRUE, 7200.00),
    ('Joseph', 'Clark', 'joseph.c@email.com', 'Atlanta', 'GA', '2023-09-05', TRUE, 4800.00);


========================================
-- 2. PRODUCTS TABLE
========================================
CREATE OR REPLACE TABLE products (
    product_id INT AUTOINCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    unit_price DECIMAL(10,2),
    cost DECIMAL(10,2),
    supplier VARCHAR(100),
    stock_quantity INT,
    reorder_level INT
);

-- Insert products table
INSERT INTO products (product_name, category, subcategory, unit_price, cost, supplier, stock_quantity, reorder_level) VALUES
    ('Laptop Pro', 'Electronics', 'Computers', 1299.99, 950.00, 'TechSupply Inc', 50, 20),
    ('Wireless Mouse', 'Electronics', 'Accessories', 29.99, 15.00, 'GadgetWorld', 200, 50),
    ('Desk Chair', 'Furniture', 'Office', 249.99, 150.00, 'OfficeDepot', 30, 10),
    ('Monitor 24"', 'Electronics', 'Displays', 299.99, 200.00, 'DisplayTech', 45, 15),
    ('Keyboard', 'Electronics', 'Accessories', 79.99, 40.00, 'GadgetWorld', 150, 30),
    ('Desk Lamp', 'Furniture', 'Lighting', 39.99, 20.00, 'HomeStyle', 100, 25),
    ('Tablet', 'Electronics', 'Tablets', 499.99, 350.00, 'TechSupply Inc', 35, 10),
    ('Printer', 'Electronics', 'Printers', 199.99, 130.00, 'PrintMaster', 25, 8),
    ('Filing Cabinet', 'Furniture', 'Storage', 149.99, 80.00, 'OfficeDepot', 40, 15),
    ('Headphones', 'Electronics', 'Audio', 89.99, 45.00, 'AudioTech', 120, 30),
    ('Webcam', 'Electronics', 'Accessories', 69.99, 35.00, 'GadgetWorld', 80, 20),
    ('Desk Organizer', 'Office Supplies', 'Organization', 24.99, 10.00, 'OfficeDepot', 200, 50),
    ('External Hard Drive', 'Electronics', 'Storage', 129.99, 70.00, 'DataSafe', 60, 15),
    ('Notebooks (Pack)', 'Office Supplies', 'Paper', 12.99, 5.00, 'PaperCo', 500, 100),
    ('Coffee Maker', 'Appliances', 'Kitchen', 89.99, 45.00, 'HomeStyle', 30, 10);

========================================
-- 3. EMPLOYEES TABLE
========================================
USE SCHEMA hr;

--employees table
CREATE OR REPLACE TABLE employees (
    employee_id INT AUTOINCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50),
    position VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    manager_id INT,
    commission_rate DECIMAL(3,2)
);

-- Insert employees data
INSERT INTO employees (first_name, last_name, email, department, position, hire_date, salary, manager_id, commission_rate) VALUES
    ('Alice', 'Cooper', 'alice.c@company.com', 'Sales', 'Sales Manager', '2022-01-10', 85000.00, NULL, 0.10),
    ('Bob', 'Marley', 'bob.m@company.com', 'Sales', 'Sales Rep', '2022-03-15', 55000.00, 1, 0.05),
    ('Charlie', 'Brown', 'charlie.b@company.com', 'Sales', 'Sales Rep', '2022-06-20', 52000.00, 1, 0.05),
    ('Diana', 'Ross', 'diana.r@company.com', 'Marketing', 'Marketing Manager', '2022-02-05', 78000.00, NULL, NULL),
    ('Edward', 'Norton', 'edward.n@company.com', 'Marketing', 'Marketing Specialist', '2022-08-12', 58000.00, 4, NULL),
    ('Fiona', 'Apple', 'fiona.a@company.com', 'IT', 'IT Manager', '2022-01-20', 95000.00, NULL, NULL),
    ('George', 'Clooney', 'george.c@company.com', 'IT', 'Developer', '2022-09-01', 72000.00, 6, NULL),
    ('Helen', 'Mirren', 'helen.m@company.com', 'IT', 'Developer', '2023-01-15', 68000.00, 6, NULL),
    ('Ian', 'McKellen', 'ian.m@company.com', 'HR', 'HR Manager', '2022-04-18', 70000.00, NULL, NULL),
    ('Julia', 'Roberts', 'julia.r@company.com', 'HR', 'HR Generalist', '2022-11-01', 52000.00, 9, NULL),
    ('Kevin', 'Spacey', 'kevin.s@company.com', 'Finance', 'Finance Manager', '2022-03-01', 88000.00, NULL, NULL),
    ('Laura', 'Linney', 'laura.l@company.com', 'Finance', 'Accountant', '2022-07-15', 62000.00, 11, NULL),
    ('Morgan', 'Freeman', 'morgan.f@company.com', 'Operations', 'Ops Manager', '2022-05-01', 82000.00, NULL, NULL),
    ('Nicole', 'Kidman', 'nicole.k@company.com', 'Operations', 'Ops Coordinator', '2022-10-10', 54000.00, 13, NULL),
    ('Oscar', 'Isaac', 'oscar.i@company.com', 'Sales', 'Sales Rep', '2023-02-01', 50000.00, 1, 0.05);

========================================
-- 4. ORDERS TABLE
========================================
USE SCHEMA sales

--create the table
CREATE OR REPLACE TABLE orders (
    order_id INT AUTOINCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    payment_method VARCHAR(30),
    shipping_address VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--Insert orders data
INSERT INTO orders (customer_id, order_date, status, payment_method, shipping_address)
SELECT 
    customer_id,
    DATEADD(day, UNIFORM(1, 365, RANDOM()), '2023-01-01'::DATE) as order_date,
    CASE UNIFORM(1, 4, RANDOM())
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Shipped'
        WHEN 4 THEN 'Delivered'
    END as status,
    CASE UNIFORM(1, 3, RANDOM())
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'PayPal'
        WHEN 3 THEN 'Bank Transfer'
    END as payment_method,
    'Sample Address ' || UNIFORM(1, 100, RANDOM()) as shipping_address
FROM customers
CROSS JOIN TABLE(GENERATOR(ROWCOUNT => 3)) -- 3 orders per customer
ORDER BY RANDOM()
LIMIT 40; -- Limit to 40 orders

========================================
-- 5. ORDER_ITEMS TABLE
========================================
-- Create order items table
CREATE OR REPLACE TABLE order_items (
    order_item_id INT AUTOINCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),  -- Price at time of order
    discount DECIMAL(4,2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--Insert to order items data
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount)
SELECT 
    o.order_id,
    p.product_id,
    UNIFORM(1, 5, RANDOM()) as quantity,
    p.unit_price,
    CASE UNIFORM(1, 10, RANDOM())
        WHEN 1 THEN 0.10
        WHEN 2 THEN 0.15
        ELSE 0
    END as discount
FROM orders o
CROSS JOIN products p
WHERE UNIFORM(1, 100, RANDOM()) <= 30  -- 30% chance of including a product
ORDER BY RANDOM()
LIMIT 120; -- Average 3 items per order

========================================
-- 6. PRODUCT_REVIEWS TABLE
========================================
CREATE OR REPLACE TABLE product_reviews (
    review_id INT AUTOINCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT,  -- CHECK constraint removed
    review_text VARCHAR(500),
    review_date DATE,
    is_verified_purchase BOOLEAN,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert product reviews data
INSERT INTO product_reviews (product_id, customer_id, rating, review_text, review_date, is_verified_purchase)
SELECT 
    p.product_id,
    c.customer_id,
    UNIFORM(1, 5, RANDOM()) as rating,
    CASE UNIFORM(1, 5, RANDOM())
        WHEN 1 THEN 'Great product, highly recommend!'
        WHEN 2 THEN 'Good value for money'
        WHEN 3 THEN 'Average quality, expected better'
        WHEN 4 THEN 'Not satisfied with the quality'
        WHEN 5 THEN 'The worst product quality ever'
    END as review_text,
    DATEADD(day, UNIFORM(1, 200, RANDOM()), '2023-01-01'::DATE) as review_date,
    CASE UNIFORM(1, 2, RANDOM()) WHEN 1 THEN TRUE ELSE FALSE END as is_verified_purchase
FROM products p
CROSS JOIN customers c
WHERE UNIFORM(1, 100, RANDOM()) <= 15  -- 15% chance of review
ORDER BY RANDOM()
LIMIT 50;

========================================
-- 7.TABLE WITH HIERARCHICAL DATA
========================================
CREATE OR REPLACE TABLE org_chart (
    employee_id INT,
    employee_name VARCHAR(100),
    manager_id INT,
    department VARCHAR(50)
);

--Insert org_chart data
INSERT INTO org_chart VALUES
    (1, 'CEO', NULL, 'Executive'),
    (2, 'VP Sales', 1, 'Sales'),
    (3, 'VP Marketing', 1, 'Marketing'),
    (4, 'VP Engineering', 1, 'Engineering'),
    (5, 'Sales Manager', 2, 'Sales'),
    (6, 'Marketing Manager', 3, 'Marketing'),
    (7, 'Engineering Manager', 4, 'Engineering'),
    (8, 'Sales Rep 1', 5, 'Sales'),
    (9, 'Sales Rep 2', 5, 'Sales'),
    (10, 'Developer 1', 7, 'Engineering'),
    (11, 'Developer 2', 7, 'Engineering'),
    (12, 'QA Engineer', 7, 'Engineering');

========================================
-- 8.TIME SERIES DATA FOR WINDOW FUNCTIONS
========================================
CREATE OR REPLACE TABLE daily_sales (
    sale_date DATE,
    product_category VARCHAR(50),
    total_sales DECIMAL(12,2),
    units_sold INT
);

-- Insert 90 days of sales data
INSERT INTO daily_sales (sale_date, product_category, total_sales, units_sold)
WITH dates AS (
    SELECT DATEADD(day, ROW_NUMBER() OVER (ORDER BY 0) - 1, '2023-01-01'::DATE) as sale_date
    FROM TABLE(GENERATOR(ROWCOUNT => 365))
)
SELECT 
    sale_date,
    category as product_category,
    ROUND(100 + (UNIFORM(1, 500, RANDOM()) * 
         CASE MOD(DAYOFWEEK(sale_date), 7)
            WHEN 0 THEN 1.5  -- Sunday boost
            WHEN 6 THEN 1.3  -- Saturday boost
            ELSE 1.0
         END), 2) as total_sales,
    UNIFORM(1, 50, RANDOM()) * 
         CASE MOD(DAYOFWEEK(sale_date), 7)
            WHEN 0 THEN 2
            WHEN 6 THEN 1.8
            ELSE 1
         END as units_sold
FROM dates
CROSS JOIN (SELECT DISTINCT category FROM products) p
WHERE UNIFORM(1, 100, RANDOM()) <= 70  -- Not every category sells every day
ORDER BY sale_date, category
LIMIT 2000;

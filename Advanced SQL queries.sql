USE DATABASE SQL_LEARNING;

-- Concatenation of strings
SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
FROM SQL_LEARNING.HR.EMPLOYEES;

--Joins
SELECT C.FIRST_NAME || ' ' || C.LAST_NAME AS FULL_NAME, 
COUNT(O.order_id) AS orders_given
FROM SQL_LEARNING.SALES.CUSTOMERS C
JOIN SQL_LEARNING.SALES.ORDERS O
ON C.customer_id = O.customer_id
GROUP BY FULL_NAME
ORDER BY orders_given DESC;

--Cross-joining
SELECT *
FROM SQL_LEARNING.SALES.CUSTOMERS C
CROSS JOIN SQL_LEARNING.SALES.ORDERS O;

-- Case Statement
SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
    Salary,
       CASE 
           WHEN salary > 80000 THEN 'High'
           WHEN salary BETWEEN 60000 AND 80000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category,
FROM SQL_LEARNING.HR.EMPLOYEES;

====================================================
-- WINDOW FUNCTIONS
====================================================
--Running total for product quantity
SELECT stock_quantity, 
SUM (stock_quantity) OVER (ORDER BY CATEGORY) AS running_total
FROM SQL_LEARNING.SALES.PRODUCTS

--Running total for product sales
SELECT units_sold,
SUM(units_sold) OVER (ORDER BY sale_date) AS running_total
FROM SQL_LEARNING.SALES.DAILY_SALES;

-- running total with partition function
SELECT units_sold,
    DATE_TRUNC('week', sale_date) AS week,
    SUM(units_sold) OVER (PARTITION BY DATE_TRUNC('week', sale_date) ORDER BY sale_date) AS running_total
FROM SQL_LEARNING.SALES.DAILY_SALES;

---- Group by vs Window function
-- Group by
SELECT product_id, SUM(quantity)
FROM orders_made
GROUP BY product_id;

-- Window function
SELECT product_id, 
    SUM(quantity) OVER(PARTITION BY product_id) AS sum_quantity
FROM orders_made;

-- Lag() vs Lead ()
SELECT
    ORDER_ID, DATE_TRUNC('month', order_date) AS MONTH, QUANTITY,
    LAG(QUANTITY, 1, 0) OVER(PARTITION BY PRODUCT_ID ORDER BY DATE_TRUNC('month', order_date))
        AS PREV_QUANTITY,
    QUANTITY - LAG(QUANTITY, 1, 0) OVER(PARTITION BY PRODUCT_ID ORDER BY DATE_TRUNC('month', order_date))
        AS QTY_CHANGE
FROM orders_made;
-- LEAD()
SELECT
    ORDER_ID, DATE_TRUNC('month', order_date) AS MONTH, QUANTITY,
    LEAD(QUANTITY, 1, 0) OVER(PARTITION BY PRODUCT_ID ORDER BY DATE_TRUNC('month', order_date))
        AS NEXT_QUANTITY,
    QUANTITY - LEAD(QUANTITY, 1, 0) OVER(PARTITION BY PRODUCT_ID ORDER BY DATE_TRUNC('month', order_date))
        AS QTY_CHANGE
FROM orders_made;

--- NTILE (n)
SELECT
    ORDER_ID, PRODUCT_ID, QUANTITY,
    NTILE(4) OVER(ORDER BY QUANTITY DESC) AS QUARTILE
-- 1 = top 25%, 2 = next 25%, 3 = next 25%, 4 = bottom 25%
FROM ORDERS_MADE;

-- FIRST_VALUE() and LAST_VALUE()
SELECT
    ORDER_ID, DATE_TRUNC('month', order_date) AS MONTH, QUANTITY,
    FIRST_VALUE(QUANTITY) OVER(
        PARTITION BY PRODUCT_ID
        ORDER BY DATE_TRUNC('month', order_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS FIRST_QTY,
    LAST_VALUE(QUANTITY) OVER(
        PARTITION BY PRODUCT_ID
        ORDER BY DATE_TRUNC('month', order_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS LAST_QTY
FROM ORDERS_MADE;

--PERCENT_RANK() & CUME_DIST()
SELECT
    ORDER_ID, QUANTITY,
    PERCENT_RANK() OVER(ORDER BY QUANTITY) AS PCT_RANK,
    -- = (RANK - 1) / (total rows - 1) → first row is always 0.0

    CUME_DIST() OVER(ORDER BY QUANTITY) AS CUM_DIST
    -- = rows with value <= current / total rows → last row is always 1.0
FROM ORDERS_MADE;
=============================================================================================
-- WORKING WITH WINDOW FUNCTIONS AND AGGREGATIONS
=============================================================================================
-- Creating orders made view
CREATE VIEW orders_made AS 
SELECT I.ORDER_ID, I.PRODUCT_ID, I.QUANTITY, I.UNIT_PRICE, I.DISCOUNT,
O.ORDER_DATE, O.STATUS, O.PAYMENT_METHOD
FROM SQL_LEARNING.SALES.ORDER_ITEMS I
JOIN SQL_LEARNING.SALES.ORDERS O
ON I.ORDER_ID = O.ORDER_ID;

-- showing the view
SELECT * FROM orders_made;

-- Using window functions in aggregations to query the order functions view
SELECT order_id, product_id, quantity,
    DATE_TRUNC('month', order_date) AS month,
    ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS row_number,
    RANK() OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS rank,
    DENSE_RANK() OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS dense_rank,
    SUM(quantity) OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS sum_quantity,
    COUNT(quantity) OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS count_quantity,
    AVG(quantity) OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS avg_quantity,
    MAX(quantity) OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS max_quantity,
    MIN(quantity) OVER (PARTITION BY product_id ORDER BY DATE_TRUNC('month', order_date)) AS min_quantity
FROM orders_made;


    
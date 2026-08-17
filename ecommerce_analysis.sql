/* ============================================================================
   E-Store Pulse: Performance Analytics
   SQL Schema, Data Load & Business Analysis Queries
   Author : Ganesh Sargar
   Stack  : PostgreSQL 15+
   ============================================================================
   This script:
     1. Creates the database schema for the e-commerce orders dataset
     2. Loads the raw data from data/ecommerce_orders.csv
     3. Runs the exact business questions answered by the Power BI dashboard
        (Total Orders, Gross Sales, Net Revenue, Return Rate, Order Status
        split, Payment Mode split, Regional performance, Discount frequency,
        Monthly/Yearly sales trend)
   ========================================================================= */


-- ============================================================================
-- 1. SCHEMA
-- ============================================================================
DROP TABLE IF EXISTS ecommerce_orders;

CREATE TABLE ecommerce_orders (
    order_id            INTEGER PRIMARY KEY,
    order_date          DATE NOT NULL,
    customer_id         VARCHAR(15) NOT NULL,
    customer_name       VARCHAR(100) NOT NULL,
    product_name        VARCHAR(50) NOT NULL,
    category            VARCHAR(50) NOT NULL,
    region              VARCHAR(20) NOT NULL,
    city                VARCHAR(50) NOT NULL,
    quantity            SMALLINT NOT NULL CHECK (quantity > 0),
    unit_price          NUMERIC(12, 2) NOT NULL CHECK (unit_price >= 0),
    gross_sales         NUMERIC(14, 2) NOT NULL,
    discount_percent    SMALLINT NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    discount_amount     NUMERIC(14, 2) NOT NULL,
    net_revenue         NUMERIC(14, 2) NOT NULL,
    payment_mode        VARCHAR(30) NOT NULL,
    order_status        VARCHAR(20) NOT NULL,
    is_returned          SMALLINT NOT NULL DEFAULT 0
);

CREATE INDEX idx_orders_date     ON ecommerce_orders (order_date);
CREATE INDEX idx_orders_product  ON ecommerce_orders (product_name);
CREATE INDEX idx_orders_region   ON ecommerce_orders (region);
CREATE INDEX idx_orders_status   ON ecommerce_orders (order_status);


-- ============================================================================
-- 2. LOAD DATA  (run from psql; adjust path if needed)
-- ============================================================================
-- \copy ecommerce_orders FROM 'data/ecommerce_orders.csv' DELIMITER ',' CSV HEADER;


-- ============================================================================
-- 3. DASHBOARD KPI CARDS
-- ============================================================================

-- 3.1 Total Orders, Gross Sales, Net Revenue, Total Quantity, Return Rate (%)
SELECT
    COUNT(*)                                                   AS total_orders,
    SUM(gross_sales)                                           AS gross_sales,
    SUM(net_revenue)                                           AS net_revenue,
    SUM(quantity)                                               AS total_quantity,
    ROUND(100.0 * SUM(is_returned) / COUNT(*), 2)              AS return_rate_pct
FROM ecommerce_orders;


-- ============================================================================
-- 4. ORDER STATUS BREAKDOWN
-- ============================================================================
SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM ecommerce_orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ============================================================================
-- 5. PAYMENT MODE SPLIT
-- ============================================================================
SELECT
    payment_mode,
    COUNT(*)                                        AS order_count,
    SUM(net_revenue)                                AS net_revenue,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders
FROM ecommerce_orders
GROUP BY payment_mode
ORDER BY order_count DESC;


-- ============================================================================
-- 6. REGIONAL PERFORMANCE  (slicer: Region -> East / North / South / West)
-- ============================================================================
SELECT
    region,
    COUNT(*)              AS total_orders,
    SUM(gross_sales)       AS gross_sales,
    SUM(net_revenue)       AS net_revenue,
    SUM(quantity)          AS total_quantity,
    ROUND(100.0 * SUM(is_returned) / COUNT(*), 2) AS return_rate_pct
FROM ecommerce_orders
GROUP BY region
ORDER BY net_revenue DESC;


-- ============================================================================
-- 7. DISCOUNT FREQUENCY BY QUANTITY  (pie chart on dashboard)
-- ============================================================================
SELECT
    quantity,
    COUNT(*) FILTER (WHERE discount_percent > 0) AS discounted_orders,
    COUNT(*)                                     AS total_orders,
    ROUND(100.0 * COUNT(*) FILTER (WHERE discount_percent > 0) / COUNT(*), 2) AS discount_frequency_pct
FROM ecommerce_orders
GROUP BY quantity
ORDER BY quantity;


-- ============================================================================
-- 8. SALES COUNT TREND BY YEAR  (area chart: 2022 -> 2024)
-- ============================================================================
SELECT
    EXTRACT(YEAR FROM order_date)::INT AS order_year,
    COUNT(*)                            AS sales_count,
    SUM(net_revenue)                    AS net_revenue
FROM ecommerce_orders
GROUP BY order_year
ORDER BY order_year;


-- ============================================================================
-- 9. SALES COUNT TREND BY MONTH  (drill-down view)
-- ============================================================================
SELECT
    TO_CHAR(order_date, 'Month') AS order_month,
    EXTRACT(MONTH FROM order_date)::INT AS month_num,
    COUNT(*)                     AS sales_count
FROM ecommerce_orders
GROUP BY order_month, month_num
ORDER BY month_num;


-- ============================================================================
-- 10. PRODUCT-LEVEL PERFORMANCE  (left-hand slicer: Product_Name)
-- ============================================================================
SELECT
    product_name,
    category,
    COUNT(*)                                        AS total_orders,
    SUM(quantity)                                    AS total_quantity,
    SUM(gross_sales)                                 AS gross_sales,
    SUM(net_revenue)                                 AS net_revenue,
    ROUND(AVG(discount_percent), 2)                  AS avg_discount_pct,
    ROUND(100.0 * SUM(is_returned) / COUNT(*), 2)    AS return_rate_pct
FROM ecommerce_orders
GROUP BY product_name, category
ORDER BY net_revenue DESC;


-- ============================================================================
-- 11. TOP 10 CITIES BY NET REVENUE
-- ============================================================================
SELECT
    city,
    region,
    COUNT(*)         AS total_orders,
    SUM(net_revenue) AS net_revenue
FROM ecommerce_orders
GROUP BY city, region
ORDER BY net_revenue DESC
LIMIT 10;


-- ============================================================================
-- 12. TOP 10 CUSTOMERS BY LIFETIME VALUE
-- ============================================================================
SELECT
    customer_id,
    customer_name,
    COUNT(*)         AS total_orders,
    SUM(net_revenue) AS lifetime_value
FROM ecommerce_orders
GROUP BY customer_id, customer_name
ORDER BY lifetime_value DESC
LIMIT 10;


-- ============================================================================
-- 13. RETURN RATE BY PRODUCT & REGION  (root-cause view)
-- ============================================================================
SELECT
    product_name,
    region,
    COUNT(*) FILTER (WHERE order_status = 'Returned') AS returned_orders,
    COUNT(*)                                            AS total_orders,
    ROUND(100.0 * COUNT(*) FILTER (WHERE order_status = 'Returned') / COUNT(*), 2) AS return_rate_pct
FROM ecommerce_orders
GROUP BY product_name, region
HAVING COUNT(*) >= 20
ORDER BY return_rate_pct DESC
LIMIT 15;


-- ============================================================================
-- 14. MONTH-OVER-MONTH REVENUE GROWTH  (window function)
-- ============================================================================
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS order_month,
        SUM(net_revenue)                       AS net_revenue
    FROM ecommerce_orders
    GROUP BY order_month
)
SELECT
    order_month,
    net_revenue,
    LAG(net_revenue) OVER (ORDER BY order_month)               AS prev_month_revenue,
    ROUND(
        100.0 * (net_revenue - LAG(net_revenue) OVER (ORDER BY order_month))
        / NULLIF(LAG(net_revenue) OVER (ORDER BY order_month), 0), 2
    ) AS mom_growth_pct
FROM monthly_revenue
ORDER BY order_month;

/* ============================================================================
   End of script
   ========================================================================= */

-- =========================================
-- Retail Sales Database — Analytical Queries
-- SQL Server (T-SQL)
-- =========================================
-- Skills demonstrated: JOINs, CTEs, Window Functions,
-- Aggregations, Date logic, Subqueries, CASE statements
-- =========================================

USE RetailSalesDB;
GO

/* =========================================
   SECTION 1: REVENUE ANALYSIS
   ========================================= */

-- Q1: Total revenue by month (trend over time)
SELECT
    FORMAT(o.order_date, 'yyyy-MM')          AS order_month,
    COUNT(DISTINCT o.order_id)               AS total_orders,
    SUM(oi.quantity * oi.unit_price)         AS gross_revenue,
    ROUND(AVG(oi.quantity * oi.unit_price), 2) AS avg_order_item_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY order_month;

-- Q2: Top-selling products by revenue
SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity)                     AS units_sold,
    SUM(oi.quantity * oi.unit_price)     AS total_revenue,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS revenue_rank
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o   ON oi.order_id   = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_name, p.category
ORDER BY revenue_rank;

-- Q3: Revenue breakdown by product category
SELECT
    p.category,
    COUNT(DISTINCT o.order_id)           AS total_orders,
    SUM(oi.quantity)                     AS units_sold,
    SUM(oi.quantity * oi.unit_price)     AS category_revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100.0
        / SUM(SUM(oi.quantity * oi.unit_price)) OVER (), 2
    )                                    AS pct_of_total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o   ON oi.order_id   = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY category_revenue DESC;


/* =========================================
   SECTION 2: CUSTOMER INSIGHTS
   ========================================= */

-- Q4: Top customers by lifetime value (LTV)
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name     AS customer_name,
    c.city,
    COUNT(DISTINCT o.order_id)           AS total_orders,
    SUM(oi.quantity * oi.unit_price)     AS lifetime_value,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS ltv_rank
FROM customers c
JOIN orders     o  ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id  = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY ltv_rank;

-- Q5: Repeat customers (purchased more than once)
WITH customer_order_counts AS (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT
    c.first_name + ' ' + c.last_name AS customer_name,
    c.city,
    coc.order_count
FROM customer_order_counts coc
JOIN customers c ON coc.customer_id = c.customer_id
WHERE coc.order_count > 1
ORDER BY coc.order_count DESC;

-- Q6: Revenue by customer city
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id)        AS customer_count,
    COUNT(DISTINCT o.order_id)           AS total_orders,
    SUM(oi.quantity * oi.unit_price)     AS city_revenue
FROM customers c
JOIN orders     o  ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id  = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.city
ORDER BY city_revenue DESC;


/* =========================================
   SECTION 3: INVENTORY & SUPPLY CHAIN
   ========================================= */

-- Q7: Products at risk of low stock (stock at or below reorder level)
SELECT
    p.product_name,
    p.category,
    i.stock_quantity,
    i.reorder_level,
    s.supplier_name,
    s.contact_email,
    CASE
        WHEN i.stock_quantity = 0              THEN 'OUT OF STOCK'
        WHEN i.stock_quantity <= i.reorder_level THEN 'REORDER NOW'
        WHEN i.stock_quantity <= i.reorder_level * 1.5 THEN 'LOW — MONITOR'
        ELSE 'OK'
    END AS stock_status
FROM inventory i
JOIN products  p ON i.product_id  = p.product_id
LEFT JOIN suppliers s ON i.supplier_id = s.supplier_id
ORDER BY
    CASE
        WHEN i.stock_quantity = 0 THEN 1
        WHEN i.stock_quantity <= i.reorder_level THEN 2
        ELSE 3
    END,
    i.stock_quantity ASC;

-- Q8: Most restocked products (supplier activity)
SELECT
    p.product_name,
    s.supplier_name,
    COUNT(il.log_id)             AS restock_events,
    SUM(il.change_quantity)      AS total_units_restocked
FROM inventory_log il
JOIN products  p ON il.product_id  = p.product_id
JOIN inventory i ON p.product_id   = i.product_id
LEFT JOIN suppliers s ON i.supplier_id = s.supplier_id
WHERE il.reason = 'Supplier Restock'
GROUP BY p.product_name, s.supplier_name
ORDER BY total_units_restocked DESC;


/* =========================================
   SECTION 4: ORDER & PAYMENT ANALYSIS
   ========================================= */

-- Q9: Orders with outstanding or failed payments
SELECT
    o.order_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    o.order_date,
    o.order_status,
    p.payment_status,
    p.amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status != 'Cancelled'
  AND (p.payment_status != 'Paid' OR p.payment_id IS NULL)
ORDER BY o.order_date;

-- Q10: Revenue by payment method
SELECT
    p.payment_method,
    COUNT(p.payment_id)          AS transaction_count,
    SUM(p.amount)                AS total_collected,
    ROUND(AVG(p.amount), 2)      AS avg_transaction_value
FROM payments p
WHERE p.payment_status = 'Paid'
GROUP BY p.payment_method
ORDER BY total_collected DESC;


/* =========================================
   SECTION 5: ADVANCED — CTEs & WINDOW FUNCTIONS
   ========================================= */

-- Q11: Running total of revenue over time (cumulative)
WITH daily_revenue AS (
    SELECT
        CAST(o.order_date AS DATE)       AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS daily_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY CAST(o.order_date AS DATE)
)
SELECT
    sale_date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY sale_date ROWS UNBOUNDED PRECEDING) AS cumulative_revenue
FROM daily_revenue
ORDER BY sale_date;

-- Q12: Product performance vs category average (using window functions)
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS product_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders   o ON oi.order_id   = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT
    product_name,
    category,
    product_revenue,
    ROUND(AVG(product_revenue) OVER (PARTITION BY category), 2) AS category_avg_revenue,
    ROUND(product_revenue - AVG(product_revenue) OVER (PARTITION BY category), 2) AS vs_category_avg,
    RANK() OVER (PARTITION BY category ORDER BY product_revenue DESC) AS rank_within_category
FROM product_revenue
ORDER BY category, rank_within_category;

-- Q13: Month-over-month revenue growth
WITH monthly AS (
    SELECT
        FORMAT(o.order_date, 'yyyy-MM')          AS order_month,
        SUM(oi.quantity * oi.unit_price)         AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY FORMAT(o.order_date, 'yyyy-MM')
)
SELECT
    order_month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
    ROUND(
        (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY order_month))
        * 100.0
        / NULLIF(LAG(monthly_revenue) OVER (ORDER BY order_month), 0),
    2) AS mom_growth_pct
FROM monthly
ORDER BY order_month;

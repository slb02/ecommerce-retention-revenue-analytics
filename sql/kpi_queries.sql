-- 1. Executive KPI summary
SELECT
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS average_order_value,
    ROUND(SUM(profit), 2) AS total_profit
FROM ecommerce_analytics.fact_orders;

-- 2. Monthly revenue trend
SELECT
    order_month,
    ROUND(SUM(sales), 2) AS monthly_revenue
FROM ecommerce_analytics.fact_orders
GROUP BY order_month
ORDER BY order_month;

-- 3. Monthly orders trend
SELECT
    order_month,
    COUNT(DISTINCT order_id) AS monthly_orders
FROM ecommerce_analytics.fact_orders
GROUP BY order_month
ORDER BY order_month;

-- 4. Revenue by category
SELECT
    p.category,
    ROUND(SUM(f.sales), 2) AS total_revenue,
    ROUND(SUM(f.profit), 2) AS total_profit
FROM ecommerce_analytics.fact_orders f
JOIN ecommerce_analytics.dim_products p
    ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 5. Revenue by region
SELECT
    c.region,
    ROUND(SUM(f.sales), 2) AS total_revenue,
    ROUND(SUM(f.profit), 2) AS total_profit
FROM ecommerce_analytics.fact_orders f
JOIN ecommerce_analytics.dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_revenue DESC;
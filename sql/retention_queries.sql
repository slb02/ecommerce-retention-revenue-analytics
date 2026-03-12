-- 1. Repeat purchase rate
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM ecommerce_analytics.fact_orders
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE total_orders >= 2) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE total_orders >= 2) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_purchase_rate_pct
FROM customer_orders;

-- 2. Churn rate using 90-day inactivity rule
WITH max_date AS (
    SELECT MAX(order_date) AS max_order_date
    FROM ecommerce_analytics.fact_orders
),
customer_last_order AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_order_date
    FROM ecommerce_analytics.fact_orders
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
    ) AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customer_last_order;

-- 3. Retention metrics by segment
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        MAX(order_date) AS last_order_date,
        SUM(sales) AS total_revenue
    FROM ecommerce_analytics.fact_orders
    GROUP BY customer_id
),
max_date AS (
    SELECT MAX(order_date) AS max_order_date
    FROM ecommerce_analytics.fact_orders
)
SELECT
    c.segment,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE co.total_orders >= 2) AS repeat_customers,
    COUNT(*) FILTER (
        WHERE co.last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
    ) AS churned_customers,
    ROUND(AVG(co.total_revenue), 2) AS avg_customer_revenue,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE co.total_orders >= 2) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_purchase_rate_pct,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE co.last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customer_orders co
JOIN ecommerce_analytics.dim_customers c
    ON co.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY c.segment;

-- 4. Retention metrics by region
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        MAX(order_date) AS last_order_date,
        SUM(sales) AS total_revenue
    FROM ecommerce_analytics.fact_orders
    GROUP BY customer_id
),
max_date AS (
    SELECT MAX(order_date) AS max_order_date
    FROM ecommerce_analytics.fact_orders
)
SELECT
    c.region,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE co.total_orders >= 2) AS repeat_customers,
    COUNT(*) FILTER (
        WHERE co.last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
    ) AS churned_customers,
    ROUND(AVG(co.total_revenue), 2) AS avg_customer_revenue,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE co.total_orders >= 2) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_purchase_rate_pct,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE co.last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customer_orders co
JOIN ecommerce_analytics.dim_customers c
    ON co.customer_id = c.customer_id
GROUP BY c.region
ORDER BY c.region;
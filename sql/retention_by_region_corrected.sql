WITH customer_order_stats AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        MAX(order_date) AS last_order_date,
        SUM(sales) AS total_revenue
    FROM ecommerce_analytics.fact_orders
    GROUP BY customer_id
),
latest_customer_region AS (
    SELECT DISTINCT ON (s.customer_id)
        s.customer_id,
        s.region,
        s.order_date,
        s.order_id
    FROM ecommerce_analytics.stg_superstore_orders s
    ORDER BY s.customer_id, s.order_date DESC, s.order_id DESC
),
max_date AS (
    SELECT MAX(order_date) AS max_order_date
    FROM ecommerce_analytics.fact_orders
)
SELECT
    lcr.region,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE cos.total_orders >= 2) AS repeat_customers,
    COUNT(*) FILTER (
        WHERE cos.last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
    ) AS churned_customers,
    ROUND(AVG(cos.total_revenue), 2) AS avg_customer_revenue,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE cos.total_orders >= 2) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_purchase_rate_pct,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE cos.last_order_date < (SELECT max_order_date - INTERVAL '90 days' FROM max_date)
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customer_order_stats cos
JOIN latest_customer_region lcr
    ON cos.customer_id = lcr.customer_id
GROUP BY lcr.region
ORDER BY lcr.region;
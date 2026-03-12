-- Customers appearing in more than one region
SELECT
    customer_id,
    COUNT(DISTINCT region) AS distinct_region_count,
    STRING_AGG(DISTINCT region, ', ' ORDER BY region) AS regions
FROM ecommerce_analytics.stg_superstore_orders
GROUP BY customer_id
HAVING COUNT(DISTINCT region) > 1
ORDER BY distinct_region_count DESC, customer_id;

-- How many such customers exist
SELECT
    COUNT(*) AS customers_with_multiple_regions
FROM (
    SELECT
        customer_id
    FROM ecommerce_analytics.stg_superstore_orders
    GROUP BY customer_id
    HAVING COUNT(DISTINCT region) > 1
) t;

-- Customers appearing in more than one city
SELECT
    COUNT(*) AS customers_with_multiple_cities
FROM (
    SELECT
        customer_id
    FROM ecommerce_analytics.stg_superstore_orders
    GROUP BY customer_id
    HAVING COUNT(DISTINCT city) > 1
) t;
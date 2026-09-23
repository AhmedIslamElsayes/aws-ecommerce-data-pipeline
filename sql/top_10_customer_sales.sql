SELECT
    SUM(total_sales) AS total_sales,
    SUM(
        CASE
            WHEN customer_rank <= 10 THEN total_sales
            ELSE 0
        END
    ) AS top_10_sales
FROM (
    SELECT
        total_sales,
        ROW_NUMBER() OVER (
            ORDER BY total_sales DESC
        ) AS customer_rank
    FROM ecommerce_analytics.gold_customer_sales
) t;

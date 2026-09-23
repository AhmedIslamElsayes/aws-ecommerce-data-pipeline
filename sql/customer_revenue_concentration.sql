WITH customer_ranked AS (
    SELECT
        customerid,
        firstname,
        lastname,
        total_sales,
        SUM(total_sales) OVER () AS overall_sales,
        ROW_NUMBER() OVER (
            ORDER BY total_sales DESC
        ) AS customer_rank,
        COUNT(*) OVER () AS total_customers
    FROM ecommerce_analytics.gold_customer_sales
)

SELECT
    customerid,
    firstname,
    lastname,
    total_sales,
    customer_rank,
    total_customers,
    ROUND(
        100.0 * total_sales / overall_sales,
        2
    ) AS revenue_share_percent
FROM customer_ranked
ORDER BY customer_rank;

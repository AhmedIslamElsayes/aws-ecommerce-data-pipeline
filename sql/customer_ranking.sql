SELECT
    customerid,
    total_sales,
    ROW_NUMBER() OVER (
        ORDER BY total_sales DESC
    ) AS customer_rank,
    COUNT(*) OVER () AS total_customers
FROM ecommerce_analytics.gold_customer_sales;

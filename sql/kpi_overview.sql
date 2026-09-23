SELECT
    CAST(SUM(total_sales) AS DECIMAL(18,2)) AS total_sales,
    SUM(total_orders) AS total_orders,
    SUM(total_quantity) AS total_quantity,
    COUNT(*) AS customer_count,
    CAST(
        SUM(total_sales) / NULLIF(SUM(total_orders), 0)
        AS DECIMAL(18,2)
    ) AS average_order_value
FROM ecommerce_analytics.gold_customer_sales;

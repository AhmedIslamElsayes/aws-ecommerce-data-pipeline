SELECT
    customerid,
    firstname,
    lastname,
    total_sales,
    total_orders
FROM ecommerce_analytics.gold_customer_sales
ORDER BY total_sales DESC
LIMIT 10;

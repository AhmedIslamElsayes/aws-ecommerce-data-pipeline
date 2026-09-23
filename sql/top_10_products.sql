SELECT
    productid,
    productname,
    categoryname,
    total_sales,
    total_quantity,
    total_orders
FROM ecommerce_analytics.gold_product_sales
ORDER BY total_sales DESC
LIMIT 10;

CREATE TABLE ecommerce_analytics.gold_category_sales
WITH (
    format = 'PARQUET',
    write_compression = 'SNAPPY',
    external_location = 's3://ahmed-data-bucket-2026-new/gold/ecommerce/category_sales/'
)
AS
SELECT
    p.categoryname,
    SUM(f.quantity) AS total_quantity,
    SUM(f.total_amount) AS total_sales,
    COUNT(DISTINCT f.order_sk) AS total_orders,
    COUNT(DISTINCT p.productid) AS total_products
FROM ecommerce_analytics.fact_sales f
JOIN ecommerce_analytics.dim_product p
    ON f.product_sk = p.product_sk
GROUP BY
    p.categoryname;

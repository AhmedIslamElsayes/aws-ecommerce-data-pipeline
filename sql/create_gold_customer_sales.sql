CREATE TABLE ecommerce_analytics.gold_customer_sales
WITH (
    format = 'PARQUET',
    write_compression = 'SNAPPY',
    external_location = 's3://ahmed-data-bucket-2026-new/gold/ecommerce/customer_sales/'
)
AS
SELECT
    c.customer_sk,
    c.customerid,
    c.firstname,
    c.lastname,
    SUM(f.quantity) AS total_quantity,
    SUM(f.total_amount) AS total_sales,
    COUNT(DISTINCT f.order_sk) AS total_orders
FROM ecommerce_analytics.fact_sales f
JOIN ecommerce_analytics.dim_customer c
    ON f.customer_sk = c.customer_sk
GROUP BY
    c.customer_sk,
    c.customerid,
    c.firstname,
    c.lastname;

CREATE TABLE ecommerce_analytics.gold_monthly_sales
WITH (
    format = 'PARQUET',
    write_compression = 'SNAPPY',
    external_location = 's3://ahmed-data-bucket-2026-new/gold/ecommerce/monthly_sales/'
)
AS
SELECT
    d.year,
    d.month,
    CAST(SUM(f.total_amount) AS DECIMAL(18,2)) AS total_sales,
    SUM(f.quantity) AS total_quantity,
    COUNT(DISTINCT f.order_sk) AS total_orders
FROM ecommerce_analytics.fact_sales f
JOIN ecommerce_analytics.dim_date d
    ON f.date_sk = d.date_sk
GROUP BY
    d.year,
    d.month
ORDER BY
    d.year,
    d.month;

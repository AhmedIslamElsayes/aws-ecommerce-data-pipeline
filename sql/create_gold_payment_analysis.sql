CREATE TABLE ecommerce_analytics.gold_payment_analysis
WITH (
    format = 'PARQUET',
    write_compression = 'SNAPPY',
    external_location = 's3://ahmed-data-bucket-2026-new/gold/ecommerce/payment_analysis/'
)
AS
SELECT
    paymentmethod,
    COUNT(paymentid) AS total_transactions,
    SUM(amount) AS total_payment_amount,
    AVG(amount) AS average_payment_amount
FROM ecommerce_analytics.fact_payments
GROUP BY
    paymentmethod;

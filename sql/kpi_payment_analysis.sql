SELECT
    paymentmethod,
    COUNT(paymentid) AS total_transactions,
    CAST(SUM(amount) AS DECIMAL(18,2)) AS total_payment_amount,
    CAST(AVG(amount) AS DECIMAL(18,2)) AS average_payment_amount
FROM ecommerce_analytics.fact_payments
GROUP BY paymentmethod
ORDER BY total_payment_amount DESC;

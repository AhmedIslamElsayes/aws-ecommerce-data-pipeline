SELECT
    year,
    month,
    total_sales,

    LAG(total_sales) OVER (
        ORDER BY year, month
    ) AS previous_month_sales,

    ROUND(
        100.0 *
        (total_sales - LAG(total_sales) OVER (
            ORDER BY year, month
        ))
        / LAG(total_sales) OVER (
            ORDER BY year, month
        ),
        2
    ) AS mom_growth_percent

FROM ecommerce_analytics.gold_monthly_sales
ORDER BY
    year,
    month;

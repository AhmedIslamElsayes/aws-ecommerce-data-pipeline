SELECT
    categoryname,
    total_sales,
    ROUND(
        100.0 * total_sales /
        SUM(total_sales) OVER (),
        2
    ) AS sales_share_percent
FROM ecommerce_analytics.gold_category_sales
ORDER BY total_sales DESC;

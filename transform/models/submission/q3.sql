{{
    config(
        materialized='view'
    )
}}

WITH cte AS(
SELECT o.country_name, vendor_name, ROUND(SUM(gmv_local),2) AS total_gmv,
RANK() OVER(PARTITION BY o.country_name ORDER BY SUM(gmv_local) DESC) AS gmv_ranking
FROM query-424808.Orders.orders o
LEFT JOIN query-424808.Vendors.vendors v ON o.vendor_id = v.id
GROUP BY o.country_name, vendor_name)

SELECT country_name, vendor_name, total_gmv
FROM cte
WHERE gmv_ranking = 1
ORDER BY country_name;

{{
    config(
        materialized='view'
    )
}}

WITH cte AS(
SELECT date_local, EXTRACT(YEAR FROM date_local) AS year, o.country_name, vendor_name, ROUND(SUM(gmv_local),2) AS total_gmv,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM date_local), o.country_name ORDER BY ROUND(SUM(gmv_local),2) DESC) AS ranking
FROM query-424808.Orders.orders o
LEFT JOIN query-424808.Vendors.vendors v ON o.vendor_id = v.id
GROUP BY date_local, EXTRACT(YEAR FROM date_local), o.country_name, vendor_name)

SELECT CONCAT(year, '-01-01T00:00:00') AS year, country_name, vendor_name, total_gmv
FROM cte
WHERE ranking <=2
ORDER BY year, country_name, ranking

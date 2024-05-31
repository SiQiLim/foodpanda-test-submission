{{
    config(
        materialized='view'
    )
}}

SELECT country_name, ROUND(SUM(gmv_local),2) AS total_gmv
FROM `query-424808.Orders.orders` 
GROUP BY country_name

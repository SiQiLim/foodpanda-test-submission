{{
    config(
        materialized='view'
    )
}}

SELECT vendor_name, COUNT(vendor_name) AS customer_count, SUM(gmv_local) AS total_gmv
FROM query-424808.Orders.orders o
LEFT JOIN query-424808.Vendors.vendors v ON o.vendor_id = v.id
WHERE o.country_name = "Taiwan"
GROUP BY vendor_name
ORDER BY customer_count DESC

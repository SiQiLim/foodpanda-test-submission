{{
    config(
        materialized='view'
    )
}}

SELECT 
    vendor_name, 
    COUNT(vendor_name) AS customer_count, 
    SUM(gmv_local) AS total_gmv
FROM 
    {{ ref('Orders.orders') }} o
LEFT JOIN 
    {{ ref('Vendors.vendors') }} v ON o.vendor_id = v.id
WHERE 
    o.country_name = 'Taiwan'  -- Use single quotes for string literals in SQL
GROUP BY 
    vendor_name
ORDER BY 
    customer_count DESC;

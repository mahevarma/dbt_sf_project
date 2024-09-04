{{ config(materialized="table") }}

with temp_products as(

    select * from {{ref("stg_products")}}
),

temp_order_items as(

    select * from {{ref("stg_order_items")}}
),

temp_orders as(

    select * from {{ref("stg_orders")}}
)

SELECT 
    temp_products.category,
    SUM((temp_order_items.sale_price) * (temp_orders.num_of_item)) AS TotalRevenue
FROM 
    temp_orders
JOIN
    temp_order_items ON temp_orders.order_id = temp_order_items.order_id
JOIN 
    temp_products ON temp_order_items.product_id = temp_products.product_id

WHERE 
    temp_order_items.status NOT IN ('Cancelled', 'Returned')
GROUP BY 
    temp_products.category
ORDER BY 
    TotalRevenue DESC
LIMIT 5

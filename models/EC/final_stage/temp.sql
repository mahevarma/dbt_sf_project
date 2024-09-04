{{ config(materialized="table") }}

with temp_products as(

    select * from {{ref("stg_products")}}
),

temp_order_items as(

    select * from {{ref("stg_order_items")}}
),

temp_orders as(

    select * from {{ref("stg_orders")}}
),

final as(

SELECT 
    p.category,
    SUM (oi.sale_price * o.num_of_item) AS TotalRevenue
FROM 
    temp_orders o
JOIN
    temp_order_items oi ON o.order_id = oi.order_id
JOIN 
    temp_products p ON oi.product_id = p.product_id

WHERE 
    oi.status NOT IN ('Cancelled', 'Returned')
GROUP BY 
    p.category
ORDER BY 
    TotalRevenue DESC
LIMIT 5
)

select * from final
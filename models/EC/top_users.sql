{{ config(materialized="table") }}

with temp_user as(

    select * from {{ref("stg_users")}}
),

temp_order_items as(

    select * from {{ref("stg_order_items")}}
),

temp_orders as(

    select * from {{ref("stg_orders")}}
),

UserSpending as(

    SELECT
        first_name,
        last_name,
        SUM(sale_price) AS TotalAmountSpent
        from 
        temp_user join temp_order_items
        on 
        temp_user.user_id = temp_order_items.user_id 
        join 
        temp_orders
        on temp_orders.order_id = temp_order_items.order_id
        WHERE
        temp_orders.status NOT IN ('Cancelled', 'Returned')
    GROUP BY
        first_name, last_name
)


SELECT
    first_name,
    last_name,
    TotalAmountSpent
FROM
    UserSpending
ORDER BY
    TotalAmountSpent DESC
LIMIT 5
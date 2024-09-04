{{ config(materialized="table") }}

with temp_orderitems as(

    select * from {{ref("stg_order_items")}}

),

RankedOrders as(

        select 
        Order_Id,
        Product_Id,
        Created_At,
        ROW_NUMBER() OVER (PARTITION BY Order_Id, Product_Id ORDER BY Created_At DESC) AS rn
    FROM temp_orderitems
 
)

select order_id,product_id,created_at FROM temp_orderitems
WHERE EXISTS (
    SELECT 1
    FROM RankedOrders
    WHERE RankedOrders.Order_Id = temp_orderitems.Order_Id And
          RankedOrders.Product_Id = temp_orderitems.Product_Id And
          RankedOrders.Created_At = temp_orderitems.Created_At And
          RankedOrders.rn > 1
)

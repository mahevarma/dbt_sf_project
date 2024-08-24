{{ config(materialized="table") }}

with
    stg_order_item as (

        select
            id as order_item_id,
            product_id,
            inventory_item_id,
            sale_price
            order_id,
            user_id,
            status,
            gender,
            num_of_item,  -- ordered_at, returned_at, shipped_at, delivered_at

            cast(substring('created_at', 1, 18) as datetime),
            cast(substring('returned_at', 1, 18) as datetime),
            cast(substring('shipped_at', 1, 18) as datetime),
            cast(substring('delivered_at', 1, 18) as datetime)

        from {{ source("src_ec", "order_items") }}

    )

select *
from stg_order_item

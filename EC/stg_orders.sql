{{ config(materialized="table") }}

with
    order_data as (

        select
            order_id,
            user_id,
            status,
            gender,
            num_of_item,  -- ordered_at, returned_at, shipped_at, delivered_at

            cast(substring('ordered_at', 1, 18) as datetime),
            cast(substring('returned_at', 1, 18) as datetime),
            cast(substring('shipped_at', 1, 18) as datetime),
            cast(substring('delivered_at', 1, 18) as datetime)

        from {{ source('src_ec','orders')}}

    )

select *
from order_data

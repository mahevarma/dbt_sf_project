{{ config(materialized="table") }}



        select
            order_id,
            user_id,
            status,
            gender,
            num_of_item, 

            cast(substring('ordered_at', 1, 18) as datetime) as ordered_at,
            cast(substring('returned_at', 1, 18) as datetime) as returned_at,
            cast(substring('shipped_at', 1, 18) as datetime) as shipped_at,
            cast(substring('delivered_at', 1, 18) as datetime) as delivered_at

        from {{ source('src_ec','orders')}}

  

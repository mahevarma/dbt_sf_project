{{ config(materialized="table") }}



        select
            id as order_item_id,
            product_id,
            sale_price,
            order_id,
            user_id,
            status,
            
            cast(substring(created_at, 1, 18) as datetime) as created_at,
            cast(substring(returned_at, 1, 18) as datetime) as returned_at,
            cast(substring(shipped_at, 1, 18) as datetime) as shipped_at,
            cast(substring(delivered_at, 1, 18) as datetime) as delivered_at

        from {{ source("src_ec", "order_items") }}

  
